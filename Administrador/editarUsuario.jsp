<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Editar Usuario</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.6.0/css/bootstrap.min.css">
</head>
<body>
    <div class="container mt-5">
        <h2>Editar Usuario</h2>

        <sql:setDataSource var="ds" driver="com.mysql.jdbc.Driver" 
            url="jdbc:mysql://localhost:3306/gestorproyectosdegrado?useUnicode=true&characterEncoding=UTF-8" 
            user="root" password=""/>

        <c:choose>
            <c:when test="${not empty param.id}">
                <c:set var="userId" value="${param.id}" />
                <c:set var="userType" value="${param.tipo}" />

                <!-- Mensajes de depuración -->
                <c:out value="ID del usuario: ${userId}" /><br>
                <c:out value="Tipo de usuario: ${userType}" /><br>

                <c:choose>
                    <c:when test="${userType == 'estudiante'}">
                        <sql:query dataSource="${ds}" var="user">
                            SELECT e.id, e.nombre, e.id_programa, e.correo 
                            FROM estudiante e WHERE e.id = ?;
                            <sql:param value="${userId}" />
                        </sql:query>
                    </c:when>
                    <c:when test="${userType == 'docente'}">
                        <sql:query dataSource="${ds}" var="user">
                            SELECT d.id, d.nombre, d.id_programa, d.correo 
                            FROM docente d WHERE d.id = ?;
                            <sql:param value="${userId}" />
                        </sql:query>
                    </c:when>
                    <c:when test="${userType == 'coordinador'}">
                        <sql:query dataSource="${ds}" var="user">
                            SELECT c.id, c.nombre, c.id_programa, c.correo 
                            FROM coordinador c WHERE c.id = ?;
                            <sql:param value="${userId}" />
                        </sql:query>
                    </c:when>
                </c:choose>

                <c:if test="${empty user.rows}">
                    <div class="alert alert-danger">Usuario no encontrado.</div>
                </c:if>

                <c:if test="${not empty user.rows}">
                    <form action="editarUsuario.jsp" method="post">
                        <input type="hidden" name="id" value="${user.rows[0].id}">
                        <input type="hidden" name="tipo" value="${userType}">
                        <div class="form-row">
                            <div class="col">
                                <label>Nombre:</label>
                                <input type="text" name="nombre" value="${user.rows[0].nombre}" class="form-control" required>
                            </div>
                            <div class="col">
                                <label>Programa:</label>
                                <input type="text" name="programa" value="${user.rows[0].id_programa}" class="form-control" required>
                            </div>
                            <div class="col">
                                <label>Correo:</label>
                                <input type="email" name="correo" value="${user.rows[0].correo}" class="form-control" required>
                            </div>
                            <div class="col">
                                <label>Nuevo Password:</label>
                                <input type="password" name="password" placeholder="Nuevo password" class="form-control">
                            </div>
                        </div>
                        <button type="submit" class="btn btn-success mt-3">Actualizar</button>
                        <button type="button" class="btn btn-secondary mt-3" onclick="window.location.href='gestionarUsuarios.jsp'">Cancelar</button>
                    </form>
                </c:if>
            </c:when>
            <c:when test="${not empty param.nombre}">
                <!-- Mensajes de depuración -->
                <c:out value="Nombre: ${param.nombre}" /><br>
                <c:out value="Programa: ${param.programa}" /><br>
                <c:out value="Correo: ${param.correo}" /><br>
                <c:out value="Password: ${param.password}" /><br>
                <c:out value="ID: ${param.id}" /><br>
                <c:out value="Tipo: ${param.tipo}" /><br>

                <c:choose>
                    <c:when test="${not empty param.nombre}">
                        <sql:update dataSource="${ds}">
                            UPDATE ${param.tipo}
                            SET nombre = ?, id_programa = ?, correo = ?, password = ?
                            WHERE id = ?;
                            <sql:param value="${param.nombre}" />
                            <sql:param value="${param.programa}" />
                            <sql:param value="${param.correo}" />
                            <sql:param value="${not empty param.password ? param.password : ''}" />
                            <sql:param value="${param.id}" />
                        </sql:update>
                        
                        <!-- Verifica si la actualización fue exitosa -->
                        <c:if test="${not empty param.id}">
                            <div class="alert alert-success">Usuario actualizado con éxito.</div>
                            <a href="gestionarUsuarios.jsp" class="btn btn-primary mt-3">Volver a la gestión de usuarios</a>
                        </c:if>
                    </c:when>
                    <c:otherwise>
                        <div class="alert alert-danger">Error: no se pudo actualizar el usuario.</div>
                    </c:otherwise>
                </c:choose>
            </c:when>
        </c:choose>
    </div>
</body>
</html>