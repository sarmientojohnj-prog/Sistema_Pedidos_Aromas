<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Nuevo Pedido - Aromas a Dúo</title>
    <style>
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; padding: 30px; background-color: #fef3c7; }
        /* Aumentamos a 600px para que los datos de la tabla se vean */
        .contenedor { background: white; padding: 25px; border-radius: 15px; box-shadow: 0px 4px 15px rgba(0,0,0,0.2); max-width: 600px; margin: auto; }
        h2 { color: #d97706; text-align: center; }
        label { font-weight: bold; color: #4b5563; display: block; margin-top: 10px; }
        input, select, textarea { width: 100%; padding: 12px; margin: 8px 0 20px 0; border: 1px solid #d1d5db; border-radius: 8px; box-sizing: border-box; }
        .btn-naranja { background-color: #ea580c; color: white; padding: 15px; width: 100%; border: none; border-radius: 8px; font-size: 16px; cursor: pointer; font-weight: bold; }
        .btn-naranja:hover { background-color: #c2410c; }
    </style>
</head>
<body>
    <div class="contenedor">
        <h2>Aromas a Dúo - Registrar Pedido</h2>
        <form action="PedidoServlet" method="POST" onsubmit="return prepararEnvio()">
            <label>Cliente:</label>
            <input type="text" name="id_cliente" value="2" readonly style="background-color: #e5e7eb; cursor: not-allowed;">
            
            <label>Tipo de Entrega:</label>
            <select name="tipo_entrega">
               <option value="En local">En local 🏠</option>
               <option value="Domicilio propio">Domicilio propio 🛵</option>
               <option value="Rappi">Rappi 🧡</option>
               <option value="Uber">Uber Eats 🥤</option>
               <option value="Domicilios.com">Domicilios.com 🔴</option>
            </select>

           <fieldset style="border: 1px solid #ea580c; border-radius: 8px; padding: 15px; margin-bottom: 20px;">
            <legend style="color: #ea580c; font-weight: bold; padding: 0 10px;">🍳 Añadir a la Orden</legend>

            <label>Selecciona tus productos:</label>
            <select id="selector_producto">
                <option value="">-- Elija el producto de tu preferencia --</option>
                <%
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/aromas_duo", "root", "");
                    Statement st = con.createStatement();
                    ResultSet rs = st.executeQuery("SELECT nombre, precio FROM productos");
                    while(rs.next()) {
                        String n = rs.getString("nombre");
                        double p = rs.getDouble("precio");
                %>
                    <option value="<%= p %>" data-nombre="<%= n %>"> <%= n %> ($<%= p %>) </option>
                <%
                    }
                    con.close();
                } catch (Exception e) {
                    out.println("<option value=''>Error al cargar: " + e.getMessage() + "</option>");
                }
                %>
            </select>

            <label>Cantidad (Porciones):</label>
            <input type="number" id="cantidad_producto" value="1" min="1" style="width: 80px;">

            <label>Notas adicionales del plato:</label>
            <input type="text" id="notas_item" placeholder="Ej: Sin cebolla, término medio, etc.">

            <button type="button" onclick="agregarAlPedido()" class="btn-naranja" style="background-color: #d97706;">
                Añadir al Pedido
            </button>
           </fieldset>

            <table id="tabla_pedido" style="width: 100%; border-collapse: collapse; margin-bottom: 20px; background-color: #fff; border: 1px solid #ddd;">
                <thead>
                    <tr style="background-color: #d97706; color: white; font-size: 13px;">
                    <th style="padding: 5px;">Plato</th>
                    <th style="padding: 5px;">Cant.</th>
                    <th style="padding: 5px;">Precio</th>
                    <th style="padding: 5px;">Notas</th>
                    <th style="padding: 5px;">Subtotal</th>
                    <th style="padding: 5px;">Acción</th>
                    </tr>
                </thead>
                <tbody id="cuerpo_pedido">
                </tbody>
            </table>>

            <label>Tu pedido cuesta:</label>
            <input type="number" name="total" value="0" readonly style="background-color: #e5e7eb; font-size: 20px; font-weight: bold; color: #d97706;">

            <input type="hidden" name="carrito_datos" id="carrito_datos">

            <button type="submit" class="btn-naranja">Confirmar y pagar</button>

            <div style="text-align: center; margin-top: 20px; border-top: 1px solid #ddd; padding-top: 20px;">
                <a href="index.jsp" style="text-decoration: none; background-color: #6b7280; color: white; padding: 10px 20px; border-radius: 8px; font-weight: bold; display: inline-block; margin-bottom: 10px;">
                    🏠 Volver al Inicio
                </a>
                <br>
                <a href="index.jsp" style="color: #ef4444; text-decoration: none; font-size: 14px; font-weight: bold;">
                    ❌ Cancelar y salir
                </a>
            </div>
        </form>
    </div>

    <script>
    let carrito = []; 

    function agregarAlPedido() {
        const selector = document.getElementById('selector_producto');
        if (selector.selectedIndex <= 0) {
            alert("Por favor, selecciona un producto.");
            return;
        }

        const opcion = selector.options[selector.selectedIndex];
        const nombre = opcion.getAttribute('data-nombre'); 
        const precio = parseFloat(selector.value);
        const cantidad = parseInt(document.getElementById('cantidad_producto').value);
        const notas = document.getElementById('notas_item').value.trim() || "Sin notas";

        // Si el data-nombre falla, lo sacamos del texto
        let nombreLimpio = nombre ? nombre : opcion.text.split(' ($')[0].trim();

        // Lógica de Agrupación
        const existente = carrito.find(item => item.nombre === nombreLimpio && item.notas === notas);

        if (existente) {
            existente.cantidad += cantidad;
            existente.subtotal = existente.cantidad * existente.precio;
        } else {
            carrito.push({
                nombre: nombreLimpio,
                precio: precio,
                cantidad: cantidad,
                notas: notas,
                subtotal: precio * cantidad
            });
        }

        renderizarTabla();
        
        // Limpiar campos
        document.getElementById('notas_item').value = "";
        document.getElementById('cantidad_producto').value = 1;
        selector.selectedIndex = 0;
    }

    function renderizarTabla() {
    const cuerpo = document.getElementById('cuerpo_pedido');
    if (!cuerpo) return;

    cuerpo.innerHTML = ""; 
    let totalGeneral = 0;

    carrito.forEach((item, index) => {
        totalGeneral += item.subtotal;
        
        const fila = cuerpo.insertRow();
        
        // Usamos comillas normales y el signo + para que Tomcat no se confunda
        fila.innerHTML = 
            '<td style="padding: 8px; border: 1px solid #ddd; text-align: left; color: #000; background-color: #f9f9f9;">' + item.nombre + '</td>' +
            '<td style="padding: 8px; border: 1px solid #ddd; color: #000; background-color: #f9f9f9;">' + item.cantidad + '</td>' +
            '<td style="padding: 8px; border: 1px solid #ddd; color: #000; background-color: #f9f9f9;">$' + item.precio + '</td>' +
            '<td style="padding: 8px; border: 1px solid #ddd; text-align: left; color: #000; background-color: #f9f9f9;"><small>' + item.notas + '</small></td>' +
            '<td style="padding: 8px; border: 1px solid #ddd; color: #000; background-color: #f9f9f9;">$' + item.subtotal + '</td>' +
            '<td style="padding: 8px; border: 1px solid #ddd; background-color: #f9f9f9;">' +
                '<button type="button" onclick="eliminarItem(' + index + ')" style="background:red; color:white; border:none; padding:2px 8px; border-radius:4px; cursor:pointer;">X</button>' +
            '</td>';
    });

    // Actualizar el total
    const campoTotal = document.getElementsByName('total')[0];
    if(campoTotal) {
        campoTotal.value = totalGeneral;
    }
}

    function eliminarItem(index) {
        carrito.splice(index, 1);
        renderizarTabla();
    }

    function prepararEnvio() {
    // 1. Validar: ¿El carrito está vacío?
    if (carrito.length === 0) {
        alert("No hay productos en el pedido. Agrega al menos uno.");
        return false; // Detiene el envío
    }

    // 2. Empacar: Convertimos la lista de productos en texto
    const datosParaEnvio = JSON.stringify(carrito);
    
    // 3. Guardar: Metemos ese texto en el input hidden que creamos
    document.getElementById('carrito_datos').value = datosParaEnvio;

    // 4. Confirmar: Pedimos el permiso final al cliente
    const total = document.getElementsByName('total')[0].value;
    return confirm("¿Confirmar pedido por $" + total + "?");
}
    
    </script>
</body>

</html>