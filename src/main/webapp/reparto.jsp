<%
    Object rolS = session.getAttribute("rol");
    if (rolS == null || (!"Repartidor".equals(rolS) && !"Administrativo".equals(rolS))) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <title>Panel de Reparto - Aromas a Dúo</title>
    <style>
        body { font-family: 'Segoe UI', sans-serif; background: #f1f5f9; padding: 20px; }
        .contenedor { max-width: 600px; margin: auto; }
        .card { background: white; padding: 20px; border-radius: 12px; box-shadow: 0 4px 6px -1px rgba(0,0,0,0.1); margin-bottom: 15px; border-left: 6px solid #3b82f6; }
        .btn { background: #3b82f6; color: white; padding: 10px 20px; text-decoration: none; border-radius: 8px; display: inline-block; font-weight: bold; margin-top: 10px; }
        .btn:hover { background: #2563eb; }
        .alerta { background: #dcfce7; color: #166534; padding: 10px; border-radius: 8px; margin-bottom: 20px; text-align: center; }
    </style>
</head>
<body>
    <div class="contenedor">
        <h1>🚚 Pedidos Listos para Entrega</h1>
        
        <% if(request.getParameter("msg") != null) { %>
            <div class="alerta">¡Pedido asignado! Ya puedes ver el destino.</div>
        <% } %>

        <%
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/aromas_duo", "root", "");
                
                // Buscamos pedidos que estén "Listos para enviar" y que NADIE haya tomado todavía
                String sql = "SELECT * FROM pedidos WHERE Estado_Pedido = 'Listo para enviar' AND Id_Repartidor_FK IS NULL";
                PreparedStatement ps = con.prepareStatement(sql);
                ResultSet rs = ps.executeQuery();
                
                boolean hayPedidos = false;
                while(rs.next()){
                    hayPedidos = true;
        %>
            <div class="card">
                <h3>Pedido #<%= rs.getInt("Id_Pedido") %></h3>
                <p>📍 Destino: <strong><%= rs.getString("Tipo_Entrega") %></strong></p>
                <p>💰 Total a cobrar: $<%= rs.getDouble("Total") %></p>
                <a href="AsignarRepartidorServlet?id=<%= rs.getInt("Id_Pedido") %>" class="btn">🚀 Tomar Pedido e Iniciar Ruta</a>
            </div>
       <%      } // Este cierra el while de los pedidos libres
                if(!hayPedidos) {
                    out.print("<p style='text-align:center; color:#64748b;'>No hay pedidos pendientes por ahora. ¡Buen trabajo!</p>");
                }
                con.close();
            } catch(Exception e) { out.print("Error: " + e.getMessage()); }
        %>

        <hr style="margin: 40px 0; border: 1px dashed #cbd5e1;">

        <h1>📦 Mis Entregas en Curso</h1>
        <%
            try {
                Integer idJuan = (Integer) session.getAttribute("id_usuario");
                Connection con2 = DriverManager.getConnection("jdbc:mysql://localhost:3306/aromas_duo", "root", "");
                
                String sql2 = "SELECT * FROM pedidos WHERE Estado_Pedido = 'En camino' AND Id_Repartidor_FK = ?";
                PreparedStatement ps2 = con2.prepareStatement(sql2);
                ps2.setInt(1, idJuan);
                ResultSet rs2 = ps2.executeQuery();
                
                boolean tieneEntregas = false;
                while(rs2.next()){
                    tieneEntregas = true;
        %>
            <div class="card" style="border-left-color: #10b981;">
                <h3>Pedido #<%= rs2.getInt("Id_Pedido") %></h3>
                <p>📍 Destino: <strong><%= rs2.getString("Tipo_Entrega") %></strong></p>
                <p>🟢 Estado: <strong>En ruta de entrega</strong></p>
                
                <a href="finalizar_entrega.jsp?id=<%= rs2.getInt("Id_Pedido") %>" class="btn" style="background: #10b981;">
                    ✅ Entregar y Finalizar
                </a>
            </div>
        <%      }
                if(!tieneEntregas) {
                    out.print("<p style='text-align:center; color:#64748b;'>No tienes pedidos asignados en este momento.</p>");
                }
                con2.close();
            } catch(Exception e) { out.print("Error en Mis Entregas: " + e.getMessage()); }
        %>
        </div> </body>
</html>
