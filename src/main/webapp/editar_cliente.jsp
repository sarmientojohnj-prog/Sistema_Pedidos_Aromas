<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // 1. Recuperamos los datos que el Servlet nos envió
    ResultSet rs = (ResultSet) request.getAttribute("clienteAEditar");
    
    // Si por alguna razón llegamos aquí sin datos, nos devolvemos
    if (rs == null) {
        response.sendRedirect("ConsultarClientesServlet");
        return;
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Editar Cliente - Aromas a Dúo</title>
    <style>
        body { font-family: 'Segoe UI', sans-serif; background-color: #f1f5f9; padding: 40px; }
        .card { max-width: 500px; margin: auto; background: white; padding: 30px; border-radius: 15px; box-shadow: 0 4px 15px rgba(0,0,0,0.1); }
        h2 { color: #1e293b; border-bottom: 3px solid #0284c7; padding-bottom: 10px; }
        .campo { margin-bottom: 15px; }
        label { display: block; font-weight: bold; color: #64748b; margin-bottom: 5px; }
        input { width: 100%; padding: 10px; border: 1px solid #cbd5e1; border-radius: 8px; box-sizing: border-box; }
        .btn-guardar { background: #0284c7; color: white; border: none; padding: 12px; width: 100%; border-radius: 8px; font-weight: bold; cursor: pointer; margin-top: 10px; }
        .btn-cancelar { display: block; text-align: center; margin-top: 15px; color: #64748b; text-decoration: none; }
    </style>
</head>
<body>

<div class="card">
    <h2>✏️ Editar Información</h2>
    <form action="ActualizarClienteServlet" method="POST">
        
        <input type="hidden" name="idPersona" value="<%= rs.getInt("IdPersona") %>">

        <div class="campo">
            <label>Nombre:</label>
            <input type="text" name="nombre" value="<%= rs.getString("Nombre") %>" required>
        </div>

        <div class="campo">
            <label>Apellidos:</label>
            <input type="text" name="apellidos" value="<%= rs.getString("Apellidos") %>" required>
        </div>

        <div class="campo">
            <label>Identificación (Cédula):</label>
            <input type="text" name="identificacion" value="<%= rs.getString("Identificacion") %>" required>
        </div>

        <div class="campo">
            <label>Teléfono:</label>
            <input type="text" name="telefono" value="<%= rs.getString("Telefono") %>">
        </div>

        <div class="campo">
            <label>Correo Electrónico:</label>
            <input type="email" name="correo" value="<%= rs.getString("Correo_Electronico") %>" required>
        </div>

        <button type="submit" class="btn-guardar">💾 Guardar Cambios</button>
        <a href="ConsultarClientesServlet" class="btn-cancelar">Cancelar</a>
    </form>
</div>

</body>
</html>