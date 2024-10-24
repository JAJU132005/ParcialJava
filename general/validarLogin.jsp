<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Validar Login</title>
</head>
<body>
    <c:set var="dbURL" value="jdbc:mysql://localhost:3306/gestorproyectosdegrado" />
    <c:set var="dbUser" value="root" />
    <c:set var="dbPass" value="" />

    <sql:setDataSource var="ds" driver="com.mysql.jdbc.Driver" 
        url="${dbURL}" user="${dbUser}" password="${dbPass}" />

    <c:choose>
        <c:when test="${not empty param.correo and not empty param.password and not empty param.tipo}">
            <c:set var="userType" value="${param.tipo}" />
            
            <c:choose>
                <c:when test="${userType == 'estudiante'}">
                    <sql:query dataSource="${ds}" var="result">
                        SELECT id, nombre FROM estudiante WHERE correo = ? AND password = ?;
                        <sql:param value="${param.correo}" />
                        <sql:param value="${param.password}" />
                    </sql:query>
                </c:when>
                <c:when test="${userType == 'docente'}">
                    <sql:query dataSource="${ds}" var="result">
                        SELECT id, nombre FROM docente WHERE correo = ? AND password = ?;
                        <sql:param value="${param.correo}" />
                        <sql:param value="${param.password}" />
                    </sql:query>
                </c:when>
                <c:when test="${userType == 'coordinador'}">
                    <sql:query dataSource="${ds}" var="result">
                        SELECT id, nombre FROM coordinador WHERE correo = ? AND password = ?;
                        <sql:param value="${param.correo}" />
                        <sql:param value="${param.password}" />
                    </sql:query>
                </c:when>
            </c:choose>

            <!-- Si el usuario es válido -->
            <c:if test="${not empty result.rows}">
                <c:set var="isValidUser" value="true" />
                <!-- Guardar id y nombre en la sesión -->
                <c:set var="userId" value="${result.rows[0].id}" scope="session" />
                <c:set var="userNombre" value="${result.rows[0].nombre}" scope="session" />
                <c:set var="userTipo" value="${userType}" scope="session" />
                
                <!-- Redirigir al dashboard según el tipo de usuario -->
                <c:choose>
                    <c:when test="${userType == 'estudiante'}">
                        <c:redirect url="estudiante/estudianteDashboard.jsp" />
                    </c:when>
                    <c:when test="${userType == 'docente'}">
                        <c:redirect url="docente/docenteDashboard.jsp" />
                    </c:when>
                    <c:when test="${userType == 'coordinador'}">
                        <c:redirect url="coordinador/coordinadorDashboard.jsp" />
                    </c:when>
                </c:choose>
            </c:if>

            <!-- Si las credenciales son incorrectas -->
            <c:if test="${empty result.rows}">
                <script>
                    alert('Credenciales incorrectas, intenta nuevamente');
                    window.location.href = 'loginGeneral.jsp';
                </script>
            </c:if>
        </c:when>
    </c:choose>
</body>
</html>

