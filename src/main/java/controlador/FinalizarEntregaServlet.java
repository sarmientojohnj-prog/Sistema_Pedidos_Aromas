package controlador;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

// Esta anotación es VITAL para poder recibir la foto (archivos)
@WebServlet("/FinalizarEntregaServlet")
@MultipartConfig(maxFileSize = 1024 * 1024 * 5) // Límite de 5MB por foto
public class FinalizarEntregaServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 1. Recibimos los datos del formulario
        String idPedido = request.getParameter("txtIdPedido");
        String comentario = request.getParameter("txtComentario");
        Part fotoPart = request.getPart("fotoEvidencia"); // Aquí viene la imagen
        
        InputStream inputStream = null;
        if (fotoPart != null) {
            inputStream = fotoPart.getInputStream();
        }

        try {
            // 2. Conexión a la base de datos
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/aromas_duo", "root", "");

            // 3. Actualizamos el pedido: Estado a 'Entregado' y guardamos la foto y el comentario
            // Nota: Asegúrate de que tu tabla 'pedidos' tenga la columna 'Foto_Evidencia' (tipo BLOB) y 'Comentario_Repartidor'
            String sql = "UPDATE pedidos SET Estado_Pedido = 'Entregado', Foto_Evidencia = ?, Comentario_Repartidor = ? WHERE Id_Pedido = ?";
            
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setBlob(1, inputStream); // Guardamos la imagen
            ps.setString(2, comentario);
            ps.setInt(3, Integer.parseInt(idPedido));

            ps.executeUpdate();
            con.close();

            // 4. Si todo sale bien, mandamos a Juan de vuelta a su panel con éxito
            response.sendRedirect("reparto.jsp?msg=Finalizado");

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error al finalizar entrega: " + e.getMessage());
        }
    }
}