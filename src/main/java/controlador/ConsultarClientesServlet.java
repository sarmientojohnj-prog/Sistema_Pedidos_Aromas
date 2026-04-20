package controlador;

import java.io.IOException;
import java.sql.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/ConsultarClientesServlet")
public class ConsultarClientesServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        Connection con = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/aromas_duo", "root", "");

            // Buscamos a las personas que NO son ni administrativos ni operativos (o sea, clientes)
            // O simplemente traemos a todos los que tengan el Rol 'Cliente' en la tabla usuario
            String sql = "SELECT p.IdPersona, p.Nombre, p.Apellidos, p.Identificacion, p.Telefono, p.Correo_Electronico " +
                         "FROM persona p " +
                         "INNER JOIN usuario u ON p.IdPersona = u.Id_Persona_FK " +
                         "WHERE u.Rol = 'Cliente'";

            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            StringBuilder tabla = new StringBuilder();

            while (rs.next()) {
                tabla.append("<tr>");
                tabla.append("<td>").append(rs.getString("Nombre")).append(" ").append(rs.getString("Apellidos")).append("</td>");
                tabla.append("<td>").append(rs.getString("Identificacion")).append("</td>");
                tabla.append("<td>").append(rs.getString("Telefono")).append("</td>");
                tabla.append("<td>").append(rs.getString("Correo_Electronico")).append("</td>");
    
                // Aquí empieza la zona de botones
                tabla.append("<td>");

                // 1. EL BOTÓN EDITAR: Lo ven todos (Administrativos y Operativos)
                tabla.append("<a href='EditarClienteServlet?id=").append(rs.getInt("IdPersona")).append("' class='btn btn-edit'>✏️ Editar</a> ");

                // 2. EL SENSOR DE ROL:
                // Le preguntamos a la sesión: "¿Quién está mirando esto ahora mismo?"
                String rolActual = (String) request.getSession().getAttribute("rol");

                // 3. EL CANDADO: Solo si el que mira es "Administrativo", dibujamos el botón de borrar
                if ("Administrativo".equalsIgnoreCase(rolActual)) {
                tabla.append("<a href='EliminarClienteServlet?id=").append(rs.getInt("IdPersona")).append("' class='btn btn-delete' onclick='return confirm(\"¿Estás seguro de eliminar este cliente?\")'>🗑️ Eliminar</a>");
                }

            tabla.append("</td>");
            tabla.append("</tr>");
            }

            request.setAttribute("listaClientes", tabla.toString());
            request.getRequestDispatcher("consultar_clientes.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { if (con != null) con.close(); } catch (Exception e) {}
        }
    }
}