<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sistema Gestor de Proyectos de Grado</title>
    <style>
        body {
            background-color: #d5e3cc; /* Color de fondo similar al de la imagen */
            font-family: Arial, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        .container {
            background-color: #7b9463; /* Color del recuadro principal */
            padding: 40px;
            border-radius: 25px;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1);
            text-align: center;
            width: 600px; /* Ajusta el ancho del contenedor */
        }

        h1 {
            color: white;
            font-size: 2em;
            margin-bottom: 50px;
        }

        .button-container {
            display: flex;
            flex-direction: column;
            align-items: center;
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
            width: 90%; /* Los botones ocuparán el 100% del ancho del contenedor */
            margin-bottom: 20px; /* Espaciado entre botones */
        }

        .button:hover {
            background-color: #1e8c4a; /* Color más oscuro al hacer hover */
        }

        .button:focus {
            outline: none;
        }
        .button-containerE {
            position: absolute; /* Posicionamiento absoluto para colocar el botón de salir */
            top: 20px; /* Espacio desde la parte superior */
            right: 20px; /* Espacio desde la derecha */
        }
    </style>
</head>
<body>
    <div class="button-containerE">
        <button class="button" onclick="window.location.href='../loginGeneral.jsp'">Salir</button>
    </div>
    <div class="container">
        <h1>Menu de coordinador</h1>
        <p>Bienvenido, ${sessionScope.userNombre}</p>
        <p>Tu ID es: ${sessionScope.userId}</p>
        <div class="button-container">
            <button class="button" onclick="window.location.href='gestionarIdeasAnteproyecto.jsp'">Gestionar ideas de Anteproyecto</button>
            <button class="button" onclick="window.location.href='gestionarAnteproyectos.jsp'">Gestionar Anteproyecto</button>
            <button class="button" onclick="window.open('https://www.uts.edu.co/sitio/calendario-academico/', '_blank')">Consultar Calendario Academico</button>
            <button class="button" onclick="window.open('https://www.dropbox.com/scl/fo/pudgcaq639agy7t06ahjs/AN084HnuyHffgYL5i--v_Ks/DOCUMENTOS%20DE%20GRADO?rlkey=6s0b9ajweteyx2ang7ywvk6xm&subfolder_nav_tracking=1&st=198xcjmu&dl=0', '_blank')">Consultar Formatos de Grado</button>
        </div>
    </div>
</body>
</html>
