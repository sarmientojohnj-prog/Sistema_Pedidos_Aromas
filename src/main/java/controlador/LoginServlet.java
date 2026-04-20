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
            // 1. Buscamos el nombre para el saludo
            String nombreReal = clienteService.obtenerNombrePorEmail(email);
            
            // 2. Buscamos el ROL usando el nuevo método que creaste
            String rol = clienteService.obtenerRolPorEmail(email); 

            //Le pedimos al servicio que nos traiga el ID usando el email
            int idUsuario = clienteService.obtenerIdPorEmail(email);

            // --- ESTO ES PARA EL ANÁLISIS ---
System.out.println("--- INTENTO DE LOGIN ---");
System.out.println("Email: " + email);
System.out.println("ID recuperado de la DB: " + idUsuario);
System.out.println("Rol: " + rol);
// -------------------------------

            // Guardamos todo en la sesión
            request.getSession().setAttribute("nombre", nombreReal); 
            request.getSession().setAttribute("email_sesion", email); 
            request.getSession().setAttribute("rol", rol); 
            // Guardamos el ID en la sesión para que "Mis Pedidos" lo encuentre
            request.getSession().setAttribute("id_usuario", idUsuario);

           // 3. Decidimos el camino según el rol (Separados)
        if ("Administrativo".equalsIgnoreCase(rol)) {
                // Si es el jefe, va al panel naranja con todas las opciones
                response.sendRedirect("admin_principal.jsp");
            } 
            else if ("Operativo".equalsIgnoreCase(rol) || "Repartidor".equalsIgnoreCase(rol)) {
                // Si es trabajador o repartidor, ambos van al panel operativo
                response.sendRedirect("operativo_principal.jsp");
}
            else {
                // Si es un cliente, va a la página de cowmpras normal
                response.sendRedirect("principal.jsp");
            }

        } else {
            response.sendRedirect("login.jsp?error=true");
        }
}
}