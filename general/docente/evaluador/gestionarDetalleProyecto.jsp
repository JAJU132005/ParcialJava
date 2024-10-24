<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestionar Proyecto</title>
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
        <button class="button" onclick="window.location.href='evaluadorDashboard.jsp'">Salir</button>
    </div>
    <div class="container mt-5">
        <h2>Gestionar Proyecto</h2>

        <!-- Establecer la conexión a la base de datos -->
        <c:set var="dbURL" value="jdbc:mysql://localhost:3306/gestorproyectosdegrado" />
        <c:set var="dbUser" value="root" />
        <c:set var="dbPass" value="" />
        
        <sql:setDataSource var="ds" driver="com.mysql.jdbc.Driver" 
            url="${dbURL}" user="${dbUser}" password="${dbPass}" />

        <!-- Consulta para obtener el proyecto específico -->
        <sql:query var="proyectoDetalle" dataSource="${ds}">
            SELECT * FROM proyecto WHERE id = ?;
            <sql:param value="${param.id_proyecto}" />
        </sql:query>

        <!-- Consulta para obtener los nombres de estudiantes, coordinador y docentes -->
        <sql:query var="estudiantes" dataSource="${ds}">
            SELECT id, nombre FROM estudiante;
        </sql:query>

        <sql:query var="docentes" dataSource="${ds}">
            SELECT id, nombre FROM docente;
        </sql:query>

        <sql:query var="coordinadores" dataSource="${ds}">
            SELECT id, nombre FROM coordinador;
        </sql:query>

        <!-- Formulario para editar los datos del proyecto -->
        <c:forEach var="proyecto" items="${proyectoDetalle.rows}">
            <form action="gestionarDetalleProyecto.jsp" method="post" class="border p-3 mb-3">
                <h4>${proyecto.titulo}</h4>

                <div class="form-group">
                    <label for="descripcion_${proyecto.id}">Descripción:</label>
                    <textarea id="descripcion_${proyecto.id}" class="form-control" rows="4" readonly>${proyecto.descripcion}</textarea>
                </div>

                <!-- Coordinador -->
                <div class="form-group">
                    <label for="id_coordinador_${proyecto.id}">Coordinador:</label>
                    <input type="text" id="id_coordinador_${proyecto.id}" class="form-control" 
                           value="<c:forEach var='coordinador' items='${coordinadores.rows}'><c:if test='${coordinador.id == proyecto.id_coordinador}'>${coordinador.nombre}</c:if></c:forEach>" readonly>
                </div>

                <div class="form-group">
                    <label for="estado_idea_${proyecto.id}">Estado de la Idea:</label>
                    <input type="text" id="estado_idea_${proyecto.id}" class="form-control" 
                           value="${proyecto.estado_idea == true ? 'Escogida' : 'No Escogida'}" readonly>
                </div>

                <!-- Estudiante 1 -->
                <div class="form-group">
                    <label for="id_estudiante1_${proyecto.id}">Estudiante 1:</label>
                    <input type="text" id="id_estudiante1_${proyecto.id}" class="form-control" 
                           value="<c:forEach var='estudiante' items='${estudiantes.rows}'><c:if test='${estudiante.id == proyecto.id_estudiante1}'>${estudiante.nombre}</c:if></c:forEach>" readonly>
                </div>

                <!-- Estudiante 2 -->
                <div class="form-group">
                    <label for="id_estudiante2_${proyecto.id}">Estudiante 2:</label>
                    <input type="text" id="id_estudiante2_${proyecto.id}" class="form-control" 
                           value="<c:forEach var='estudiante' items='${estudiantes.rows}'><c:if test='${estudiante.id == proyecto.id_estudiante2}'>${estudiante.nombre}</c:if></c:forEach>" readonly>
                </div>

                <div class="form-group">
                    <label for="url_anteproyecto_${proyecto.id}">URL Anteproyecto:</label>
                    <input type="url" id="url_anteproyecto_${proyecto.id}" class="form-control" value="${proyecto.url_anteproyecto}" readonly>
                </div>

                <!-- Director -->
                <div class="form-group">
                    <label for="id_director_${proyecto.id}">Director:</label>
                    <input type="text" id="id_director_${proyecto.id}" class="form-control" 
                           value="<c:forEach var='docente' items='${docentes.rows}'><c:if test='${docente.id == proyecto.id_director}'>${docente.nombre}</c:if></c:forEach>" readonly>
                </div>

                <div class="form-group">
                    <label for="comentarios_director_${proyecto.id}">Comentarios del Director:</label>
                    <textarea id="comentarios_director_${proyecto.id}" class="form-control" rows="4" readonly>${proyecto.comentarios_director}</textarea>
                </div>

                <div class="form-group">
                    <label for="calificacion_director_${proyecto.id}">Calificación Director:</label>
                    <input type="text" id="calificacion_director_${proyecto.id}" class="form-control" 
                           value="${proyecto.calificacion_director == true ? 'Aprobada' : 'Desaprobada'}" readonly>
                </div>

                <div class="form-group">
                    <label for="radicado_anteproyecto_${proyecto.id}">Radicado Anteproyecto:</label>
                    <input type="text" id="radicado_anteproyecto_${proyecto.id}" class="form-control" value="${proyecto.radicado_anteproyecto}" readonly>
                </div>

                <!-- Evaluador -->
                <div class="form-group">
                    <label for="id_evaluador_${proyecto.id}">Evaluador:</label>
                    <input type="text" id="id_evaluador_${proyecto.id}" class="form-control" 
                           value="<c:forEach var='docente' items='${docentes.rows}'><c:if test='${docente.id == proyecto.id_evaluador}'>${docente.nombre}</c:if></c:forEach>" readonly>
                </div>

                <!-- Calificación Evaluador (permitir decimales) -->
                <div class="form-group">
                    <label for="calificacion_evaluador_${proyecto.id}">Calificación Evaluador:</label>
                    <input type="number" name="calificacion_evaluador" id="calificacion_evaluador_${proyecto.id}" 
                           value="${proyecto.calificacion_evaluador != null ? proyecto.calificacion_evaluador : ''}" 
                           class="form-control" required step="0.1" min="0" max="5">
                </div>

                <!-- Estado del Anteproyecto -->
                <div class="form-group">
                    <label for="estado_anteproyecto_${proyecto.id}">Estado Anteproyecto:</label>
                    <select name="estado_anteproyecto" id="estado_anteproyecto_${proyecto.id}" class="form-control" required>
                        <option value="1" <c:if test="${proyecto.estado_anteproyecto == true}">selected</c:if>>Aprobada</option>
                        <option value="0" <c:if test="${proyecto.estado_anteproyecto == false}">selected</c:if>>Desaprobada</option>
                    </select>
                </div>

                <!-- Radicado Comité -->
                <div class="form-group">
                    <label for="radicado_comite_${proyecto.id}">Radicado Comité:</label>
                    <input type="url" name="radicado_comite" id="radicado_comite_${proyecto.id}" 
                           value="${proyecto.radicado_comite != null ? proyecto.radicado_comite : ''}" 
                           class="form-control">
                    <input type="hidden" name="id_proyecto" value="${proyecto.id}" />
                </div>

                <button type="submit" class="btn btn-primary">Guardar Cambios</button>
            </form>
        </c:forEach>

        <!-- Actualización de la calificación del evaluador, estado y radicado -->
        <c:if test="${not empty param.id_proyecto}">
            <sql:update dataSource="${ds}">
                UPDATE proyecto 
                SET calificacion_evaluador = ?, estado_anteproyecto = ?, radicado_comite = ?
                WHERE id = ?;
                <sql:param value="${param.calificacion_evaluador}" />
                <sql:param value="${param.estado_anteproyecto}" />
                <sql:param value="${param.radicado_comite}" />
                <sql:param value="${param.id_proyecto}" />
            </sql:update>

            <div class="alert alert-success mt-3">Los datos del proyecto han sido actualizados exitosamente.</div>
        </c:if>
    </div>
</body>
</html>
