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

@WebServlet("/ActualizarProductoServlet")
public class ActualizarProductoServlet extends HttpServlet {
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 1. Recogemos lo que el usuario escribió en los cuadros de texto
        int id = Integer.parseInt(request.getParameter("id"));
        String nombre = request.getParameter("nombre");
        String descripcion = request.getParameter("descripcion");
        String categoria = request.getParameter("categoria");
        double precio = Double.parseDouble(request.getParameter("precio"));
        int cantidad = Integer.parseInt(request.getParameter("cantidad"));

        String url = "jdbc:mysql://localhost:3306/aromas_duo";
        String usuario = "root";
        String clave = ""; 

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(url, usuario, clave);

            // 2. La orden mágica: UPDATE (Actualizar)
            String sql = "UPDATE productos SET Nombre=?, Descripcion=?, Categoria=?, Precio=?, Cantidad=? WHERE id_producto=?";
            
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, nombre);
            ps.setString(2, descripcion);
            ps.setString(3, categoria);
            ps.setDouble(4, precio);
            ps.setInt(5, cantidad);
            ps.setInt(6, id); // El ID es el que le dice a qué fila pegarle el cambio

            int filasAfectadas = ps.executeUpdate();

            con.close();

            // 3. Si todo salió bien, volvemos a la lista
            if (filasAfectadas > 0) {
                response.sendRedirect("ConsultarProductosServlet?mensaje=actualizado");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}