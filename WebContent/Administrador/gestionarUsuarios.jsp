<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestión de Usuarios</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.6.0/css/bootstrap.min.css">
    <style>
        /* Estilo de fondo y colores basado en el diseño anterior */
        body {
            background: linear-gradient(135deg, #b2d6a8, #4a7c2d);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        .container {
            background-color: rgba(255, 255, 255, 0.9); /* Fondo semi-transparente */
            padding: 30px;
            border-radius: 20px;
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2);
            max-width: 1000px;
            width: 100%;
            backdrop-filter: blur(5px);
            margin-top: 50px;
        }

        h2 {
            color: #3a5937;
            font-size: 2em;
            margin-bottom: 30px;
            letter-spacing: 1.5px;
            text-align: center;
        }

        label {
            color: #3a5937;
        }

        .form-control {
            border-radius: 10px;
        }

        .btn {
            border-radius: 30px;
            font-size: 1em;
            padding: 5px 15px;
        }

        .btn-danger {
            background-color: #ff5e57;
            border-color: #ff5e57;
            transition: background-color 0.3s ease, transform 0.3s ease;
        }

        .btn-warning {
            background-color: #f39c12;
            border-color: #f39c12;
            transition: background-color 0.3s ease, transform 0.3s ease;
        }

        .btn-danger:hover,
        .btn-warning:hover {
            transform: scale(1.05);
        }

        /* Botón de salida */
        .button-containerE {
            position: absolute;
            top: 20px;
            right: 20px;
        }

        .button {
            background-color: #26a65b;
            border: none;
            color: white;
            padding: 10px 20px;
            font-size: 1em;
            border-radius: 30px;
            cursor: pointer;
            transition: transform 0.3s ease, background-color 0.3s ease;
        }

        .button:hover {
            background-color: #1e8c4a;
            transform: scale(1.05);
        }

        /* Tabla */
        .table {
            margin-top: 20px;
            text-align: center;
        }

        th {
            background-color: #4a7c2d;
            color: white;
        }

        td {
            color: #3a5937;
        }

        /* Ajuste responsivo */
        @media (max-width: 768px) {
            .button-containerE {
                top: 10px;
                right: 10px;
            }
        }
    </style>
</head>
<body>
    

    <div class="container">
        <h2 class="text-center">Gestión de Usuarios</h2>

        <!-- Filtrar Usuarios -->
        <div class="form-group">
            <label for="filter">Filtrar por tipo de usuario:</label>
            <select id="filter" class="form-control" onchange="filterUsers(this.value)">
                <option value="all">Todos</option>
                <option value="estudiante">Estudiantes</option>
                <option value="docente">Docentes</option>
                <option value="coordinador">Coordinadores</option>
            </select>
        </div>

        <!-- Conexión a la base de datos -->
        <sql:setDataSource var="ds" driver="com.mysql.jdbc.Driver" 
            url="jdbc:mysql://localhost:3306/gestorproyectosdegrado?useUnicode=true&characterEncoding=UTF-8" 
            user="root" password=""/>

        <!-- Consulta para obtener estudiantes -->
        <c:catch var="queryErrorEstudiantes">
            <sql:query var="estudiantes" dataSource="${ds}">
                SELECT e.id, e.nombre, 
                    (SELECT p.descripcion FROM programa p WHERE p.id = e.id_programa) AS programa, 
                    e.correo 
                FROM estudiante e;
            </sql:query>
        </c:catch>
        <c:if test="${not empty queryErrorEstudiantes}">
            <div class="alert alert-danger">
                <strong>Error en la consulta de estudiantes:</strong> ${queryErrorEstudiantes.message}
            </div>
        </c:if>

        <!-- Consultar datos de docentes -->
        <sql:query dataSource="${ds}" var="docentes">
            SELECT d.id, d.nombre, 
                (SELECT p.descripcion FROM programa p WHERE p.id = d.id_programa) AS programa, 
                d.correo 
            FROM docente d;
        </sql:query>

        <!-- Consultar datos de coordinadores -->
        <sql:query dataSource="${ds}" var="coordinadores">
            SELECT c.id, c.nombre, 
                (SELECT p.descripcion FROM programa p WHERE p.id = c.id_programa) AS programa, 
                c.correo 
            FROM coordinador c;
        </sql:query>

        <!-- Mostrar usuarios en una tabla -->
        <table class="table table-bordered table-hover">
            <thead>
                <tr>
                    <th>Acciones</th>
                    <th>Nombre</th>
                    <th>Programa</th>
                    <th>Correo</th>
                    <th>Tipo</th>
                </tr>
            </thead>
            <tbody id="userTable">

                <!-- Mostrar Estudiantes -->
                <c:forEach var="user" items="${estudiantes.rows}">
                    <tr data-type="estudiante">
                        <td>
                            <a href="deleteUser.jsp?type=estudiante&id=${user.id}" class="btn btn-danger btn-sm">Eliminar</a>
                            <a href="editarUsuario.jsp?id=${user.id}&tipo=estudiante" class="btn btn-warning btn-sm">Editar</a>
                        </td>
                        <td>${user.nombre}</td>
                        <td>${user.programa}</td>
                        <td>${user.correo}</td>
                        <td>Estudiante</td>
                    </tr>
                </c:forEach>

                <!-- Mostrar Docentes -->
                <c:forEach var="user" items="${docentes.rows}">
                    <tr data-type="docente">
                        <td>
                            <a href="deleteUser.jsp?type=docente&id=${user.id}" class="btn btn-danger btn-sm">Eliminar</a>
                            <a href="editarUsuario.jsp?id=${user.id}&tipo=docente" class="btn btn-warning btn-sm">Editar</a>
                        </td>
                        <td>${user.nombre}</td>
                        <td>${user.programa}</td>
                        <td>${user.correo}</td>
                        <td>Docente</td>
                    </tr>
                </c:forEach>

                <!-- Mostrar Coordinadores -->
                <c:forEach var="user" items="${coordinadores.rows}">
                    <tr data-type="coordinador">
                        <td>
                            <a href="deleteUser.jsp?type=coordinador&id=${user.id}" class="btn btn-danger btn-sm">Eliminar</a>
                            <a href="editarUsuario.jsp?id=${user.id}&tipo=coordinador" class="btn btn-warning btn-sm">Editar</a>
                        </td>
                        <td>${user.nombre}</td>
                        <td>${user.programa}</td>
                        <td>${user.correo}</td>
                        <td>Coordinador</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
    <div class="button-containerE">
        <button class="btn btn-primary" onclick="window.location.href='adminDashboard.jsp'">Salir</button>
    </div>
</body>
</html>
