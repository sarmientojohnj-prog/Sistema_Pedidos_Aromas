package controlador;

import java.io.IOException;
import java.sql.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/CambiarClaveServlet")
public class CambiarClaveServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String nuevaClave = request.getParameter("nuevaClave");
        String confirmarClave = request.getParameter("confirmarClave");
        
        // 1. Validamos que las claves sean iguales
        if (nuevaClave == null || !nuevaClave.equals(confirmarClave)) {
            response.sendRedirect("cambiar_clave.jsp?error=NoCoinciden");
            return;
        }

        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("email_sesion");

        Connection con = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/aromas_duo", "root", "");

            // 2. Actualizamos la tabla 'usuario' donde el Nombre_Usuario coincida con el de la sesión
            String sql = "UPDATE usuario SET Contrasena = ? WHERE Nombre_Usuario = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, nuevaClave);
            ps.setString(2, email);

            int filasAfectadas = ps.executeUpdate();

            if (filasAfectadas > 0) {
                // Éxito: Lo mandamos al perfil con un mensaje de confirmación
                response.sendRedirect("perfil_usuario.jsp?mensaje=ClaveActualizada");
            } else {
                response.sendRedirect("cambiar_clave.jsp?error=ErrorDB");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("cambiar_clave.jsp?error=" + e.getMessage());
        } finally {
            try { if (con != null) con.close(); } catch (Exception e) {}
        }
    }
}