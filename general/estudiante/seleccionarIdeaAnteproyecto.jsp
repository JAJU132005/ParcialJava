<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Escoger Idea de Anteproyecto</title>
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
        <button class="button" onclick="window.location.href='estudianteDashboard.jsp'">Salir</button>
    </div>
    <div class="container mt-5">
        <h2>Escoger Idea de Anteproyecto</h2>

        <!-- Establecer la conexión a la base de datos -->
        <c:set var="dbURL" value="jdbc:mysql://localhost:3306/gestorproyectosdegrado" />
        <c:set var="dbUser" value="root" />
        <c:set var="dbPass" value="" />
        
        <sql:setDataSource var="ds" driver="com.mysql.jdbc.Driver" 
            url="${dbURL}" user="${dbUser}" password="${dbPass}" />

        <!-- Consulta para verificar si el estudiante ya está asignado a un proyecto -->
        <sql:query var="proyectoExistente" dataSource="${ds}">
            SELECT id 
            FROM proyecto 
            WHERE id_estudiante1 = ? OR id_estudiante2 = ?;
            <sql:param value="${sessionScope.userId}" />
            <sql:param value="${sessionScope.userId}" />
        </sql:query>

        <!-- Verificar si el estudiante ya tiene un proyecto -->
        <c:choose>
            <c:when test="${not empty proyectoExistente.rows}">
                <!-- Si el estudiante ya tiene un proyecto asignado -->
                <div class="alert alert-warning mt-3">Ya ha seleccionado una idea de anteproyecto.</div>
            </c:when>

            <c:otherwise>
                <!-- Si el estudiante no tiene un proyecto, mostrar las ideas disponibles -->
                <!-- Consulta para obtener las ideas de anteproyecto con estado 0 -->
                <sql:query var="ideas" dataSource="${ds}">
                    SELECT id, titulo, descripcion 
                    FROM proyecto 
                    WHERE estado_idea = 0;
                </sql:query>

                <!-- Tabla para mostrar las ideas de anteproyecto -->
                <table class="table table-bordered mt-3">
                    <thead>
                        <tr>
                            <th>Título</th>
                            <th>Descripción</th>
                            <th>Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="idea" items="${ideas.rows}">
                            <tr>
                                <td>${idea.titulo}</td>
                                <td>${idea.descripcion}</td>
                                <td>
                                    <form action="seleccionarIdeaAnteproyecto.jsp" method="post">
                                        <input type="hidden" name="id_proyecto" value="${idea.id}">
                                        <button type="submit" class="btn btn-success">Escoger</button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:otherwise>
        </c:choose>

        <!-- Actualización de estado y asignación del estudiante -->
        <c:if test="${not empty param.id_proyecto}">
            <sql:update dataSource="${ds}">
                UPDATE proyecto 
                SET estado_idea = 1, id_estudiante1 = ?
                WHERE id = ?;
                <sql:param value="${sessionScope.userId}" />
                <sql:param value="${param.id_proyecto}" />
            </sql:update>

            <div class="alert alert-success mt-3">Has escogido la idea de anteproyecto exitosamente.</div>
        </c:if>
    </div>
</body>
</html>
