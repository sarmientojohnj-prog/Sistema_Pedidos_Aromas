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

@WebServlet("/AsignarRepartidorServlet")
public class AsignarRepartidorServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String idPedidoStr = request.getParameter("id");
        Integer idRepartidor = (Integer) request.getSession().getAttribute("id_usuario");

        // --- ANÁLISIS DE ERROR EN CONSOLA ---
        System.out.println("--- ANÁLISIS DE DATOS RECIBIDOS ---");
        System.out.println("ID Pedido: " + idPedidoStr);
        System.out.println("ID Repartidor: " + idRepartidor);

        if (idPedidoStr != null && idRepartidor != null) {
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/aromas_duo", "root", "");
                
                String sql = "UPDATE pedidos SET Id_Repartidor_FK = ?, Estado_Pedido = 'En camino' WHERE Id_Pedido = ?";
                PreparedStatement ps = con.prepareStatement(sql);
                
                ps.setInt(1, idRepartidor);
                ps.setInt(2, Integer.parseInt(idPedidoStr));
                
                ps.executeUpdate();
                con.close();
                
                response.sendRedirect("reparto.jsp?msg=Asignado");
            } catch (Exception e) {
                e.printStackTrace(); // Esto mostrará el error detallado en la consola si algo falla
                response.sendRedirect("reparto.jsp?msg=Error");
            }
        } else {
            // Si falta algún dato, imprimimos por qué para saber
            System.out.println("ERROR: Datos incompletos. Pedido: " + idPedidoStr + ", Repartidor: " + idRepartidor);
            response.sendRedirect("login.jsp");
        }
    }
}