<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Editar Producto - Aromas A Duo</title>

<style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f4f7f6;
            display: flex;
            flex-direction: column;
            align-items: center;
            padding: 40px;
        }

        form {
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            width: 400px;
        }

        h2 { color: #333; margin-bottom: 20px; }

        label { font-weight: bold; color: #555; display: block; margin-bottom: 5px; }

        input, textarea, select {
            width: 100%;
            padding: 10px;
            margin-bottom: 20px;
            border: 1px solid #ddd;
            border-radius: 5px;
            box-sizing: border-box;
        }

        button {
            background-color: #007bff; /* Azul para editar, para diferenciar del verde de registro */
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
            background-color: #0056b3;
        }

        .volver {
            margin-top: 15px;
            display: block;
            text-align: center;
            color: #666;
            text-decoration: none;
        }
    </style>

</head>
<body>
    <h2>Modificar Producto</h2>

    <%-- El formulario manda los datos al Servlet luego para GUARDAR --%>
    <form action="ActualizarProductoServlet" method="post">
        
        <%-- 1. El ID no se muestra al usuario, no queremos que  lo cambie, pero el sistema lo necesita --%>
        <input type="hidden" name="id" value="${id}">

        <label>Nombre del Plato:</label><br>
        <input type="text" name="nombre" value="${nombre}" required><br><br>

        <label>Descripción:</label><br>
        <textarea name="descripcion" required>${descripcion}</textarea><br><br>

        <label>Categoría:</label><br>
        <input type="text" name="categoria" value="${categoria}" required><br><br>

        <label>Precio ($):</label><br>
        <input type="number" name="precio" value="${precio}" required><br><br>

        <label>Cantidad en Inventario:</label><br>
        <input type="number" name="cantidad" value="${cantidad}" required><br><br>

        <button type="submit">Guardar Cambios</button>
        <a href="ConsultarProductosServlet" class="volver">← Cancelar y volver</a>
    </form>
</body>
</html>