<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Inicio - Aromas a Dúo</title>
    <style>
        body { font-family: 'Segoe UI', sans-serif; background-color: #fef3c7; text-align: center; padding: 50px; }
        .menu-container { background: white; padding: 40px; border-radius: 20px; display: inline-block; box-shadow: 0 10px 25px rgba(0,0,0,0.1); }
        h1 { color: #d97706; margin-bottom: 30px; }
        .boton { 
            display: block; width: 250px; padding: 15px; margin: 10px auto;
            text-decoration: none; color: white; border-radius: 10px; font-weight: bold;
            transition: transform 0.2s;
        }
        .btn-registro { background-color: #ea580c; }
        .btn-pedido { background-color: #d97706; }
        .btn-admin { background-color: #4b5563; }
        .boton:hover { transform: scale(1.05); }
    </style>
</head>
<body>
    <div class="menu-container">
        <h1>☕ Aromas a Dúo 🍳</h1>
        <p>¿Qué deseas hacer hoy?</p>
        
        <a href="registro_clientes.jsp" class="boton btn-registro">📝 Registrar Cliente</a>
        
        <a href="nuevo_pedido.jsp" class="boton btn-pedido">🛒 Crear Nuevo Pedido</a>
        
        <a href="PedidoServlet" class="boton btn-admin">📋 Ver Lista de Pedidos</a>
    </div>
</body>
</html>