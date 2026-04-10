package controlador;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement; // <--- AGREGAMOS ESTA LÍNEA (La pieza que faltaba)
import java.util.ArrayList;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import modelo.Pedido;
import servicio.PedidoService;

@WebServlet("/PedidoServlet")
public class PedidoServlet extends HttpServlet {

    private PedidoService service = new PedidoService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        ArrayList<Pedido> lista = service.listarPedidos();
        request.setAttribute("misPedidos", lista);
        request.getRequestDispatcher("admin_pedidos.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Recibimos los datos del formulario
        String idCliente = request.getParameter("id_cliente");
        String tipoEntrega = request.getParameter("tipo_entrega");
        String totalStr = request.getParameter("total");
        String datosCarrito = request.getParameter("carrito_datos");

        Connection conn = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/aromas_duo", "root", "");

           // 2. INSERTAR EL PEDIDO PRIMERO

           String sqlPedido = "INSERT INTO pedidos (Id_Cliente_FK, Fecha_Hora_Pedido, Estado_Pedido, Total, Tipo_Entrega) VALUES (?, NOW(), 'En preparacion', ?, ?)";
           
           PreparedStatement psPedido = conn.prepareStatement(sqlPedido, Statement.RETURN_GENERATED_KEYS);
           psPedido.setInt(1, Integer.parseInt(idCliente));
           // Aquí mandamos el total a la columna 'Total'
           psPedido.setDouble(2, Double.parseDouble(totalStr));
           psPedido.setString(3, tipoEntrega);
           psPedido.executeUpdate();

            // 3. OBTENER EL ID DEL PEDIDO QUE SE ACABA DE CREAR
            ResultSet rs = psPedido.getGeneratedKeys();
            int idPedidoCreado = 0;
            if (rs.next()) {
                idPedidoCreado = rs.getInt(1);
            }

            // 4. GUARDAR LOS DATOS EN LA SESIÓN
            request.getSession().setAttribute("idPedidoActual", idPedidoCreado);
            request.getSession().setAttribute("totalAPagar", totalStr);
            request.getSession().setAttribute("metodoEnvio", tipoEntrega);
            request.getSession().setAttribute("listaProductos", datosCarrito);

            // 5. Ir a la pantalla de pago
            response.sendRedirect("pago.jsp");

        } catch (Exception e) {
            response.getWriter().println("Error al crear el pedido: " + e.getMessage());
            e.printStackTrace();
        } finally {
            if (conn != null) try { conn.close(); } catch (SQLException ex) {}
        }
    }
}