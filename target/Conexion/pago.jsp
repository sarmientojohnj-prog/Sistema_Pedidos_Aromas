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
        <div id="lista_resumen"></div>
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
            <a href="index.jsp" class="btn-volver">🏠 Volver al Inicio</a>
            <a href="nuevo_pedido.jsp" class="link-cancelar">⬅️ Volver al pedido / Cancelar</a>
        </div>
    </form>
</div>

<script>
    const datosRaw = '${sessionScope.listaProductos}';
    if (datosRaw && datosRaw !== 'null') {
        try {
            const carrito = JSON.parse(datosRaw);
            const contenedor = document.getElementById('lista_resumen');
            carrito.forEach(item => {
                const div = document.createElement('div');
                div.className = 'fila-item';
                div.innerHTML = '<span>' + item.cantidad + 'x ' + item.nombre + '</span>' +
                                '<span>$' + item.subtotal + '</span>';
                contenedor.appendChild(div);
            });
        } catch (e) {
            console.error("Error al procesar el carrito", e);
        }
    }
</script>

</body>
</html>