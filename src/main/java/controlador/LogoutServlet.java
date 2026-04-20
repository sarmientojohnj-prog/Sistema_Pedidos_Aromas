package controlador;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/LogoutServlet")
public class LogoutServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 1. Buscamos la sesión actual (la maleta)
        HttpSession session = request.getSession(false);
        
        if (session != null) {
            // 2. ¡La quemamos! Borramos todos los datos guardados
            session.invalidate();
        }
        
        // 3. Mandamos al usuario al index que es la pagina de inicio
        response.sendRedirect("index.jsp");
    }
}