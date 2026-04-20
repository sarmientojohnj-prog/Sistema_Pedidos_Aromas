package controlador;

import java.io.IOException;
import java.sql.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/ActualizarClienteServlet")
public class ActualizarClienteServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 1. Recogemos lo que escribiste en los cuadros de texto
        String id = request.getParameter("idPersona");
        String nombre = request.getParameter("nombre");
        String apellidos = request.getParameter("apellidos");
        String identificacion = request.getParameter("identificacion");
        String telefono = request.getParameter("telefono");
        String correo = request.getParameter("correo");

        Connection con = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/aromas_duo", "root", "");

            // 2. Preparamos la orden de "Actualizar"
            String sql = "UPDATE persona SET Nombre=?, Apellidos=?, Identificacion=?, Telefono=?, Correo_Electronico=? WHERE IdPersona=?";
            
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, nombre);
            ps.setString(2, apellidos);
            ps.setString(3, identificacion);
            ps.setString(4, telefono);
            ps.setString(5, correo);
            ps.setInt(6, Integer.parseInt(id));

            // 3. Ejecutamos la orden
            ps.executeUpdate();

            // 4. ¡Éxito! Volvemos a la lista para ver el cambio
            response.sendRedirect("ConsultarClientesServlet?mensaje=actualizado");

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error al actualizar: " + e.getMessage());
        } finally {
            try { if (con != null) con.close(); } catch (Exception e) {}
        }
    }
}