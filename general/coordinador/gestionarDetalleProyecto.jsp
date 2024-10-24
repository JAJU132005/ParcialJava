<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestionar Detalle del Proyecto</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.6.0/css/bootstrap.min.css">
    <script>
        // Función para validar que el Director y el Evaluador no sean la misma persona
        function validarFormulario() {
            var director = document.getElementById("id_director").value;
            var evaluador = document.getElementById("id_evaluador").value;

            if (director === evaluador) {
                alert("El Director y el Evaluador no pueden ser la misma persona.");
                return false;  // Evita el envío del formulario
            }
            return true;  // Permite el envío del formulario
        }
    </script>
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
    </div>
    <div class="container mt-5">
        <h2>Gestionar Detalle del Proyecto</h2>

        <!-- Establecer la conexión a la base de datos -->
        <c:set var="dbURL" value="jdbc:mysql://localhost:3306/gestorproyectosdegrado" />
        <c:set var="dbUser" value="root" />
        <c:set var="dbPass" value="" />

        <sql:setDataSource var="ds" driver="com.mysql.jdbc.Driver" 
            url="${dbURL}" user="${dbUser}" password="${dbPass}" />

        <!-- Consulta para obtener el proyecto según el id_proyecto -->
        <sql:query var="proyectos" dataSource="${ds}">
            SELECT id, titulo, descripcion, id_director, id_evaluador 
            FROM proyecto 
            WHERE id = ?;
            <sql:param value="${param.id_proyecto}" />
        </sql:query>

        <!-- Consulta para obtener los docentes -->
        <sql:query var="docentes" dataSource="${ds}">
            SELECT id, nombre FROM docente;
        </sql:query>

        <!-- Formulario para gestionar el detalle del proyecto -->
        <c:forEach var="proyecto" items="${proyectos.rows}">
            <form action="gestionarDetalleProyecto.jsp" method="post" class="border p-3 mb-3" onsubmit="return validarFormulario();">
                <h4>${proyecto.titulo}</h4>

                <div class="form-group">
                    <label for="descripcion_${proyecto.id}">Descripción:</label>
                    <textarea id="descripcion_${proyecto.id}" class="form-control" rows="4" readonly>${proyecto.descripcion}</textarea>
                </div>

                <!-- Selección del Director -->
                <div class="form-group">
                    <label for="id_director_${proyecto.id}">Director:</label>
                    <select name="id_director" id="id_director" class="form-control" required>
                        <option value="">Seleccionar Director</option>
                        <c:forEach var="docente" items="${docentes.rows}">
                            <option value="${docente.id}" 
                                <c:if test="${docente.id == proyecto.id_director}">selected</c:if>>
                                ${docente.nombre}
                            </option>
                        </c:forEach>
                    </select>
                </div>

                <!-- Selección del Evaluador -->
                <div class="form-group">
                    <label for="id_evaluador_${proyecto.id}">Evaluador:</label>
                    <select name="id_evaluador" id="id_evaluador" class="form-control" required>
                        <option value="">Seleccionar Evaluador</option>
                        <c:forEach var="docente" items="${docentes.rows}">
                            <option value="${docente.id}" 
                                <c:if test="${docente.id == proyecto.id_evaluador}">selected</c:if>
                                <c:if test="${docente.id == proyecto.id_director}">disabled</c:if>> 
                                ${docente.nombre}
                            </option>
                        </c:forEach>
                    </select>
                    <small class="form-text text-muted">El director y el evaluador no pueden ser la misma persona.</small>
                </div>

                <!-- Botón de guardar -->
                <input type="hidden" name="id_proyecto" value="${proyecto.id}" />
                <button type="submit" class="btn btn-primary">Guardar Cambios</button>
            </form>
        </c:forEach>

        <!-- Actualización del director y evaluador -->
        <c:if test="${not empty param.id_proyecto}">
            <sql:update dataSource="${ds}">
                UPDATE proyecto 
                SET id_director = ?, id_evaluador = ?
                WHERE id = ?;
                <sql:param value="${param.id_director}" />
                <sql:param value="${param.id_evaluador}" />
                <sql:param value="${param.id_proyecto}" />
            </sql:update>

            <div class="alert alert-success mt-3">Los datos del proyecto han sido actualizados exitosamente.</div>
        </c:if>
    </div>
</body>
</html>
