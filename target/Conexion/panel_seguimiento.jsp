<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
    // BLOQUE DE SEGURIDAD
    String rol = (String) session.getAttribute("rol");
    if ("Repartidor".equals(rol)) {
        response.sendRedirect("principal.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="es"> <%-- CAMBIO 1: Agregamos el idioma español para evitar traducciones locas --%>
<head>
    <title>Panel de Cocina - Aromas a Dúo</title>
    <style>
        body { font-family: sans-serif; background-color: #f0f2f5; padding: 20px; }
        .tablero { display: flex; gap: 20px; justify-content: center; }
        .columna { background: #e0e0e0; border-radius: 12px; width: 320px; padding: 15px; min-height: 80vh; }
        .pedido-card { background: white; margin-bottom: 15px; padding: 15px; border-radius: 8px; border-left: 5px solid #8d6e63; box-shadow: 0 2px 5px rgba(0,0,0,0.1); }
        .detalle-lista { background: #fff9f0; padding: 10px; border-radius: 5px; margin: 10px 0; border: 1px dashed #d7ccc8; }
        .btn { display: inline-block; padding: 8px; margin-top: 5px; color: white; text-decoration: none; border-radius: 3px; font-size: 12px; font-weight: bold; text-align: center; width: 100%; box-sizing: border-box; }
    </style>
</head>
<body>

    <%
    String msg = request.getParameter("msg");
    if(msg != null && msg.equals("notificar")){
        String idNotif = request.getParameter("id");
        String estadoNotif = request.getParameter("estado");
    %>
    <div id="alerta-verde" style="background: #2e7d32; color: white; padding: 15px; position: fixed; top: 20px; right: 20px; border-radius: 10px; box-shadow: 0 4px 15px rgba(0,0,0,0.3); z-index: 9999; border-left: 8px solid #1b5e20;">
        <strong>🚀 ¡Estado Actualizado!</strong><br>
        El pedido #<%= idNotif %> ahora está en: <b><%= estadoNotif %></b>.
    </div>
    <script>
        setTimeout(function(){
            var alerta = document.getElementById('alerta-verde');
            if(alerta) alerta.style.display = 'none';
        }, 3000);
    </script>
    <% } %>

    <nav style="background: #1e293b; padding: 15px; color: white; display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px;">
        <span style="font-weight: bold;">☕ Aromas a Dúo - Módulo de Cocina</span>
        <div>
            <a href="index.jsp" style="color: white; margin-right: 15px; text-decoration: none;">🏠 Inicio</a>
            <a href="PedidoServlet" style="color: #fb923c; text-decoration: none; font-weight: bold;">⚙️ Administración</a>
        </div>
    </nav>

    <h1 style="text-align: center; color: #334155;">👨‍🍳 Panel de Seguimiento en Tiempo Real</h1>
    <meta http-equiv="refresh" content="30">
    
    <div class="tablero">
        <div class="columna">
            <h2 style="color: #d97706;">⏳ En preparación</h2>
            <% renderizarPedidos(out, "En preparacion"); %>
        </div>
        <div class="columna">
            <h2 style="color: #2563eb;">📦 Listo para enviar</h2>
            <% renderizarPedidos(out, "Listo para enviar"); %>
        </div>
        
    </div>

<%! 
    void renderizarPedidos(jakarta.servlet.jsp.JspWriter out, String estadoFiltro) throws java.io.IOException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/aromas_duo", "root", "");
            
            String sql = "SELECT * FROM pedidos WHERE Estado_Pedido = ? ORDER BY Id_Pedido DESC";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, estadoFiltro);
            ResultSet rs = ps.executeQuery();

            while(rs.next()){
                int id = rs.getInt("Id_Pedido");
                out.print("<div class='pedido-card'>");
                out.print("<span style='font-size: 1.2em; font-weight: bold;'>Pedido #" + id + "</span><br>");
                out.print("<small style='color: #64748b;'>Tipo: " + rs.getString("Tipo_Entrega") + "</small>");

                // Cálculo de tiempo transcurrido
                java.sql.Timestamp fechaPedido = rs.getTimestamp("Fecha_Hora_Pedido");
                long diferenciaMillis = System.currentTimeMillis() - fechaPedido.getTime();
                long minutosTranscurridos = diferenciaMillis / (1000 * 60);

                String colorTiempo = (minutosTranscurridos > 20) ? "red" : "#1e293b"; // Si pasa de 20 min, se pone rojo
                out.print("<div style='color:" + colorTiempo + "; font-weight:bold; font-size: 13px;'>");
                out.print("⏱️ Hace: " + minutosTranscurridos + " min");
                out.print("</div>");
                
                // SE MUESTRAN LOS PRODUCTOS DEL PEDIDO ---
                
                out.print("<div class='detalle-lista'>");
                out.print("<strong>📋 Lista de Preparación:</strong><br>");
                
                // Unimos la tabla detalle con la tabla producto para sacar el nombre
                String sqlItems = "SELECT d.Cantidad, p.Nombre " +
                                  "FROM detalle_pedido d " +
                                  "JOIN productos p ON d.Id_Producto_FK = p.Id_Producto " +
                                  "WHERE d.Id_Pedido_FK = ?";
                
                PreparedStatement psItems = con.prepareStatement(sqlItems);
                psItems.setInt(1, id);
                ResultSet rsItems = psItems.executeQuery();
                
                boolean tieneItems = false;
                while(rsItems.next()){
                    tieneItems = true;
                    out.print("<div style='margin-bottom: 5px;'>");
                    out.print("<span style='background: #8d6e63; color: white; padding: 2px 6px; border-radius: 4px; margin-right: 5px;'>" + rsItems.getInt("Cantidad") + "</span>");
                    out.print(" " + rsItems.getString("Nombre")); // Aquí ya sale el nombre real
                    out.print("</div>");
                }
                
                if(!tieneItems) {
                    out.print("<small style='color: red;'>Sin productos registrados</small>");
                }
                out.print("</div>");
                // --- FIN DEL METODO PARA MOSTRAR LOS PRODUCTOS ---

                out.print("<div class='acciones'>");
                if(estadoFiltro.equals("En preparacion")) {
                    out.print("<a class='btn' style='background:#fbc02d; color:black;' href='ActualizarEstadoServlet?id=" + id + "&nuevoEstado=Listo para enviar'>Mandar a Envío</a>");
                } 
                else if(estadoFiltro.equals("Listo para enviar")) {
                    out.print("<a class='btn' style='background:#1976d2;' href='ActualizarEstadoServlet?id=" + id + "&nuevoEstado=En camino'>Notificar a reparto</a>");
                    out.print("<a class='btn' style='background:#e53935; margin-top:5px;' href='ActualizarEstadoServlet?id=" + id + "&nuevoEstado=En preparacion'>↩️ Corregir</a>");
                }
                
                out.print("</div></div>");
            }
            con.close();
        } catch(Exception e) { out.print("<p style='color:red;'>Error al cargar: " + e.getMessage() + "</p>"); }
    }
%>
</body>
</html>