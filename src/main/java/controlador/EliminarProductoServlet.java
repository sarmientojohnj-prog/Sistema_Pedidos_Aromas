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

@WebServlet("/EliminarProductoServlet")
public class EliminarProductoServlet extends HttpServlet {
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 1. Recibimos el "id" que viene en la maleta (la URL)
        String idProducto = request.getParameter("id");

        String url = "jdbc:mysql://localhost:3306/aromas_duo";
        String usuario = "root";
        String clave = ""; 

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(url, usuario, clave);

            // 2. La orden de eliminación 
            String sql = "DELETE FROM productos WHERE id_producto = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, idProducto);

            // 3. Ejecutar la orden
            ps.executeUpdate();

            ps.close();
            con.close();

            // 4. Volver automáticamente a la lista actualizada
            response.sendRedirect("ConsultarProductosServlet?mensaje=eliminado");

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error al eliminar: " + e.getMessage());
        }
    }
}