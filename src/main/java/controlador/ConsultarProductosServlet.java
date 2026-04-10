package controlador;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/ConsultarProductosServlet")
public class ConsultarProductosServlet extends HttpServlet {
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String url = "jdbc:mysql://localhost:3306/aromas_duo";
        String usuario = "root";
        String clave = ""; // Tu clave de MySQL

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(url, usuario, clave);
            
            // 1. Capturamos el término de búsqueda
            String terminoBusqueda = request.getParameter("buscar");
            String sql;

            if (terminoBusqueda != null && !terminoBusqueda.trim().isEmpty()) {
            // Si hay búsqueda, la orden es FILTRAR
            sql = "SELECT * FROM productos WHERE Nombre LIKE '%" + terminoBusqueda + "%'";
            } else {
            // Si está vacío, la orden es TRAER TODOS LOS REGISTROS
            sql = "SELECT * FROM productos";
            }

    Statement st = con.createStatement();
    ResultSet rs = st.executeQuery(sql);

            // 2. Crear una lista para guardar temporalmente lo que encontremos
            StringBuilder tablaHtml = new StringBuilder();

            while (rs.next()) {
                int id = rs.getInt("id_producto");
                tablaHtml.append("<tr>");
                tablaHtml.append("<td>").append(rs.getString("Nombre")).append("</td>");
                tablaHtml.append("<td>").append(rs.getString("Descripcion")).append("</td>");
                tablaHtml.append("<td>").append(rs.getString("Categoria")).append("</td>");
                tablaHtml.append("<td>").append(rs.getString("Precio")).append("</td>");
                tablaHtml.append("<td>").append(rs.getString("Cantidad")).append("</td>");
                tablaHtml.append("<td>");
                tablaHtml.append("<a href='EditarProductoServlet?id=" + id + "' style='color:blue; margin-right:10px;'>Editar</a>");
                tablaHtml.append("<a href='EliminarProductoServlet?id=" + id + "' style='color:red;' onclick='return confirm(\"¿Estás seguro de que quieres eliminar este producto?\")'>Eliminar</a>");
                tablaHtml.append("</td>");
                tablaHtml.append("</tr>");
                
            }

            // 3. Mandar la lista a la página JSP
            request.setAttribute("listaProductos", tablaHtml.toString());
            request.getRequestDispatcher("consultarProductos.jsp").forward(request, response);

            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}