package controlador;

import java.io.IOException;
import java.sql.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/EliminarClienteServlet")
public class EliminarClienteServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 1. Recibimos el ID que mandó el botón
        String id = request.getParameter("id");

        Connection con = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/aromas_duo", "root", "");

            // 2. Primero borramos el registro de la tabla 'usuario' (por la llave foránea)
            // y luego de la tabla 'persona'. O si usas borrado en cascada, solo persona.
            String sqlUsuario = "DELETE FROM usuario WHERE Id_Persona_FK = ?";
            PreparedStatement psUser = con.prepareStatement(sqlUsuario);
            psUser.setString(1, id);
            psUser.executeUpdate();

            String sqlPersona = "DELETE FROM persona WHERE IdPersona = ?";
            PreparedStatement psPers = con.prepareStatement(sqlPersona);
            psPers.setString(1, id);
            psPers.executeUpdate();

            // 3. Volvemos a la lista de clientes para ver que ya no está
            response.sendRedirect("ConsultarClientesServlet");

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error al eliminar: " + e.getMessage());
        } finally {
            try { if (con != null) con.close(); } catch (Exception e) {}
        }
    }
}