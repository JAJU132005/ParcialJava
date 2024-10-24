<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ver Ideas de Anteproyecto</title>
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
            border-radius: 20px;
            cursor: pointer;
            margin: 5px;
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
        <button class="button" onclick="window.location.href='gestionarIdeasAnteproyecto.jsp'">Salir</button>
    </div>
    <div class="container mt-5">
        <h2>Lista de Ideas de Anteproyecto</h2>

        <!-- Establecer la conexión a la base de datos -->
        <c:set var="dbURL" value="jdbc:mysql://localhost:3306/gestorproyectosdegrado" />
        <c:set var="dbUser" value="root" />
        <c:set var="dbPass" value="" />
        
        <sql:setDataSource var="ds" driver="com.mysql.jdbc.Driver" 
            url="${dbURL}" user="${dbUser}" password="${dbPass}" />

        <!-- Captura el id del proyecto a eliminar -->
        <c:if test="${not empty param.deleteId}">
            <sql:update dataSource="${ds}">
                DELETE FROM proyecto WHERE id = ?;
                <sql:param value="${param.deleteId}" />
            </sql:update>
            <div class="alert alert-success mt-3">El proyecto ha sido eliminado exitosamente.</div>
        </c:if>

        <!-- Consulta para obtener las ideas de anteproyecto -->
        <sql:query var="ideas" dataSource="${ds}">
            SELECT id, titulo, descripcion, estado_idea 
            FROM proyecto WHERE id_coordinador = ?;
            <sql:param value="${sessionScope.userId}" />
        </sql:query>

        <!-- Tabla para mostrar las ideas de anteproyecto -->
        <table class="table table-bordered mt-3">
            <thead>
                <tr>
                    <th>Título</th>
                    <th>Descripción</th>
                    <th>Estado</th>
                    <th>Acciones</th> <!-- Nueva columna para acciones -->
                </tr>
            </thead>
            <tbody>
                <c:forEach var="idea" items="${ideas.rows}">
                    <tr>
                        <td>${idea.titulo}</td>
                        <td>${idea.descripcion}</td>
                        <td>
                            <c:choose>
                                <c:when test="${idea.estado_idea == false}">Sin escoger</c:when>
                                <c:when test="${idea.estado_idea == true}">Escogida</c:when>
                                <c:otherwise>Sin estado</c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <!-- Formulario para eliminar -->
                            <form action="verIdeasAnteproyecto.jsp" method="post" onsubmit="return confirm('¿Estás seguro de que deseas eliminar esta idea?');">
                                <input type="hidden" name="deleteId" value="${idea.id}" />
                                <button type="submit" class="btn btn-danger">Eliminar</button>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</body>
</html>

