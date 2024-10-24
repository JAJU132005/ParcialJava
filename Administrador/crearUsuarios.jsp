<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registro de Usuario</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.6.0/css/bootstrap.min.css">
    <style>
        /* Estilo de fondo y colores basado en el index anterior */
        body {
            background: linear-gradient(135deg, #b2d6a8, #4a7c2d);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        .container {
            margin-top: 50px;
        }

        /* Estilo del recuadro de formulario */
        .form-container {
            background-color: rgba(255, 255, 255, 0.9); /* Fondo semi-transparente */
            padding: 30px;
            border-radius: 20px;
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2);
            max-width: 600px;
            width: 100%;
            backdrop-filter: blur(5px);
        }

        h2 {
            color: #3a5937;
            font-size: 2em;
            margin-bottom: 30px;
            letter-spacing: 1.5px;
            text-align: center;
        }

        label {
            color: #3a5937;
        }

        .form-control {
            border-radius: 10px;
        }

        .btn-primary {
            background-color: #26a65b;
            border-color: #26a65b;
            padding: 10px 20px;
            border-radius: 30px;
            font-size: 1.2em;
            transition: background-color 0.3s ease, transform 0.3s ease;
        }

        .btn-primary:hover {
            background-color: #1e8c4a;
            transform: scale(1.05);
        }

        /* Botón de salida */
        .button-containerE {
            position: absolute;
            top: 20px;
            right: 20px;
        }

        .button {
            background-color: #26a65b;
            border: none;
            color: white;
            padding: 10px 20px;
            font-size: 1em;
            border-radius: 30px;
            cursor: pointer;
            transition: transform 0.3s ease, background-color 0.3s ease;
        }

        .button:hover {
            background-color: #1e8c4a;
            transform: scale(1.05);
        }

        /* Ajuste para botones de radio */
        .form-check-label {
            color: #3a5937;
        }

        .form-check-input:checked {
            background-color: #26a65b;
            border-color: #26a65b;
        }

        /* Ajustes responsivos */
        @media (max-width: 768px) {
            .button-containerE {
                top: 10px;
                right: 10px;
            }
        }
    </style>
</head>
<body>
    

    <!-- Formulario de registro -->
    <div class="containerE">
        <div class="form-container">
            <h2>Registro de Usuario</h2>
            <form action="procesarRegistro.jsp" method="post" accept-charset="UTF-8">
                <!-- Nombre -->
                <div class="form-group">
                    <label for="nombre">Nombre</label>
                    <input type="text" class="form-control" id="nombre" name="nombre" placeholder="Ingrese su nombre" required>
                </div>
                
                <!-- Correo -->
                <div class="form-group">
                    <label for="correo">Correo Electrónico</label>
                    <input type="email" class="form-control" id="correo" name="correo" placeholder="Ingrese su correo electrónico" required>
                </div>

                <!-- Password -->
                <div class="form-group">
                    <label for="password">Contraseña</label>
                    <input type="password" class="form-control" id="password" name="password" placeholder="Ingrese una contraseña" required>
                </div>

                <!-- Programa (Lista Desplegable) -->
                <div class="form-group">
                    <label for="programa">Programa</label>
                    <select class="form-control" id="programa" name="programa" required>
                        <option value="">Seleccione un programa</option>
                        <%
                            // Conectar a la base de datos para obtener los programas
                            String url = "jdbc:mysql://localhost:3306/gestorproyectosdegrado?useUnicode=true&characterEncoding=UTF-8";
                            String user = "root";
                            String pass = "";
                            Connection conn = null;
                            PreparedStatement ps = null;
                            ResultSet rs = null;
                            
                            try {
                                Class.forName("com.mysql.jdbc.Driver");
                                conn = DriverManager.getConnection(url, user, pass);
                                
                                // Consulta SQL para obtener los programas
                                String sql = "SELECT id, descripcion FROM programa";
                                ps = conn.prepareStatement(sql);
                                rs = ps.executeQuery();
                                
                                // Iterar sobre los resultados de la consulta
                                while(rs.next()) {
                                    int idPrograma = rs.getInt("id");
                                    String descripcion = rs.getString("descripcion");
                        %>
                                    <option value="<%= idPrograma %>"><%= descripcion %></option>
                        <%
                                }
                            } catch (Exception e) {
                                e.printStackTrace();
                            } finally {
                                if(rs != null) rs.close();
                                if(ps != null) ps.close();
                                if(conn != null) conn.close();
                            }
                        %>
                    </select>
                </div>

                <!-- Tipo de Usuario (Radio Button) -->
                <div class="form-group">
                    <label>Tipo de Usuario</label><br>
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="tipo_usuario" id="coordinador" value="coordinador" required>
                        <label class="form-check-label" for="coordinador">Coordinador</label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="tipo_usuario" id="docente" value="docente" required>
                        <label class="form-check-label" for="docente">Docente</label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="tipo_usuario" id="estudiante" value="estudiante" required>
                        <label class="form-check-label" for="estudiante">Estudiante</label>
                    </div>
                </div>

                <!-- Botón de Enviar -->
                <button type="submit" class="btn btn-primary">Registrar</button>
                <!-- Botón de salida al dashboard -->
    <div class="button-containerE">
        <button class="btn btn-primary" onclick="window.location.href='adminDashboard.jsp'">Salir</button>
    </div>
            </form>
        </div>
    </div>
</body>
</html>
