package controlador;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/ActualizarEstadoServlet")
public class ActualizarEstadoServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        String idPedido = request.getParameter("id");
        String nuevoEstado = request.getParameter("nuevoEstado");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/aromas_duo", "root", "");

            // Actualizamos el estado en la tabla pedidos
            String sql = "UPDATE pedidos SET Estado_Pedido = ? WHERE Id_Pedido = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, nuevoEstado);
            ps.setString(2, idPedido);
            ps.executeUpdate();

            con.close();
            // Le decimos que no se vaya a la administración, sino que vuelva al panel de cocina
            // y que lleve el mensaje "msg=notificar"
            response.sendRedirect("panel_seguimiento.jsp?msg=notificar&id=" + idPedido + "&estado=" + nuevoEstado);

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        }
    }
}