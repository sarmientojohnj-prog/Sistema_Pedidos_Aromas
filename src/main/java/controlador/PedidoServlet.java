package controlador;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
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

        String idCliente = request.getParameter("id_cliente");
        String tipoEntrega = request.getParameter("tipo_entrega");
        String totalStr = request.getParameter("total");
        String datosCarrito = request.getParameter("carrito_datos");

        Connection conn = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/aromas_duo", "root", "");

            // 1. INSERTAR EL PEDIDO (HU-07: Fecha_Hora_Pedido se guarda con NOW())
            String sqlPedido = "INSERT INTO pedidos (Id_Cliente_FK, Fecha_Hora_Pedido, Estado_Pedido, Total, Tipo_Entrega) VALUES (?, NOW(), 'En preparacion', ?, ?)";
            
            PreparedStatement psPedido = conn.prepareStatement(sqlPedido, Statement.RETURN_GENERATED_KEYS);
            psPedido.setInt(1, Integer.parseInt(idCliente));
            psPedido.setDouble(2, Double.parseDouble(totalStr));
            psPedido.setString(3, tipoEntrega);
            psPedido.executeUpdate();

            ResultSet rs = psPedido.getGeneratedKeys();
            int idPedidoCreado = 0;
            if (rs.next()) {
                idPedidoCreado = rs.getInt(1);
            }

            // 2. GUARDAR DETALLES Y DESCONTAR INVENTARIO (HU-06)
            if (idPedidoCreado > 0 && datosCarrito != null && !datosCarrito.isEmpty()) {
                String sqlDetalle = "INSERT INTO detalle_pedido (Id_Pedido_FK, Id_Producto_FK, Cantidad, Precio_Unitario) VALUES (?, ?, ?, ?)";
                String sqlStock = "UPDATE productos SET Cantidad = Cantidad - ? WHERE Id_Producto = ?"; // HU-06: Descuento real
                
                PreparedStatement psDetalle = conn.prepareStatement(sqlDetalle);
                PreparedStatement psStock = conn.prepareStatement(sqlStock);

                String limpio = datosCarrito.replace("[", "").replace("]", "").replace("},{", "}|{");
                String[] itemsJson = limpio.split("\\|");

                for (String itemStr : itemsJson) {
                    String nombre = extraerDato(itemStr, "nombre");
                    String cant = extraerDato(itemStr, "cantidad");
                    String precio = extraerDato(itemStr, "precio");
                    int cantidadPedida = (int)Double.parseDouble(cant);

                    // Buscar el ID del producto
                    int idProductoReal = 0;
                    String sqlBuscaId = "SELECT Id_Producto FROM productos WHERE Nombre = ?"; 
                    PreparedStatement psBusca = conn.prepareStatement(sqlBuscaId);
                    psBusca.setString(1, nombre);
                    ResultSet rsBusca = psBusca.executeQuery();
                    if(rsBusca.next()){
                        idProductoReal = rsBusca.getInt("Id_Producto");
                    }

                    if(idProductoReal > 0) {
                        // Insertar en detalle
                        psDetalle.setInt(1, idPedidoCreado);
                        psDetalle.setInt(2, idProductoReal);
                        psDetalle.setInt(3, cantidadPedida);
                        psDetalle.setDouble(4, Double.parseDouble(precio));
                        psDetalle.executeUpdate();

                        // Actualizar Stock (HU-06)
                        psStock.setInt(1, cantidadPedida);
                        psStock.setInt(2, idProductoReal);
                        psStock.executeUpdate();
                    }
                }
            }

            request.getSession().setAttribute("idPedidoActual", idPedidoCreado);
            request.getSession().setAttribute("totalAPagar", totalStr);
            request.getSession().setAttribute("metodoEnvio", tipoEntrega);
            request.getSession().setAttribute("carrito_datos", datosCarrito);

            response.sendRedirect("pago.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        } finally {
            if (conn != null) try { conn.close(); } catch (SQLException ex) {}
        }
    }

    private String extraerDato(String item, String clave) {
        try {
            String busqueda = "\"" + clave + "\":";
            int inicio = item.indexOf(busqueda) + busqueda.length();
            int fin = item.indexOf(",", inicio);
            if (fin == -1) fin = item.indexOf("}", inicio);
            
            String resultado = item.substring(inicio, fin).replace("\"", "");
            return resultado.trim();
        } catch (Exception e) {
            return "0";
        }
    }
}