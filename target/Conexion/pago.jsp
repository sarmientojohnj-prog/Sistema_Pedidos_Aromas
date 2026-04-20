<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Resumen de Pago - Aromas a Dúo</title>
    <style>
        body { font-family: sans-serif; background-color: #f4f4f4; padding: 30px; }
        .caja-pago { background: white; padding: 25px; border-radius: 12px; max-width: 500px; margin: auto; box-shadow: 0 4px 10px rgba(0,0,0,0.1); }
        h2 { color: #d97706; text-align: center; }
        .detalle-productos { background: #fffbeb; border: 1px solid #fcd34d; padding: 15px; border-radius: 8px; margin: 15px 0; font-size: 14px; }
        .fila-item { display: flex; justify-content: space-between; border-bottom: 1px solid #fee2e2; padding: 5px 0; }
        .total-grande { font-size: 24px; color: #ea580c; font-weight: bold; text-align: center; margin: 20px 0; }
        .btn-confirmar { background: #10b981; color: white; border: none; padding: 15px; width: 100%; border-radius: 8px; font-weight: bold; cursor: pointer; }
        /* Estilo para los botones de navegación */
        .seccion-botones { text-align: center; margin-top: 20px; border-top: 1px solid #ddd; padding-top: 20px; }
        .btn-volver { text-decoration: none; background-color: #6b7280; color: white; padding: 10px 20px; border-radius: 8px; font-weight: bold; display: inline-block; margin-bottom: 10px; }
        .link-cancelar { color: #ef4444; text-decoration: none; font-size: 14px; font-weight: bold; display: block; margin-top: 10px; }
    </style>
</head>
<body>

<div class="caja-pago">
    <h2>💳 Resumen de tu Compra</h2>

    <div class="detalle-productos">
        <p><strong>Tus productos:</strong></p>
        <%
            // Recuperamos la lista que el Servlet guardó en la sesión
            String datosRaw = (String) session.getAttribute("carrito_datos"); 
            if (datosRaw != null && !datosRaw.isEmpty()) {
                try {
                    // Limpiamos los corchetes y separamos cada producto
                    String limpio = datosRaw.replace("[", "").replace("]", "").replace("},{", "}|{").replace("{", "").replace("}", "");
                    String[] items = limpio.split("\\|");
                    
                    for (String item : items) {
                        // Buscamos el nombre y el subtotal dentro del texto
                        String[] partes = item.split(",");
                        String nombre = "";
                        String subtotal = "";
                        String cantidad = "";

                        for(String p : partes) {
                            if(p.contains("nombre")) nombre = p.split(":")[1].replace("\"", "");
                            if(p.contains("subtotal")) subtotal = p.split(":")[1];
                            if(p.contains("cantidad")) cantidad = p.split(":")[1];
                        }
        %>
                        <div class="fila-item">
                            <span><%= cantidad %>x <%= nombre %></span>
                            <span>$<%= subtotal %></span>
                        </div>
        <%
                    }
                } catch (Exception e) {
                    out.println("Error al mostrar productos.");
                }
            } else {
                out.println("<p>No hay productos en el resumen.</p>");
            }
        %>
    </div>

    <div class="total-grande">
        Total a Pagar: $ ${sessionScope.totalAPagar}
    </div>

    <form action="ConfirmarPagoServlet" method="POST">
        <label><b>Método de Pago:</b></label>
        <select name="tipo_metodo" style="width: 100%; padding: 10px; margin-top: 5px; margin-bottom: 20px;">
            <option value="Efectivo">Efectivo 💵</option>
            <option value="Transferencia">Transferencia 📱</option>
            <option value="T Debito">Tarjeta Débito 💳</option>
            <option value="T Credito">Tarjeta Crédito 💳</option>
        </select>

        <input type="hidden" name="valor_pagado" value="${sessionScope.totalAPagar}">
        
        <button type="submit" class="btn-confirmar">Confirmar Pago Ahora</button>

        <div class="seccion-botones">
            <a href="principal.jsp" class="btn-volver">🏠 Volver al Inicio</a>
            <a href="nuevo_pedido.jsp" class="link-cancelar">⬅️ Volver al pedido / Cancelar</a>
        </div>
    </form>
</div>

</body>
</html>