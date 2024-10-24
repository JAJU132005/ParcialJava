<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%-- Configuración de la base de datos --%>
<sql:setDataSource var="ds" driver="com.mysql.jdbc.Driver"
    url="jdbc:mysql://localhost:3306/gestorproyectosdegrado"
    user="root" password="" />

<%-- Obtener los datos del formulario --%>
<c:set var="nombre" value="${param.nombre}" />
<c:set var="correo" value="${param.correo}" />
<c:set var="password" value="${param.password}" />
<c:set var="programa" value="${param.programa}" />
<c:set var="tipoUsuario" value="${param.tipo_usuario}" />

<%-- Consulta SQL variable según el tipo de usuario --%>
<c:choose>
    <c:when test="${tipoUsuario == 'coordinador'}">
        <sql:update dataSource="${ds}">
            INSERT INTO coordinador (nombre, correo, password, id_programa)
            VALUES (?, ?, ?, ?)
            <sql:param value="${nombre}" />
            <sql:param value="${correo}" />
            <sql:param value="${password}" />
            <sql:param value="${programa}" />
        </sql:update>
    </c:when>
    <c:when test="${tipoUsuario == 'docente'}">
        <sql:update dataSource="${ds}">
            INSERT INTO docente (nombre, correo, password, id_programa)
            VALUES (?, ?, ?, ?)
            <sql:param value="${nombre}" />
            <sql:param value="${correo}" />
            <sql:param value="${password}" />
            <sql:param value="${programa}" />
        </sql:update>
    </c:when>
    <c:when test="${tipoUsuario == 'estudiante'}">
        <sql:update dataSource="${ds}">
            INSERT INTO estudiante (nombre, correo, password, id_programa)
            VALUES (?, ?, ?, ?)
            <sql:param value="${nombre}" />
            <sql:param value="${correo}" />
            <sql:param value="${password}" />
            <sql:param value="${programa}" />
        </sql:update>
    </c:when>
</c:choose>

<%-- Mostrar un mensaje de éxito --%>
<h3>Registro exitoso de ${tipoUsuario}!</h3>
