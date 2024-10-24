<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestionar Anteproyectos</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.6.0/css/bootstrap.min.css">
    <style>
        body {
            background: linear-gradient(135deg, #b2d6a8, #4a7c2d);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            
        }
        .container {
            background-color: #ffffff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            max-width: 900px;
            margin: 0 auto;
        }
        .form-group label {
            font-weight: bold;
        }
        .btn-primary {
            background-color: #007bff;
            border: none;
        }
        .btn-primary:hover {
            background-color: #0056b3;
        }
        .button-containerE {
            display: flex;
            justify-content: flex-end;
            margin-right: 20px;
        }
        .button {
            padding: 10px 20px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .button:hover {
            background-color: #0056b3;
        }
        h2 {
            text-align: center;
            margin-bottom: 20px;
        }
        h4 {
            font-size: 1.2rem;
            color: #343a40;
        }
        textarea[readonly], input[readonly] {
            background-color: #e9ecef;
        }
    </style>
</head>
<body>
    <div class="button-containerE">
        <button class="button" onclick="window.location.href='directorDashboard.jsp'">Salir</button>
    </div>
    <div class="container mt-5">
        <h2>Gestionar Anteproyectos como Director</h2>
        
        <!-- Establecer la conexión a la base de datos -->
        <c:set var="dbURL" value="jdbc:mysql://localhost:3306/gestorproyectosdegrado" />
        <c:set var="dbUser" value="root" />
        <c:set var="dbPass" value="" />

        <sql:setDataSource var="ds" driver="com.mysql.jdbc.Driver" 
            url="${dbURL}" user="${dbUser}" password="${dbPass}" />

        <!-- Consulta para obtener los proyectos donde el usuario logueado es director -->
        <sql:query var="proyectosDirector" dataSource="${ds}">
            SELECT id, titulo 
            FROM proyecto 
            WHERE id_director = ?;
            <sql:param value="${sessionScope.userId}" />
        </sql:query>

        <!-- Tabla para mostrar los proyectos en los que el usuario es director -->
        <table class="table table-bordered mt-3">
            <thead>
                <tr>
                    <th>ID Proyecto</th>
                    <th>Título</th>
                    <th>Acciones</th> <!-- Columna de acciones -->
                </tr>
            </thead>
            <tbody>
                <c:forEach var="proyecto" items="${proyectosDirector.rows}">
                    <tr>
                        <td>${proyecto.id}</td>
                        <td>${proyecto.titulo}</td>
                        <td>
                            <!-- Botón para gestionar el proyecto -->
                            <form action="gestionarDetalleProyecto.jsp" method="get">
                                <input type="hidden" name="id_proyecto" value="${proyecto.id}" />
                                <button type="submit" class="btn btn-primary">Gestionar</button>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <!-- Mensaje si no hay proyectos disponibles como director -->
        <c:if test="${empty proyectosDirector.rows}">
            <div class="alert alert-warning mt-3">No hay proyectos disponibles para gestionar como Director.</div>
        </c:if>
    </div>
</body>
</html>
