package controlador;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/EditarProductoServlet")
public class EditarProductoServlet extends HttpServlet {
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 1. Recoger el ID que viene del botón azul de editar
        String idParam = request.getParameter("id");
        int id = Integer.parseInt(idParam);

        String url = "jdbc:mysql://localhost:3306/aromas_duo";
        String usuario = "root";
        String clave = ""; 

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(url, usuario, clave);

            // 2. Buscar SOLO ese producto por su ID
            String sql = "SELECT * FROM productos WHERE id_producto = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                // 3. Guardar los datos encontrados en una "bolsa" llamada request
                request.setAttribute("id", rs.getInt("id_producto"));
                request.setAttribute("nombre", rs.getString("Nombre"));
                request.setAttribute("descripcion", rs.getString("Descripcion"));
                request.setAttribute("categoria", rs.getString("Categoria"));
                request.setAttribute("precio", rs.getDouble("Precio"));
                request.setAttribute("cantidad", rs.getInt("Cantidad"));
            }

            // 4. Mandar todo al formulario de edición (que crearemos en el siguiente paso)
            request.getRequestDispatcher("editarProducto.jsp").forward(request, response);
            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
