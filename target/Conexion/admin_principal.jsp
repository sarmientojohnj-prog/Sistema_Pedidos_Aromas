<%@ page import="java.sql.*" %>
<%
    // 1. Obtenemos los datos de la sesión
    Object nombreSesion = session.getAttribute("nombre");
    Object rolSesion = session.getAttribute("rol");

    // 2. SEGURIDAD: Si no hay nombre O el rol no es "Administrativo", ¡fuera!
    if (nombreSesion == null || !"Administrativo".equals(rolSesion)) {
        response.sendRedirect("login.jsp");
        return; // <--- ESTO ES VITAL: Detiene la ejecución de la página aquí mismo
    }

    // 3. Si pasó la prueba, guardamos el nombre para mostrarlo
    String nombreAdmin = (String) nombreSesion;
%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Panel Administrativo - Aromas a Dúo</title>
    <style>
        body { font-family: 'Segoe UI', sans-serif; background-color: #f1f5f9; margin: 0; padding: 0; }
        header { background-color: #1e293b; color: white; padding: 20px 50px; display: flex; justify-content: space-between; align-items: center; }
        .container { max-width: 1000px; margin: 40px auto; padding: 20px; }
        .admin-card { background: white; padding: 40px; border-radius: 15px; text-align: center; box-shadow: 0 4px 12px rgba(0,0,0,0.1); border-top: 6px solid #d97706; }
        .grid-funciones { display: grid; grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); gap: 20px; margin-top: 30px; }
        .boton-menu { 
            background: white; padding: 30px; border-radius: 12px; text-decoration: none; color: #334155;
            font-weight: bold; border: 2px solid #e2e8f0; transition: all 0.3s; text-align: center;
        }
        .boton-menu:hover { border-color: #d97706; transform: translateY(-5px); box-shadow: 0 5px 15px rgba(0,0,0,0.1); }
    </style>
</head>
<body>

<header>
    <span style="font-size: 1.5em; font-weight: bold;">☕ Aromas a Dúo - ADMINISTRACIÓN</span>
    <a href="index.jsp" style="color: #cbd5e1; text-decoration: none;">Cerrar Sesión</a>
</header>

<div class="container">
    <div class="admin-card">
        <h1>Bienvenido, Administrador <%= nombreAdmin %> 🛠️</h1>
        <p>¿Qué gestión deseas realizar el día de hoy?</p>

        <div class="grid-funciones">
            <a href="ConsultarClientesServlet" class="boton-menu">
                <span style="font-size: 40px;">👥</span><br>
                Gestión de Clientes<br>
                <small style="font-weight: normal; color: #64748b;">Ver, editar y eliminar clientes</small>
            </a>

            <a href="PedidoServlet" class="boton-menu">
                <span style="font-size: 40px;">📋</span><br>
                Gestionar Pedidos<br>
                <small style="font-weight: normal; color: #64748b;">Ver, entregar y cancelar pedidos</small>
            </a>

            <a href="ConsultarProductosServlet" class="boton-menu">
                <span style="font-size: 40px;">🍔</span><br>
                Inventario de Productos<br>
                <small style="font-weight: normal; color: #64748b;">Cambiar precios, fotos o nombres</small>
            </a>

            <a href="panel_seguimiento.jsp" class="boton-menu">
                <span style="font-size: 40px;">🍔</span><br>
                👨‍🍳 Ir al Panel de Cocina<br>
                <small style="font-weight: normal; color: #64748b;">Cambiar precios, fotos o nombres</small>
            </a>

            <a href="reparto.jsp" class="boton-menu" style="border-color: #3b82f6;">
                <span style="font-size: 40px;">🚚</span><br>
                Gestión de Repartos<br>
                <small style="font-weight: normal; color: #64748b;">Supervisar pedidos en ruta y entregas</small>
            </a>

            <a href="registro_empleados.jsp" class="boton-menu">
                <span style="font-size: 40px;">👤+</span><br>
                Registrar Empleado<br>
                <small style="font-weight: normal; color: #64748b;">Crear cuentas para personal interno</small>
            </a>

            <a href="perfil_usuario.jsp" class="boton-menu">
                <span style="font-size: 40px;">👤</span><br>
                Mi Perfil de Usuario<br>
                <small style="font-weight: normal; color: #64748b;">Cambiar mi clave o mis datos</small>
            </a>

            <a href="GenerarInformeVentasServlet" class="boton-menu" style="background-color: #065f46; color: white;">
                <span style="font-size: 40px;">📊</span><br>
                Descargar Informe de Ventas<br>
                <small style="font-weight: normal; color: #a7f3d0;">Generar archivo Excel (.csv)</small>
            </a>

        </div>
    </div>
</div>

</body>
</html>