<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page session="true" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login Administrador</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.6.0/css/bootstrap.min.css">
</head>
<body>
    <div class="container mt-5">
        <h2>Login Administrador</h2>

        <c:set var="dbURL" value="jdbc:mysql://localhost:3306/gestorproyectosdegrado" />
        <c:set var="dbUser" value="root" />
        <c:set var="dbPass" value="" />

        <c:set var="dbURL" value="jdbc:mysql://sql10.freemysqlhosting.net/sql10740380" />
        <c:set var="dbUser" value="sql10740380" />
        <c:set var="dbPass" value="n8vKQHWRKN" />

        <sql:setDataSource var="ds" driver="com.mysql.jdbc.Driver" 
            url="${dbURL}" user="${dbUser}" password="${dbPass}" />

        <c:choose>
            <c:when test="${not empty param.correo and not empty param.password}">
                <sql:query dataSource="${ds}" var="result">
                    SELECT * FROM administrador WHERE Correo = ? AND password = ?;
                    <sql:param value="${param.correo}" />
                    <sql:param value="${param.password}" />
                </sql:query>

                <c:if test="${not empty result.rows}">
                    <c:set var="isValidUser" value="true" />
                    <c:set var="adminCorreo" value="${param.correo}" />
                    <c:redirect url="../adminDashboard.jsp" />
                </c:if>

                <c:if test="${empty result.rows}">
                    <script>
                        alert('Credenciales incorrectas, intenta nuevamente');
                        window.location.href = 'loginAdmin.jsp';
                    </script>
                </c:if>
            </c:when>
            <c:otherwise>
                <form action="loginAdmin.jsp" method="post">
                    <div class="form-group">
                        <label for="correo">Correo:</label>
                        <input type="email" class="form-control" id="correo" name="correo" required>
                    </div>
                    <div class="form-group">
                        <label for="password">Password:</label>
                        <input type="password" class="form-control" id="password" name="password" required>
                    </div>
                    <button type="submit" class="btn btn-primary">Login</button>
                </form>
            </c:otherwise>
        </c:choose>
    </div>
</body>
</html>

