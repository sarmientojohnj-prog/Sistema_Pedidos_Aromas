package controlador;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import servicio.ClienteService;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet{

    private ClienteService clienteService = new ClienteService();
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String pass = request.getParameter("password");
            
        boolean esValido = clienteService.validarUsuario(email, pass);

        if (esValido) {
           response.sendRedirect("principal.jsp");
        } else {
            response.sendRedirect("login.jsp?error=true");
        }

    }
}
