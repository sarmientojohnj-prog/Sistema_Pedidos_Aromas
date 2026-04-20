<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Cambiar Contraseña - Aromas a Dúo</title>
    <style>
        body { font-family: 'Segoe UI', sans-serif; background-color: #f1f5f9; display: flex; justify-content: center; align-items: center; height: 100vh; margin: 0; }
        .card { background: white; padding: 30px; border-radius: 15px; box-shadow: 0 4px 15px rgba(0,0,0,0.1); width: 350px; text-align: center; }
        h2 { color: #1e293b; margin-bottom: 20px; }
        input { width: 100%; padding: 12px; margin: 10px 0; border: 1px solid #cbd5e1; border-radius: 8px; box-sizing: border-box; }
        button { width: 100%; background: #d97706; color: white; border: none; padding: 12px; border-radius: 8px; font-weight: bold; cursor: pointer; margin-top: 10px; }
        .volver { display: block; margin-top: 15px; color: #64748b; text-decoration: none; font-size: 0.9em; }
    </style>
</head>
<body>

<div class="card">
    <h2>🔐 Nueva Clave</h2>
    <form action="CambiarClaveServlet" method="POST">
        <input type="password" name="nuevaClave" placeholder="Escribe tu nueva contraseña" required>
        <input type="password" name="confirmarClave" placeholder="Confirma tu contraseña" required>
        <button type="submit">Actualizar Contraseña</button>
    </form>
    
    <a href="perfil_usuario.jsp" class="volver">⬅ Cancelar y volver</a>
</div>

</body>
</html>