<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Registro de Productos Completo</title>

    <style>
        /* Estilo general para el cuerpo de la página */
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f4f7f6;
            display: flex;
            flex-direction: column;
            align-items: center;
            padding: 40px;
        }

        /* Caja del formulario */
        form {
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            width: 400px;
        }

        h2 { color: #333; margin-bottom: 20px; }

        /* Estilo para los letreros y los cuadros de texto */
        label { font-weight: bold; color: #555; display: block; margin-bottom: 5px; }

        input, textarea, select {
            width: 100%;
            padding: 10px;
            margin-bottom: 20px;
            border: 1px solid #ddd;
            border-radius: 5px;
            box-sizing: border-box; /* Para que el padding no ensanche el cuadro */
        }

        /* El botón de guardar */
        button {
            background-color: #28a745;
            color: white;
            padding: 12px;
            border: none;
            border-radius: 5px;
            width: 100%;
            font-size: 16px;
            cursor: pointer;
            transition: background 0.3s;
        }

        button:hover {
            background-color: #218838;
        }

        /* El enlace de volver */
        .volver {
            margin-top: 15px;
            display: block;
            text-align: center;
            color: #007bff;
            text-decoration: none;
        }
    </style>

</head>
<body>
    <h2>Ingresar Nuevo Producto</h2>
    <form action="ProductoServlet" method="POST">
        <label>Nombre del Producto:</label><br>
        <input type="text" name="nombreProducto" required><br><br>

        <label>Descripción:</label><br>
        <input type="text" name="descripcionProducto"><br><br>

        <label>Categoría del Producto:</label><br>
            <select name="categoriaProducto">
            <option value="Bebidas">Bebidas (Gaseosas, Jugos)</option>
            <option value="Snacks">Snacks (Papas, Galletas)</option>
            <option value="Licores">Licores (Cervezas, Vinos)</option>
            <option value="Panaderia">Panadería</option>
            <option value="Otros">Otros</option>
        </select><br><br>

        <label>Precio:</label><br>
        <input type="number" name="precioProducto" step="0.01" required><br><br>

        <label>Cantidad (Stock):</label><br>
        <input type="number" name="stockProducto" required><br><br>

        <button type="submit">Guardar Producto en Bodega</button>
        <br><a href="ConsultarProductosServlet" class="volver">← Ver inventario</a>
    </form>
</body>
</html>