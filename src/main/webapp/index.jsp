<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Aromas a Dúo - Inicio</title>
    <style>
        /* Estilos Generales */
        body { font-family: 'Segoe UI', sans-serif; background-color: #fef3c7; color: #333; margin: 0; padding: 0; text-align: center; }
        header { background-color: #d97706; color: white; padding: 40px 20px; box-shadow: 0 4px 10px rgba(0,0,0,0.1); }
        h1 { margin: 0; font-size: 2.5em; }
        
        /* Contenedor Principal */
        .container { max-width: 900px; margin: 30px auto; background: white; padding: 40px; border-radius: 20px; box-shadow: 0 10px 25px rgba(0,0,0,0.05); }
        
        /* Botones de Acceso */
        .acceso { margin-bottom: 40px; }
        .boton { 
            display: inline-block; width: 200px; padding: 15px; margin: 10px;
            text-decoration: none; color: white; border-radius: 10px; font-weight: bold;
            transition: transform 0.2s, background-color 0.2s;
        }
        .btn-login { background-color: #ea580c; }
        .btn-registro { background-color: #d97706; }
        .boton:hover { transform: scale(1.05); filter: brightness(1.1); }

        /* Navegación Informativa */
        .info-nav { background: #fff7ed; padding: 15px; border-radius: 10px; margin: 20px 0; }
        .info-nav a { text-decoration: none; color: #d97706; font-weight: bold; margin: 0 15px; }
        .info-nav a:hover { border-bottom: 2px solid #d97706; }

        /* Secciones de Contenido (Contacto y Reseñas) */
        .seccion-texto { text-align: left; margin-top: 40px; padding: 20px; border-top: 1px solid #eee; }
        .seccion-texto h2 { color: #d97706; }
        .perfil-resena { font-style: italic; color: #555; background: #fffbeb; padding: 10px; border-left: 4px solid #d97706; margin-bottom: 10px; }
        
        footer { margin-top: 50px; padding: 20px; font-size: 0.9em; color: #777; }
    </style>
</head>
<body>

    <header>
        <h1>Aromas a Dúo</h1>
        <p>Experiencias gastronómicas hechas con amor</p>
    </header>

    <div class="container">
        <section class="acceso">
            <h3>¿Listo para disfrutar?</h3>
            <a href="login.jsp" class="boton btn-login">Iniciar Sesión</a>
            <a href="registro_clientes.jsp" class="boton btn-registro">Registrarse</a>
        </section>

        <nav class="info-nav">
            <a href="menu_publico.jsp">🍴 Conoce el Menú</a>
            <a href="acerca_de.jsp">📖 Nuestra Historia</a>
            <a href="blog.jsp">✍️ Blog</a>
        </nav>

        <section class="seccion-texto">
            <h2>Lo que dicen nuestros clientes</h2>
            <div class="perfil-resena">
                "La comida mas deliciosa que he probado en toda la cuidad, todo me encanta!" <br>
                <strong>- Jasbleidy </strong>
            </div>
            <div class="perfil-resena">
                "Cada detalle es perfecto, todo llega de acuerdo a lo que se pide, la comida es simplemente deliciosa." <br>
                <strong>- Sarita S.</strong>
            </div>
        </section>

        <section class="seccion-texto">
            <h2>Ubícanos y Contáctanos</h2>
            <p>📍 Calle Principal del Sabor #123</p>
            <p>📞 Teléfono: +57 300 123 4567</p>
            <p>📧 Email: contacto@aromasaduo.com</p>
        </section>
    </div>

    <footer>
        <p>&copy; 2026 Aromas a Dúo - Desarrollado por Grupo 3</p>
    </footer>

</body>
</html>