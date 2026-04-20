package controlador;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import servicio.ClienteService;

@WebServlet("/ActualizarPerfilServlet")
public class ActualizarPerfilServlet extends HttpServlet {
    private ClienteService clienteService = new ClienteService();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 1. Recibimos lo que el usuario escribió en los cuadritos
        int id = Integer.parseInt(request.getParameter("id"));
        String nombre = request.getParameter("nombre");
        String apellidos = request.getParameter("apellidos");
        String direccion = request.getParameter("direccion");
        String telefono = request.getParameter("telefono");
        String email = request.getParameter("email");

        // 2. Le pedimos al servicio que actualice la base de datos
        boolean exito = clienteService.actualizarPerfilCompleto(id, nombre, apellidos, direccion, telefono, email);

        if (exito) {
            // 3. Si salió bien, volvemos al perfil con un mensaje de éxito
            response.sendRedirect("perfil.jsp?update=success");
        } else {
            response.sendRedirect("perfil.jsp?update=error");
        }
    }
}