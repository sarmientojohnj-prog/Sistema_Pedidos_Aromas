<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Gestión de Inventario - Cocina Oculta</title>
</head>
<body>
    <h1>Agregar Nuevo Producto al Inventario</h1>
    
    <form action="guardarProducto" method="post">
        <label>Nombre del Producto:</label><br>
        <input type="text" name="nombre"><br><br>

        <label>Precio:</label><br>
        <input type="number" name="precio"><br><br>

        <label>Cantidad (Stock):</label><br>
        <input type="number" name="stock"><br><br>

        <button type="submit">Guardar Producto</button>
    </form>
</body>
</html>