<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="modelo.*" %>

<%
    // BLOQUE DE SEGURIDAD
    String rol = (String) session.getAttribute("rol");
    if ("Repartidor".equals(rol)) {
        response.sendRedirect("principal.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Administración de Pedidos - Aromas a Dúo</title>
    <style>
        body { font-family: Arial; background-color: #f4f4f4; padding: 20px; }
        table { width: 100%; border-collapse: collapse; background: white; }
        th, td { border: 1px solid #ddd; padding: 10px; text-align: left; }
        th { background-color: #2c3e50; color: white; }
        tr:nth-child(even) { background-color: #f2f2f2; }
    </style>
</head>
<body>
    <h2>Lista de Pedidos Recibidos</h2>

    //barra de busqueda
    <div style="margin-bottom: 20px; background: white; padding: 15px; border-radius: 10px; box-shadow: 0 2px 5px rgba(0,0,0,0.05);">
    <label style="font-weight: bold; color: #d97706;">🔍 Buscar en pedidos:</label>
    <input type="text" id="inputBuscador" onkeyup="filtrarPedidos()" placeholder="Escribe nombre, ID, fecha o estado..." 
           style="width: 100%; padding: 10px; margin-top: 8px; border: 1px solid #cbd5e1; border-radius: 6px;">
    </div>

    <table>
        <thead>
            <tr>
                <th># Pedido</th>
                <th>Nombre Cliente</th>
                <th>Tipo Entrega</th>
                <th>Fecha y Hora</th>
                <th>Estado</th>
                <th>Acción</th>
            </tr>
        </thead>
        <tbody>
            <% 
                List<Pedido> lista = (List<Pedido>) request.getAttribute("misPedidos");
                if (lista != null && !lista.isEmpty()) {
                    for (Pedido p : lista) {
            %>
            <tr>
                <td><strong><%= p.getId_Pedido() %></strong></td>
                
                <td><%= p.getNotas_Cliente() %></td>
                
                <td><%= p.getTipo_Entrega() %></td>
                
                <td><%= p.getFecha_Hora_Pedido() %></td>
                
                <td><%= p.getEstado_Pedido() %></td>

                <td>
                    <select onchange="enviarEstado(<%= p.getId_Pedido() %>, this.value)"
                    style="padding: 5px; border-radius: 5px; border: 1px solid #d97706; background: #fffcf0; cursor: pointer;">
        
                    <option value="En preparacion" <%= p.getEstado_Pedido().equals("En preparacion") ? "selected" : "" %>>👨‍🍳 En preparacion</option>
                    <option value="Listo para enviar" <%= p.getEstado_Pedido().equals("Listo para enviar") ? "selected" : "" %>>📦 Listo para enviar</option>
                    <option value="En camino" <%= p.getEstado_Pedido().equals("En camino") ? "selected" : "" %>>🛵 En camino</option>
                    <option value="Entregado" <%= p.getEstado_Pedido().equals("Entregado") ? "selected" : "" %>>✅ Entregado</option>
                    <option value="Retrasado" <%= p.getEstado_Pedido().equals("Retrasado") ? "selected" : "" %>>⚠️ Retrasado</option>
                    <option value="Cancelado" <%= p.getEstado_Pedido().equals("Cancelado") ? "selected" : "" %>>❌ Cancelado</option>
                    </select>
                </td>
            </tr>

            <% 
                    }
                } else {
            %>
            <tr>
                <td colspan="5" style="text-align:center;">No hay pedidos registrados aún.</td>
            </tr>
            <% } %>
        </tbody>
    </table>
    <br>

    <%
        // Boton de regreso de acuerdo al rol
        String rolParaVolver = (String) session.getAttribute("rol");
        String destino = "principal.jsp"; 

        if ("Administrativo".equals(rolParaVolver)) {
            destino = "admin_principal.jsp";
        } else if ("Operativo".equals(rolParaVolver)) {
            destino = "operativo_principal.jsp";
        }
    %>

    <a href="<%= destino %>" style="text-decoration: none; background-color: #64748b; color: white; padding: 10px 20px; border-radius: 8px; font-weight: bold; display: inline-block;">
        ⬅ Volver al Panel
    </a>

    <script>
    
    function filtrarPedidos() {
    // 1. Tomamos lo que escribiste
    var input = document.getElementById("inputBuscador");
    var filtro = input.value.toLowerCase();
    var tabla = document.querySelector("table");
    var filas = tabla.getElementsByTagName("tr");

    // 2. Recorremos las filas (saltando el encabezado)
    for (var i = 1; i < filas.length; i++) {
        var textoFila = filas[i].innerText.toLowerCase();
        // 3. Si lo que escribiste está en la fila, la mostramos; si no, la ocultamos
        filas[i].style.display = textoFila.includes(filtro) ? "" : "none";
    }
}

function enviarEstado(id, nuevoEstado) {
    if (confirm("¿Cambiar el estado del pedido #" + id + " a: " + nuevoEstado + "?")) {
        // Redirigimos al Servlet que ya creamos antes
        window.location.href = "ActualizarEstadoServlet?id=" + id + "&nuevoEstado=" + nuevoEstado;
    } else {
        // Si cancela el aviso, refrescamos para que el select vuelva a su estado original
        location.reload();
    }
}

</script>

</body>
</html>