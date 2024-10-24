<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sistema Gestor de Proyectos de Grado</title>
    <style>
        /* Fondo con un degradado más elegante */
        body {
            background: linear-gradient(135deg, #b2d6a8, #4a7c2d);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        /* Recuadro principal con una apariencia más moderna */
        .container {
            background-color: rgba(255, 255, 255, 0.9); /* Recuadro semi-transparente */
            padding: 50px;
            border-radius: 30px;
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2);
            text-align: center;
            max-width: 500px;
            width: 100%;
            backdrop-filter: blur(5px); /* Efecto de fondo difuminado */
        }

        h1 {
            color: #3a5937;
            font-size: 2.5em;
            margin-bottom: 40px;
            letter-spacing: 2px;
            text-transform: uppercase;
        }

        /* Contenedor de los botones con mayor separación */
        .button-container {
            display: flex;
            justify-content: space-between;
            margin-top: 40px;
        }

        /* Botones estilizados con sombras suaves y mejor transición */
        .button {
            background-color: #26a65b;
            border: none;
            border-radius: 30px;
            color: white;
            font-size: 1.2em;
            padding: 15px 30px;
            cursor: pointer;
            transition: transform 0.3s ease, background-color 0.3s ease;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }

        .button:hover {
            background-color: #1e8c4a;
            transform: scale(1.05); /* Efecto de agrandamiento suave al pasar el ratón */
        }

        .button:focus {
            outline: none;
        }

        /* Descripción con mejor alineación y mayor contraste */
        .description {
            color: #3a5937;
            margin-top: 30px;
            font-size: 1.1em;
            line-height: 1.6;
            text-align: left;
        }

        /* Ajustes responsivos */
        @media (max-width: 768px) {
            .button-container {
                flex-direction: column;
                gap: 20px; /* Espacio entre botones cuando se apilen verticalmente */
            }
            .button {
                width: 100%;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Sistema Gestor de Proyectos de Grado</h1>

        <!-- Sección de descripción general del sistema -->
        <div class="description">
            <p>Este sistema está diseñado para la <strong>gestión y seguimiento</strong> de los trabajos de grado en las UTS. A través de esta plataforma, se facilita la administración de los usuarios y se realiza un seguimiento eficiente de los proyectos académicos.</p>
        </div>

        <!-- Botones de login mejorados visualmente -->
        <div class="button-container">
            <button class="button" onclick="window.location.href='Administrador/login/loginAdmin.jsp'">Login Administrativo</button>
            <button class="button" onclick="window.location.href='general/loginGeneral.jsp'">Login General</button>
        </div>

        <!-- Descripción de los tipos de login -->
        <div class="description">
            <p><strong>Login Administrativo:</strong> Permite la gestión de usuarios administradores encargados de controlar y supervisar el acceso y funcionamiento del sistema.</p>
            <p><strong>Login General:</strong> Facilita la gestión de usuarios como Coordinación, Director, Evaluador y Estudiante, que interactúan con el sistema según su rol.</p>
        </div>
    </div>
</body>
</html>
