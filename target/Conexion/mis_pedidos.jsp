<%@ page import="java.sql.*" %>
<%
    // 1. Validar quién está conectado
    Object emailSesion = session.getAttribute("email_sesion");
    if (emailSesion == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    String emailCliente = (String) emailSesion;
%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Mis Pedidos - Aromas a Dúo</title>
    <style>
        body { font-family: sans-serif; background-color: #f1f5f9; padding: 20px; }
        .contenedor { max-width: 600px; margin: auto; background: white; padding: 20px; border-radius: 10px; }
        .pedido { border-bottom: 1px solid #eee; padding: 15px 0; }
        .estado { font-weight: bold; color: #d97706; padding: 5px; background: #fff7ed; border-radius: 5px; }
    </style>
</head>
<body>

<div class="contenedor">
    <h2>🚚 Seguimiento de mis pedidos</h2>
    <p>Hola, aquí puedes ver el progreso de tus compras:</p>

    <%
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/aromas_duo", "root", "");
            
            // Buscamos los pedidos usando el ID del cliente que está en la sesión
            String sql = "SELECT * FROM pedidos WHERE Id_Cliente_FK = ? ORDER BY Id_Pedido DESC";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, (Integer)session.getAttribute("id_usuario")); // Usamos el ID de la sesión
            ResultSet rs = ps.executeQuery();

            boolean tienePedidos = false;
            while(rs.next()){
                tienePedidos = true;
    %>
                <div class="pedido">
                    <strong>Pedido #<%= rs.getInt("Id_Pedido") %></strong><br>
                    Estado actual: <span class="estado"><%= rs.getString("Estado_Pedido") %></span><br>
                    <small>Fecha: <%= rs.getTimestamp("Fecha_Hora_Pedido") %></small>
                </div>

                <% 
                // Solo mostramos el formulario si el estado es "Entregado" o no se ha calificado
               if ("Entregado".equalsIgnoreCase(rs.getString("Estado_Pedido")) && rs.getInt("Calificacion_Cliente") == 0) {
        %>
            <div style="margin-top: 10px; padding: 10px; border: 1px solid #ccc; border-radius: 5px; background-color: #f9f9f9;">
                <h5>¿Qué tal estuvo tu entrega?</h5>
                
            <div style="margin-top: 10px; padding: 10px; border: 1px solid #ccc; border-radius: 5px; background-color: #f9f9f9;">
                <h5>¿Qué tal estuvo tu entrega?</h5>
                <form action="CalificarPedidoServlet" method="POST">
                    <input type="hidden" name="idPedido" value="<%= rs.getInt("Id_Pedido") %>"> 

                    <div>
                        <label>Calificación (1 a 5):</label><br>
                        <input type="number" name="calificacion" min="1" max="5" required>
                    </div>

                    <div style="margin-top: 5px;">
                        <label>Tu comentario:</label><br>
                        <textarea name="comentario" rows="2" style="width: 100%;" placeholder="Cuéntanos tu experiencia..."></textarea>
                    </div>

                    <button type="submit" style="margin-top: 5px; background-color: #2563eb; color: white; border: none; padding: 5px 10px; border-radius: 3px; cursor: pointer;">
                        Enviar Calificación
                    </button>
                </form>
            </div>
        <% 
            } // Cierre del if de estado entregado
        %>
    <%
            }
            if(!tienePedidos) {
                out.print("<p>Aún no tienes pedidos registrados.</p>");
            }
            con.close();
        } catch(Exception e) {
            out.print("Error al cargar pedidos: " + e.getMessage());
        }
    %>
    
    <br>
    <a href="principal.jsp">⬅ Volver al Inicio</a>
</div>

</body>
</html>