<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // 1. Seguridad: Solo Administrativo u Operativo pueden ver esto
    Object rolSesion = session.getAttribute("rol");
    if (rolSesion == null || (!"Administrativo".equals(rolSesion) && !"Operativo".equals(rolSesion))) {
        response.sendRedirect("login.jsp");
        return;
    }
    String rol = (String) rolSesion;
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Gestión de Clientes - Aromas a Dúo</title>
    <style>
        body { font-family: 'Segoe UI', sans-serif; background-color: #f1f5f9; padding: 20px; }
        .container { max-width: 1100px; margin: auto; background: white; padding: 30px; border-radius: 15px; box-shadow: 0 4px 15px rgba(0,0,0,0.1); }
        h2 { color: #1e293b; border-bottom: 3px solid #d97706; padding-bottom: 10px; }
        .buscador { margin: 20px 0; display: flex; gap: 10px; }
        input { flex-grow: 1; padding: 10px; border: 1px solid #cbd5e1; border-radius: 8px; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th { background-color: #1e293b; color: white; padding: 12px; text-align: left; }
        td { padding: 12px; border-bottom: 1px solid #e2e8f0; }
        tr:hover { background-color: #f8fafc; }
        .btn { padding: 8px 15px; border-radius: 6px; text-decoration: none; font-weight: bold; font-size: 0.9em; }
        .btn-edit { background: #0284c7; color: white; }
        .btn-delete { background: #ef4444; color: white; margin-left: 5px; }
        .btn-add { background: #22c55e; color: white; margin-bottom: 20px; display: inline-block; }
        .btn-volver { background: #64748b; color: white; margin-top: 20px; display: inline-block; }
    </style>
</head>
<body>

<div class="container">
    <h2>👥 Gestión de Clientes</h2>

    <div class="buscador">
        <input type="text" id="inputBuscar" onkeyup="filtrarTabla()" placeholder="Buscar por nombre, cédula o correo...">
    </div>

    <a href="registro_clientes.jsp" class="btn btn-add">+ Registrar Nuevo Cliente</a>

    <table>
        <thead>
            <tr>
                <th>Nombre y Apellido</th>
                <th>Cédula</th>
                <th>Teléfono</th>
                <th>Correo</th>
                <th>Acciones</th>
            </tr>
        </thead>
        <tbody id="tablaCuerpo">
            <% 
                String datos = (String) request.getAttribute("listaClientes");
                if (datos != null) { 
                    out.print(datos); 
                } 
            %>
        </tbody>
    </table>

    <%
        // Volver inteligente
        String destino = "admin_principal.jsp";
        if ("Operativo".equals(rol)) { destino = "operativo_principal.jsp"; }
    %>
    <a href="<%= destino %>" class="btn btn-volver">⬅ Volver al Panel</a>
</div>

<script>
    function filtrarTabla() {
        var input = document.getElementById("inputBuscar");
        var filtro = input.value.toLowerCase();
        var filas = document.getElementById("tablaCuerpo").getElementsByTagName("tr");

        for (var i = 0; i < filas.length; i++) {
            var texto = filas[i].innerText.toLowerCase();
            filas[i].style.display = texto.includes(filtro) ? "" : "none";
        }
    }
</script>

</body>
</html>