<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Menú - Aromas a Dúo</title>
    <style>
        body { font-family: 'Segoe UI', sans-serif; background-color: #fef3c7; margin: 0; padding: 0; }
        header { background-color: #d97706; color: white; padding: 20px; text-align: center; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        .container { max-width: 1200px; margin: 20px auto; padding: 20px; }
        .categoria-titulo { color: #ea580c; border-bottom: 3px solid #ea580c; margin-top: 40px; padding-bottom: 10px; }
        .menu-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(250px, 1fr)); gap: 25px; margin-top: 20px; }
        .producto-card { background: white; border-radius: 15px; padding: 20px; text-align: center; box-shadow: 0 5px 15px rgba(0,0,0,0.05); transition: transform 0.3s; display: flex; flex-direction: column; justify-content: space-between; }
        .producto-card:hover { transform: translateY(-10px); }
        .producto-card h3 { color: #333; margin: 10px 0; font-size: 1.2em; }
        .producto-card p { color: #666; font-size: 0.9em; height: 40px; overflow: hidden; }
        .precio { display: block; font-size: 1.3em; color: #d97706; font-weight: bold; margin: 15px 0; }
        .btn-ordenar { background-color: #ea580c; color: white; text-decoration: none; padding: 10px; border-radius: 8px; font-weight: bold; cursor: pointer; border: none; }
        .btn-ordenar:hover { background-color: #9a3412; }
        .volver { display: inline-block; margin-top: 20px; color: #d97706; text-decoration: none; font-weight: bold; }
        
        /* Estilos del Aviso (Modal) */
        #miModal { display:none; position:fixed; top:0; left:0; width:100%; height:100%; background:rgba(0,0,0,0.6); z-index:1000; justify-content:center; align-items:center; }
        .modal-contenido { background:white; padding:30px; border-radius:15px; text-align:center; max-width:400px; box-shadow: 0 5px 15px rgba(0,0,0,0.3); }
        .btn-login { background:#ea580c; color:white; padding:10px 20px; text-decoration:none; border-radius:8px; font-weight:bold; margin-right:10px; display: inline-block; }
        .btn-cerrar { background:#eee; border:none; padding:10px 20px; border-radius:8px; cursor:pointer; font-weight:bold; }
    </style>
</head>
<body>

<header>
    <h1>Nuestro Menú Delicioso</h1>
    <p>Calidad y sabor en cada bocado</p>
</header>

<div class="container">
    <a href="index.jsp" class="volver">← Volver al Inicio</a>

    <h2 class="categoria-titulo">🍔 Hamburguesas</h2>
    <div class="menu-grid">
        <div class="producto-card"><h3>Hamburguesa Clásica</h3><p>Carne 150g, queso, lechuga y tomate</p><span class="precio">$18.500</span><button onclick="mostrarAviso()" class="btn-ordenar">Ordenar ahora</button></div>
        <div class="producto-card"><h3>Hamburguesa Doble</h3><p>300g de carne, doble queso y tocino</p><span class="precio">$25.000</span><button onclick="mostrarAviso()" class="btn-ordenar">Ordenar ahora</button></div>
    </div>

    <h2 class="categoria-titulo">🍕 Pizzas</h2>
    <div class="menu-grid">
        <div class="producto-card"><h3>Pepperoni Mediana</h3><p>Masa artesanal con pepperoni y mozzarella</p><span class="precio">$32.000</span><button onclick="mostrarAviso()" class="btn-ordenar">Ordenar ahora</button></div>
        <div class="producto-card"><h3>Hawaiana Familiar</h3><p>Piña, jamón y extra queso</p><span class="precio">$45.000</span><button onclick="mostrarAviso()" class="btn-ordenar">Ordenar ahora</button></div>
    </div>

    <h2 class="categoria-titulo">🍟 Entradas y Acompañamientos</h2>
    <div class="menu-grid">
        <div class="producto-card"><h3>Papas Fritas</h3><p>Porción de 250g con salsa de la casa</p><span class="precio">$8.000</span><button onclick="mostrarAviso()" class="btn-ordenar">Ordenar ahora</button></div>
        <div class="producto-card"><h3>Alitas BBQ (x12)</h3><p>Alitas bañadas en salsa BBQ artesanal</p><span class="precio">$28.000</span><button onclick="mostrarAviso()" class="btn-ordenar">Ordenar ahora</button></div>
        <div class="producto-card"><h3>Nuggets Pollo</h3><p>6 trozos de pechuga apanada</p><span class="precio">$12.000</span><button onclick="mostrarAviso()" class="btn-ordenar">Ordenar ahora</button></div>
        <div class="producto-card"><h3>Empanadas (x5)</h3><p>Pequeñas empanadas crocantes</p><span class="precio">$10.000</span><button onclick="mostrarAviso()" class="btn-ordenar">Ordenar ahora</button></div>
        <div class="producto-card"><h3>Nachos con Queso</h3><p>Nachos crujientes con salsa caliente</p><span class="precio">$14.000</span><button onclick="mostrarAviso()" class="btn-ordenar">Ordenar ahora</button></div>
    </div>

    <h2 class="categoria-titulo">🍽️ Platos Especiales</h2>
    <div class="menu-grid">
        <div class="producto-card"><h3>Costillas BBQ</h3><p>Costillas de cerdo ahumadas</p><span class="precio">$38.000</span><button onclick="mostrarAviso()" class="btn-ordenar">Ordenar ahora</button></div>
        <div class="producto-card"><h3>Arroz Atollado</h3><p>Receta valluna lista para llevar</p><span class="precio">$24.000</span><button onclick="mostrarAviso()" class="btn-ordenar">Ordenar ahora</button></div>
        <div class="producto-card"><h3>Tacos de Carne</h3><p>Tortilla de maíz y pico de gallo</p><span class="precio">$18.000</span><button onclick="mostrarAviso()" class="btn-ordenar">Ordenar ahora</button></div>
        <div class="producto-card"><h3>Burrito de Pollo</h3><p>Gran tortilla con frijol, arroz y pollo</p><span class="precio">$22.000</span><button onclick="mostrarAviso()" class="btn-ordenar">Ordenar ahora</button></div>
    </div>

    <h2 class="categoria-titulo">🌭 Rápidas y Sandwiches</h2>
    <div class="menu-grid">
        <div class="producto-card"><h3>Perro Especial</h3><p>Salchicha americana, ripio y salsas</p><span class="precio">$12.000</span><button onclick="mostrarAviso()" class="btn-ordenar">Ordenar ahora</button></div>
        <div class="producto-card"><h3>Salchipapa Especial</h3><p>Papa, salchicha, queso y huevo</p><span class="precio">$15.000</span><button onclick="mostrarAviso()" class="btn-ordenar">Ordenar ahora</button></div>
        <div class="producto-card"><h3>Sandwich Cubano</h3><p>Jamón, cerdo, queso y pepinillos</p><span class="precio">$17.000</span><button onclick="mostrarAviso()" class="btn-ordenar">Ordenar ahora</button></div>
        <div class="producto-card"><h3>Club House</h3><p>Triple piso con pollo, huevo y tocino</p><span class="precio">$21.000</span><button onclick="mostrarAviso()" class="btn-ordenar">Ordenar ahora</button></div>
        <div class="producto-card"><h3>Wrap Vegetales</h3><p>Tortilla integral con vegetales salteados</p><span class="precio">$16.000</span><button onclick="mostrarAviso()" class="btn-ordenar">Ordenar ahora</button></div>
    </div>

    <h2 class="categoria-titulo">🥤 Bebidas</h2>
    <div class="menu-grid">
        <div class="producto-card"><h3>Coca-Cola 350ml</h3><p>Bebida fría en lata</p><span class="precio">$4.500</span><button onclick="mostrarAviso()" class="btn-ordenar">Ordenar ahora</button></div>
        <div class="producto-card"><h3>Jugo de Mora</h3><p>Vaso de 16oz en agua o leche</p><span class="precio">$7.000</span><button onclick="mostrarAviso()" class="btn-ordenar">Ordenar ahora</button></div>
        <div class="producto-card"><h3>Limonada Cerezada</h3><p>Refrescante con cerezas naturales</p><span class="precio">$8.500</span><button onclick="mostrarAviso()" class="btn-ordenar">Ordenar ahora</button></div>
        <div class="producto-card"><h3>Te Helado Limón</h3><p>Botella 400ml</p><span class="precio">$5.000</span><button onclick="mostrarAviso()" class="btn-ordenar">Ordenar ahora</button></div>
        <div class="producto-card"><h3>Agua Mineral</h3><p>Botella con o sin gas</p><span class="precio">$3.500</span><button onclick="mostrarAviso()" class="btn-ordenar">Ordenar ahora</button></div>
    </div>

    <h2 class="categoria-titulo">🍰 Postres</h2>
    <div class="menu-grid">
        <div class="producto-card"><h3>Malteada Choco</h3><p>Helado premium con crema batida</p><span class="precio">$12.000</span><button onclick="mostrarAviso()" class="btn-ordenar">Ordenar ahora</button></div>
        <div class="producto-card"><h3>Brownie con Helado</h3><p>Brownie melcochudo y vainilla</p><span class="precio">$9.000</span><button onclick="mostrarAviso()" class="btn-ordenar">Ordenar ahora</button></div>
        <div class="producto-card"><h3>Quesadilla Bocadillo</h3><p>Mucho queso y bocadillo</p><span class="precio">$8.000</span><button onclick="mostrarAviso()" class="btn-ordenar">Ordenar ahora</button></div>
    </div>
</div>

<div id="miModal">
    <div class="modal-contenido">
        <h2 style="color:#d97706;">¡Casi listo! 🍔</h2>
        <p>Para poder procesar tu pedido y que llegue a tu mesa, primero necesitamos saber quién eres.</p>
        <div style="margin-top:20px;">
            <a href="login.jsp" class="btn-login">Ir a Iniciar Sesión</a>
            <button onclick="cerrarAviso()" class="btn-cerrar">Seguir viendo</button>
        </div>
    </div>
</div>

<script>
    function mostrarAviso() { document.getElementById('miModal').style.display = 'flex'; }
    function cerrarAviso() { document.getElementById('miModal').style.display = 'none'; }
</script>

<footer>
    <p>&copy; 2026 Aromas a Dúo - Sabor que enamora</p>
</footer>

</body>
</html>