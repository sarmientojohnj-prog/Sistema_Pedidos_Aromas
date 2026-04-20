<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Blog - Aromas a Dúo</title>
    <style>
        body { font-family: 'Segoe UI', sans-serif; background-color: #fef3c7; color: #333; margin: 0; padding: 0; }
        header { background-color: #d97706; color: white; padding: 30px; text-align: center; }
        .container { max-width: 900px; margin: 30px auto; padding: 20px; }
        
        /* Estilo de las entradas del blog */
        .post { background: white; padding: 25px; border-radius: 15px; margin-bottom: 30px; box-shadow: 0 5px 15px rgba(0,0,0,0.05); border-left: 6px solid #ea580c; }
        .post h2 { color: #d97706; margin-top: 0; }
        .fecha { color: #999; font-size: 0.85em; margin-bottom: 15px; display: block; }
        .leer-mas { color: #ea580c; font-weight: bold; text-decoration: none; }
        .leer-mas:hover { text-decoration: underline; }
        
        .volver { display: inline-block; margin-bottom: 20px; color: #d97706; text-decoration: none; font-weight: bold; }
    </style>
</head>
<body>

<header>
    <h1>Blog Aromas a Dúo</h1>
    <p>Consejos, noticias y mucho sabor</p>
</header>

<div class="container">
    <a href="index.jsp" class="volver">← Volver al Inicio</a>

    <article class="post">
        <span class="fecha">Publicado el 13 de abril, 2026</span>
        <h2>5 Beneficios de un buen café por la mañana</h2>
        <p>El café no solo nos despierta, también está lleno de antioxidantes que ayudan a tu cuerpo a mantenerse joven y activo. En Aromas a Dúo seleccionamos los mejores granos para que cada taza sea una experiencia única...</p>
        <a href="#" class="leer-mas">Leer más →</a>
    </article>

    <article class="post">
        <span class="fecha">Publicado el 10 de abril, 2026</span>
        <h2>Cuidados básicos para tu piel en casa</h2>
        <p>Mantener una piel radiante no tiene por qué ser difícil. Hoy te compartimos tres pasos esenciales: limpieza profunda, hidratación constante y, por supuesto, una alimentación balanceada. ¡Visita nuestro centro de estética para saber más!</p>
        <a href="#" class="leer-mas">Leer más →</a>
    </article>

    <article class="post">
        <span class="fecha">Publicado el 5 de abril, 2026</span>
        <h2>¿Por qué elegir masa artesanal en nuestras pizzas?</h2>
        <p>La diferencia está en el tiempo de fermentación. Nuestra masa reposa el tiempo justo para que sea ligera, crocante y fácil de digerir. Ven y prueba la diferencia en nuestra pizza de Pepperoni...</p>
        <a href="#" class="leer-mas">Leer más →</a>
    </article>

</div>

<footer>
    <p style="text-align: center; color: #777; padding: 20px;">&copy; 2026 Aromas a Dúo - Blog Familiar</p>
</footer>

</body>
</html>