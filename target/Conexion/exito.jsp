<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>¡Éxito!</title>
    <style>
        body { font-family: sans-serif; text-align: center; padding: 50px; background-color: #f0fdf4; }
        .card { background: white; padding: 30px; border-radius: 15px; display: inline-block; box-shadow: 0 4px 6px rgba(0,0,0,0.1); }
        h1 { color: #16a34a; }
    </style>
</head>
<body>
    <div class="card">
        <h1>✅ ¡Pedido Recibido!</h1>
        <p>Tu orden ha sido procesada correctamente.</p>
        <p>Referencia: <strong>${refFinal}</strong></p>
        <br>
        <a href="principal.jsp" style="color: #2563eb;">Volver al inicio</a>
    </div>
</body>
</html>