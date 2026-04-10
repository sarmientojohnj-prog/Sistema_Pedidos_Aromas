package controlador;

import java.io.IOException;
import java.sql.*;
import java.util.UUID;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/ConfirmarPagoServlet")
public class ConfirmarPagoServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 1. Recogemos los datos que vienen del formulario de pago.jsp
        String tipoMetodo = request.getParameter("tipo_metodo");
        String valorPagadoStr = request.getParameter("valor_pagado");

        // 1.1 SACAMOS EL ID DEL PEDIDO QUE GUARDAMOS EN LA SESIÓN (La pieza que faltaba)
        Integer idPedido = (Integer) request.getSession().getAttribute("idPedidoActual");

        // 2. GENERACIÓN AUTOMÁTICA DE REFERENCIA
        String numConfirmacion = "REF-" + UUID.randomUUID().toString().substring(0, 8).toUpperCase();
        
        Connection conn = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/aromas_duo", "root", "");
            
            conn.setAutoCommit(false);

            // 3. INSERT EN TABLA 'pago'
            String sqlPago = "INSERT INTO pago (Id_Pedido_FK, Fecha, Cantidad_Producto, Valor_Pagado, Pago_Finalizado, Numero_Confirmacion) VALUES (?, CURDATE(), ?, ?, 1, ?)";
        
            PreparedStatement psPago = conn.prepareStatement(sqlPago, Statement.RETURN_GENERATED_KEYS);
                psPago.setInt(1, idPedido); // <-- ¡Ahora sí Java sabe quién es idPedido!
                psPago.setInt(2, 1);
                psPago.setDouble(3, Double.parseDouble(valorPagadoStr));
                psPago.setString(4, numConfirmacion);
                psPago.executeUpdate();

            // Obtenemos el ID asignado
            ResultSet rs = psPago.getGeneratedKeys();
            int idPagoGenerado = 0;
            if (rs.next()) {
                idPagoGenerado = rs.getInt(1);
            }

            // 4. INSERT EN TABLA 'metodo_pago'
            String sqlMetodo = "INSERT INTO metodo_pago (Id_Pago_FK, TipoMetodo, DescripcionMetodo) VALUES (?, ?, ?)";
            PreparedStatement psMetodo = conn.prepareStatement(sqlMetodo);
                psMetodo.setInt(1, idPagoGenerado);
                psMetodo.setString(2, tipoMetodo);
                psMetodo.setString(3, "Pago exitoso desde plataforma"); 
                psMetodo.executeUpdate();

            conn.commit();
            
            request.getSession().setAttribute("refFinal", numConfirmacion);
            response.sendRedirect("exito.jsp");

        } catch (Exception e) {
            if (conn != null) try { conn.rollback(); } catch (SQLException ex) {}
            response.getWriter().println("Error al procesar el pago: " + e.getMessage());
            e.printStackTrace();
        } finally {
            if (conn != null) try { conn.close(); } catch (SQLException ex) {}
        }
    }
}