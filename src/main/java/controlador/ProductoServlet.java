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

@WebServlet("/ProductoServlet")
public class ProductoServlet extends HttpServlet {
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 1. Recoger las 5 piezas del formulario
        String nombre = request.getParameter("nombreProducto");
        String descripcion = request.getParameter("descripcionProducto"); // ¡Nueva!
        String categoria = request.getParameter("categoriaProducto");     // ¡Nueva!
        String precio = request.getParameter("precioProducto");
        String stock = request.getParameter("stockProducto");

        // Datos de tu base de datos
        String url = "jdbc:mysql://localhost:3306/aromas_duo"; 
        String usuario = "root"; 
        String clave = ""; // Si tienes clave en MySQL, ponla aquí

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(url, usuario, clave);

            // 2. Preparamos la orden con 5 espacios (?????)
            String sql = "INSERT INTO productos (Nombre, Descripcion, Categoria, Precio, Cantidad, Disponibilidad) VALUES (?, ?, ?, ?, ?, ?)";
            PreparedStatement ps = con.prepareStatement(sql);
            
            // 3. Llenamos los 5 espacios en orden
            ps.setString(1, nombre);
            ps.setString(2, descripcion);
            ps.setString(3, categoria);
            ps.setString(4, precio);
            ps.setString(5, stock);
            ps.setInt(6, 1);

            // 4. ¡A la bodega!
            ps.executeUpdate();

            ps.close();
            con.close();
            
            // Mensaje de éxito para que John sepa que funcionó
            response.setContentType("text/html");
            response.getWriter().println("<h1>¡Excelente John!</h1>");
            response.getWriter().println("<p>El producto <b>" + nombre + "</b> se guardó correctamente en la categoría <b>" + categoria + "</b>.</p>");
            response.getWriter().println("<a href='productos.jsp'>Volver a registrar otro</a>");

        } catch (Exception e) {
            response.getWriter().println("Hubo un problema: " + e.getMessage());
            e.printStackTrace();
        }
    }
}