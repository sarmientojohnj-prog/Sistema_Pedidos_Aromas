package controlador;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet; // Agregamos esto
import java.sql.Statement; // Agregamos esto
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/RegistroEmpleadoServlet")
public class RegistroEmpleadoServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        String nombre = request.getParameter("nombre");
        String apellidos = request.getParameter("apellidos");
        String cedula = request.getParameter("cedula");
        String telefono = request.getParameter("telefono");
        String direccion = request.getParameter("direccion");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String rol = request.getParameter("rol");

        Connection con = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/aromas_duo", "root", "");

            // 1. Guardar en Persona (Ajustado a tu Foto 2)
            // Agregamos Correo_Electronico porque en tu foto de 'persona' aparece
            String sqlPersona = "INSERT INTO persona (Nombre, Apellidos, Identificacion, Direccion, Telefono, Correo_Electronico) VALUES (?, ?, ?, ?, ?, ?)";
            PreparedStatement psPersona = con.prepareStatement(sqlPersona, Statement.RETURN_GENERATED_KEYS);
            psPersona.setString(1, nombre);
            psPersona.setString(2, apellidos);
            psPersona.setString(3, cedula);
            psPersona.setString(4, direccion);
            psPersona.setString(5, telefono);
            psPersona.setString(6, email);
            psPersona.executeUpdate();

            // Atrapamos el ID que se creó solo
            ResultSet rs = psPersona.getGeneratedKeys();
            int idGenerado = 0;
            if (rs.next()) { idGenerado = rs.getInt(1); }

            // 2. Guardar en Usuario (Ajustado a tu Foto 1)
            // IMPORTANTE: Aquí cambiamos 'Correo_Electronico' por 'Nombre_Usuario' y agregamos 'Estado'
            String sqlUsuario = "INSERT INTO usuario (Id_Persona_FK, Nombre_Usuario, Estado, Rol, Contrasena) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement psUsuario = con.prepareStatement(sqlUsuario);
            psUsuario.setInt(1, idGenerado);
            psUsuario.setString(2, email);    // Esto va a la columna Nombre_Usuario
            psUsuario.setInt(3, 1);          // Estado Activo
            psUsuario.setString(4, rol);
            psUsuario.setString(5, password);
            psUsuario.executeUpdate();

            response.sendRedirect("admin_principal.jsp?status=ok");

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        } finally {
            try { if (con != null) con.close(); } catch (Exception e) {}
        }
    }
}