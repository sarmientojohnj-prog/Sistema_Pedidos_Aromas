package controlador;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

@WebServlet("/CalificarPedidoServlet")
public class CalificarPedidoServlet extends HttpServlet {
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 1. Recoger los datos que vienen del formulario JSP
        String idPedido = request.getParameter("idPedido");
        String calificacion = request.getParameter("calificacion");
        String comentario = request.getParameter("comentario");

        // Datos de conexión (Asegúrate que sean iguales a los tuyos)
        String url = "jdbc:mysql://localhost:3306/aromas_duo";
        String user = "root";
        String pass = "";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(url, user, pass);

            // 2. Preparar la "orden" para la base de datos
            // Vamos a actualizar (UPDATE) el pedido que ya existe
            String sql = "UPDATE pedidos SET Calificacion_Cliente = ?, Comentario_Cliente = ? WHERE Id_Pedido = ?";
            
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, Integer.parseInt(calificacion)); // La nota (1-5)
            ps.setString(2, comentario);                  // El texto
            ps.setInt(3, Integer.parseInt(idPedido));     // Cuál pedido es

            // 3. Ejecutar la acción
            ps.executeUpdate();
            
            con.close();

            // 4. Mandar al cliente de vuelta a su historial con un mensaje de éxito
            response.sendRedirect("mis_pedidos.jsp?mensaje=Gracias por tu calificacion");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("mis_pedidos.jsp?error=" + e.getMessage());
        }
    }
}