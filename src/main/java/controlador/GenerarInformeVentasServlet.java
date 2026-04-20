package controlador;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/GenerarInformeVentasServlet")
public class GenerarInformeVentasServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("text/csv");
        response.setCharacterEncoding("UTF-8");
        response.setHeader("Content-Disposition", "attachment; filename=Informe_Ventas_AromasADuo.csv");

        Connection con = null;
        double sumaTotalGeneral = 0; 

        try (PrintWriter out = response.getWriter()) {
            // 1. Títulos
            out.println("ID Pedido;Cliente;Fecha;Estado;Tipo Entrega;Total");

            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/aromas_duo", "root", "");

            // 2. CONSULTA CORREGIDA SEGÚN TU IMAGEN
            // La columna es Id_Cliente_FK
            String sql = "SELECT p.Id_Pedido, per.Nombre, per.Apellidos, p.Fecha_Hora_Pedido, p.Estado_Pedido, p.Tipo_Entrega, p.Total " +
                         "FROM pedidos p " +
                         "LEFT JOIN persona per ON p.Id_Cliente_FK = per.IdPersona " + 
                         "ORDER BY p.Id_Pedido DESC";

            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                double totalVenta = rs.getDouble("Total");
                sumaTotalGeneral += totalVenta;

                out.print(rs.getInt("Id_Pedido") + ";");
                
                String nombre = rs.getString("Nombre");
                String apellido = rs.getString("Apellidos");
                if (nombre != null) {
                    out.print(nombre + " " + (apellido != null ? apellido : "") + ";");
                } else {
                    out.print("Cliente General;");
                }

                out.print(rs.getString("Fecha_Hora_Pedido") + ";");
                out.print(rs.getString("Estado_Pedido") + ";");
                out.print(rs.getString("Tipo_Entrega") + ";");
                out.println(totalVenta); 
            }

            // 3. El Gran Total
            out.println(";;;;;");
            out.println(";;;;TOTAL GENERAL:;" + sumaTotalGeneral);

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { if (con != null) con.close(); } catch (Exception e) {}
        }
    }
}