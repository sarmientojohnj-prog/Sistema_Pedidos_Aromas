<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="modelo.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Administración de Pedidos - Aromas a Dúo</title>
    <style>
        body { font-family: Arial; background-color: #f4f4f4; padding: 20px; }
        table { width: 100%; border-collapse: collapse; background: white; }
        th, td { border: 1px solid #ddd; padding: 10px; text-align: left; }
        th { background-color: #2c3e50; color: white; }
        tr:nth-child(even) { background-color: #f2f2f2; }
    </style>
</head>
<body>
    <h2>Lista de Pedidos Recibidos</h2>
    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Nombre Cliente</th>
                <th>Producto</th>
                <th>Cantidad</th>
                <th>Fecha</th>
            </tr>
        </thead>
        <tbody>
            <% 
                List<Pedido> lista = (List<Pedido>) request.getAttribute("misPedidos");
                if (lista != null) {
                    for (Pedido p : lista) {
            %>
            <tr>
                <td><%= p.getId_Pedido() %></td>
                <td><%= p.getId_Cliente_FK() %></td>
                <td><%= p.getFecha_Hora_Pedido() %></td>
                <td><%= p.getTipo_Entrega() %></td>
                <td><%= p.getEstado_Pedido() %></td>
            </tr>
            <% 
                    }
                } else {
            %>
            <tr>
                <td colspan="5">No hay pedidos registrados aún.</td>
            </tr>
            <% } %>
        </tbody>
    </table>
    <br>
    <a href="index.jsp">Volver al Formulario</a>
</body>
</html>