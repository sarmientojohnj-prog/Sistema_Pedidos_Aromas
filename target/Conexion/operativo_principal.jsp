<%@ page import="java.sql.*" %>
<%
    // 1. Obtenemos los datos de la sesión
    Object nombreSesion = session.getAttribute("nombre");
    Object rolSesion = session.getAttribute("rol");

    // 2. SEGURIDAD: ¡OJO AQUÍ! Ahora permitimos entrar si el rol es "Operativo"
    // Si no hay nombre O el rol NO es "Operativo", lo sacamos
    if (nombreSesion == null || (!"Operativo".equals(rolSesion) && !"Repartidor".equals(rolSesion))) {
        response.sendRedirect("login.jsp");
        return; 
    }

    // 3. Guardamos el nombre
    String nombreOp = (String) nombreSesion;
%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Panel Operativo - Aromas a Dúo</title>
    <style>
        body { font-family: 'Segoe UI', sans-serif; background-color: #f1f5f9; margin: 0; padding: 0; }
        header { background-color: #334155; color: white; padding: 20px 50px; display: flex; justify-content: space-between; align-items: center; }
        .container { max-width: 1000px; margin: 40px auto; padding: 20px; }
        .op-card { background: white; padding: 40px; border-radius: 15px; text-align: center; box-shadow: 0 4px 12px rgba(0,0,0,0.1); border-top: 6px solid #0284c7; } /* Azul para diferenciarlo del naranja de admin */
        .grid-funciones { display: grid; grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); gap: 20px; margin-top: 30px; }
        .boton-menu { 
            background: white; padding: 30px; border-radius: 12px; text-decoration: none; color: #334155;
            font-weight: bold; border: 2px solid #e2e8f0; transition: all 0.3s; text-align: center;
        }
        .boton-menu:hover { border-color: #0284c7; transform: translateY(-5px); box-shadow: 0 5px 15px rgba(0,0,0,0.1); }
    </style>
</head>
<body>

<header>
    <span style="font-size: 1.5em; font-weight: bold;">☕ Aromas a Dúo - ÁREA OPERATIVA</span>
    <a href="index.jsp" style="color: #cbd5e1; text-decoration: none;">Cerrar Sesión</a>
</header>

<div class="container">
    <div class="op-card">
        <h1>Bienvenido, <%= nombreOp %> 👋</h1>
        <p>Área de trabajo para gestión de pedidos y productos.</p>

        <div class="grid-funciones">

            <a href="ConsultarClientesServlet" class="boton-menu">
                <span style="font-size: 40px;">👥</span><br>
                Lista de Clientes<br>
                <small style="font-weight: normal; color: #64748b;">Consultar datos de contacto</small>
            </a>

            <a href="PedidoServlet" class="boton-menu">
                <span style="font-size: 40px;">📋</span><br>
                Gestionar Pedidos<br>
                <small style="font-weight: normal; color: #64748b;">Ver pedidos y entregarlos</small>
            </a>

            <a href="ConsultarProductosServlet" class="boton-menu">
                <span style="font-size: 40px;">🍔</span><br>
                Inventario de Productos<br>
                <small style="font-weight: normal; color: #64748b;">Consultar precios y stock</small>
            </a>

            <a href="perfil_usuario.jsp" class="boton-menu">
                <span style="font-size: 40px;">👤</span><br>
                Mi Perfil<br>
                <small style="font-weight: normal; color: #64748b;">Cambiar mi contraseña</small>
            </a>
            
            <a href="panel_seguimiento.jsp" class="boton-menu">
                <span style="font-size: 40px;">👨‍🍳</span><br>
                Ir al Panel de Cocina<br>
                <small style="font-weight: normal; color: #64748b;">Cambiar mi contraseña</small>
            </a>

            <%-- BOTÓN PARA  EL REPARTIDOR --%>
            <% if ("Repartidor".equals(rolSesion)) { %>
                <a href="reparto.jsp" class="boton-menu" style="border-color: #3b82f6; background-color: #eff6ff;">
                    <span style="font-size: 40px;">🚚</span><br>
                    <strong>Gestionar Repartos</strong><br>
                    <small style="font-weight: normal; color: #64748b;">Ver pedidos listos para entrega</small>
                </a>
            <% } %>

            </div>
    </div>
</div>

</body>
</html>