package controlador;

import java.io.IOException;
import java.sql.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/EditarClienteServlet")
public class EditarClienteServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String id = request.getParameter("id");

        Connection con = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/aromas_duo", "root", "");

            // Buscamos los datos actuales de ese cliente
            String sql = "SELECT * FROM persona WHERE IdPersona = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                // Guardamos los datos para enviarlos al formulario de edición
                request.setAttribute("clienteAEditar", rs); 
                // Aquí deberías redirigir a un formulario llamado editar_cliente.jsp
                request.getRequestDispatcher("editar_cliente.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { if (con != null) con.close(); } catch (Exception e) {}
        }
    }
}