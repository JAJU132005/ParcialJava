<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login General</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.6.0/css/bootstrap.min.css">
    <style>
        body {
            background-color: #8bb383; /* Color del fondo verde claro */
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            position: relative; /* Posicionamiento relativo para el botón de salir */
        }
        .login-container {
            background-color: #6a9e62; /* Fondo verde del contenedor */
            padding: 40px;
            border-radius: 30px; /* Bordes redondeados */
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2); /* Sombra suave */
            width: 400px;
            text-align: center;
        }
        .login-container h3 {
            background-color: #5d8b55; /* Color del fondo del título */
            color: white;
            padding: 10px 0;
            border-radius: 50px; /* Bordes muy redondeados */
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2); /* Sombra en el título */
        }
        .form-group input {
            background-color: #31a85e; /* Color del fondo de los inputs */
            border: none; /* Sin borde */
            color: white;
            padding: 15px;
            border-radius: 30px; /* Bordes redondeados */
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2); /* Sombra */
            margin-bottom: 20px;
        }
        .btn-login {
            background-color: #31a85e; /* Color de fondo del botón */
            border: none;
            color: white;
            padding: 15px;
            border-radius: 30px; /* Bordes redondeados */
            font-size: 1.2em;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2); /* Sombra en el botón */
            transition: background-color 0.3s;
        }
        .btn-login:hover {
            background-color: #28894b; /* Color del botón al pasar el mouse */
        }
        .button-container {
            position: absolute; /* Posicionamiento absoluto para colocar el botón de salir */
            top: 20px; /* Espacio desde la parte superior */
            right: 20px; /* Espacio desde la derecha */
        }
        .button {
            background-color: #26a65b; /* Color verde de los botones */
            border: none;
            border-radius: 25px;
            color: white;
            font-size: 1.2em;
            padding: 15px 20px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .button:hover {
            background-color: #1e8c4a; /* Color más oscuro al hacer hover */
        }

        .button:focus {
            outline: none;
        }
    </style>
</head>
<body>
    <div class="button-container">
        <button class="button" onclick="window.location.href='../index.jsp'">Salir</button>
    </div>
    <div class="login-container">
        <h3>Login General</h3>
        <form action="validarLogin.jsp" method="post">
            <div class="form-group">
                <input type="email" class="form-control" id="correo" name="correo" placeholder="Correo Institucional" required>
            </div>
            <div class="form-group">
                <input type="password" class="form-control" id="password" name="password" placeholder="Contraseña" required>
            </div>
            <div class="form-group">
                <label for="tipo">Tipo de Usuario:</label>
                <select class="form-control" id="tipo" name="tipo" required>
                    <option value="estudiante">Estudiante</option>
                    <option value="docente">Docente</option>
                    <option value="coordinador">Coordinador</option>
                </select>
            </div>
            <button type="submit" class="btn-login">Ingresar</button>
        </form>
    </div>
</body>
</html>

