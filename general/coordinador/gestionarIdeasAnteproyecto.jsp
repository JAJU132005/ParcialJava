<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestionar Ideas Anteproyecto</title>
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
        <button class="button" onclick="window.location.href='coordinadorDashboard.jsp'">Salir</button>
        <!-- Botón para ver las ideas de anteproyecto -->
        <button class="button" onclick="window.location.href='verIdeasAnteproyecto.jsp'">Ver Ideas de Anteproyecto</button>
    </div>
    
    <div class="container mt-5">
        <h2>Registrar Nueva Idea de Anteproyecto</h2>

        <!-- Formulario para ingresar el título y la descripción -->
        <form action="gestionarIdeasAnteproyecto.jsp" method="post">
            <div class="form-group">
                <label for="titulo">Título del Proyecto:</label>
                <input type="text" name="titulo" id="titulo" class="form-control" required>
            </div>
            <div class="form-group">
                <label for="descripcion">Descripción del Proyecto:</label>
                <textarea name="descripcion" id="descripcion" class="form-control" rows="5" required></textarea>
            </div>
            <button type="submit" class="btn btn-primary">Registrar Proyecto</button>
        </form>
    </div>

    <!-- Establecer la conexión a la base de datos -->
    <c:set var="dbURL" value="jdbc:mysql://localhost:3306/gestorproyectosdegrado" />
    <c:set var="dbUser" value="root" />
    <c:set var="dbPass" value="" />
    
    <sql:setDataSource var="ds" driver="com.mysql.jdbc.Driver" 
        url="${dbURL}" user="${dbUser}" password="${dbPass}" />

    <!-- Captura el id_coordinador de la sesión -->
    <c:set var="idCoordinador" value="${sessionScope.userId}" />

    <!-- Al enviar el formulario, guardamos los datos en la base de datos -->
    <c:if test="${not empty param.titulo and not empty param.descripcion}">
        <sql:update dataSource="${ds}">
            INSERT INTO proyecto (titulo, descripcion, id_coordinador, estado_idea)
            VALUES (?, ?, ?, 0);
            <sql:param value="${param.titulo}" />
            <sql:param value="${param.descripcion}" />
            <sql:param value="${idCoordinador}" />
        </sql:update>

        <div class="alert alert-success mt-3">El proyecto ha sido registrado exitosamente.</div>
    </c:if>
</body>
</html>
