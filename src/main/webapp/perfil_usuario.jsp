<%@ page import="java.sql.*" %>
<%
    // 1. Validar sesión
    Object nombreSesion = session.getAttribute("nombre");
    Object emailSesion = session.getAttribute("email_sesion");
    Object rolSesion = session.getAttribute("rol");

    if (nombreSesion == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String nombre = (String) nombreSesion;
    String email = (String) emailSesion;
    String rol = (String) rolSesion;
%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Mi Perfil - Aromas a Dúo</title>
    <style>
        body { font-family: 'Segoe UI', sans-serif; background-color: #f1f5f9; padding: 40px; }
        .perfil-card { max-width: 500px; margin: auto; background: white; padding: 30px; border-radius: 15px; box-shadow: 0 4px 15px rgba(0,0,0,0.1); text-align: center; }
        .avatar { font-size: 60px; margin-bottom: 10px; }
        .info-grupo { text-align: left; margin-top: 20px; padding: 15px; background: #f8fafc; border-radius: 10px; }
        .label { font-weight: bold; color: #64748b; font-size: 0.9em; }
        .valor { color: #1e293b; font-size: 1.1em; margin-bottom: 10px; }
        .btn-cambiar { display: block; background: #d97706; color: white; text-decoration: none; padding: 12px; border-radius: 8px; margin-top: 20px; font-weight: bold; }
        .btn-volver { display: block; margin-top: 15px; color: #64748b; text-decoration: none; font-size: 0.9em; }
    </style>
</head>
<body>

<div class="perfil-card">
    <div class="avatar">👤</div>
    <h2>Mi Perfil</h2>
    
    <div class="info-grupo">
        <div class="label">Nombre completo:</div>
        <div class="valor"><%= nombre %></div>
        
        <div class="label">Correo electrónico:</div>
        <div class="valor"><%= email %></div>
        
        <div class="label">Rol en la empresa:</div>
        <div class="valor"><strong><%= rol %></strong></div>
    </div>

    <a href="cambiar_clave.jsp" class="btn-cambiar">🔐 Cambiar Contraseña</a>

    <%
        String destino = "principal.jsp";
        if ("Administrativo".equals(rol)) { destino = "admin_principal.jsp"; }
        else if ("Operativo".equals(rol)) { destino = "operativo_principal.jsp"; }
    %>
    <a href="<%= destino %>" class="btn-volver">⬅ Volver al Panel</a>
</div>



</body>
</html>