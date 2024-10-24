<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Eliminar Usuario</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.6.0/css/bootstrap.min.css">
</head>
<body>
    <div class="container mt-5">
        <h2>Eliminar Usuario</h2>

        <c:set var="dbURL" value="jdbc:mysql://localhost:3306/gestorproyectosdegrado" />
        <c:set var="dbUser" value="root" />
        <c:set var="dbPass" value="" />

        <sql:setDataSource var="ds" driver="com.mysql.jdbc.Driver" 
            url="${dbURL}" user="${dbUser}" password="${dbPass}" />

        <c:choose>
            <c:when test="${not empty param.type and not empty param.id}">
                <c:set var="userType" value="${param.type}" />
                <c:set var="userId" value="${param.id}" />

                <!-- Mensajes de depuración -->
                <div class="alert alert-info">
                    <strong>Parámetros recibidos:</strong><br>
                    Tipo de usuario: <c:out value="${userType}" /><br>
                    ID del usuario: <c:out value="${userId}" />
                </div>

                <c:choose>
                    <c:when test="${userType == 'estudiante'}">
                        <sql:update dataSource="${ds}">
                            DELETE FROM estudiante WHERE id = ?;
                            <sql:param value="${userId}" />
                        </sql:update>
                    </c:when>
                    <c:when test="${userType == 'docente'}">
                        <sql:update dataSource="${ds}">
                            DELETE FROM docente WHERE id = ?;
                            <sql:param value="${userId}" />
                        </sql:update>
                    </c:when>
                    <c:when test="${userType == 'coordinador'}">
                        <sql:update dataSource="${ds}">
                            DELETE FROM coordinador WHERE id = ?;
                            <sql:param value="${userId}" />
                        </sql:update>
                    </c:when>
                </c:choose>

                <div class="alert alert-success">
                    Usuario eliminado con éxito.
                </div>
                <a href="gestionarUsuarios.jsp" class="btn btn-primary mt-3">Volver a la gestión de usuarios</a>
            </c:when>
            <c:otherwise>
                <div class="alert alert-danger">
                    <strong>Error:</strong> No se pudo eliminar el usuario. Parámetros inválidos.
                    <br>
                    Tipo de usuario: <c:out value="${param.type}" /><br>
                    ID del usuario: <c:out value="${param.id}" />
                </div>
                <a href="gestionarUsuarios.jsp" class="btn btn-primary mt-3">Volver a la gestión de usuarios</a>
            </c:otherwise>
        </c:choose>
    </div>
</body>
</html>

