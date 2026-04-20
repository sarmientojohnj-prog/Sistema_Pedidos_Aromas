<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // SEGURIDAD: Solo Repartidores o Admins
    Object rolS = session.getAttribute("rol");
    if (rolS == null || (!"Repartidor".equals(rolS) && !"Administrativo".equals(rolS))) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    // Obtenemos el ID del pedido que Juan va a entregar
    String idPedido = request.getParameter("id");
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Finalizar Entrega - Aromas a Dúo</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        body { font-family: 'Segoe UI', sans-serif; background: #f8fafc; padding: 20px; }
        .contenedor { max-width: 500px; margin: auto; background: white; padding: 30px; border-radius: 15px; box-shadow: 0 10px 15px -3px rgba(0,0,0,0.1); }
        h2 { color: #1e293b; text-align: center; }
        .campo { margin-bottom: 20px; }
        label { display: block; font-weight: bold; margin-bottom: 8px; color: #475569; }
        input[type="file"], textarea { width: 100%; padding: 12px; border: 1px solid #cbd5e1; border-radius: 8px; box-sizing: border-box; }
        textarea { height: 100px; resize: none; }
        .btn-finalizar { width: 100%; background: #10b981; color: white; padding: 15px; border: none; border-radius: 10px; font-size: 18px; font-weight: bold; cursor: pointer; transition: 0.3s; }
        .btn-finalizar:hover { background: #059669; }
        .info-pedido { background: #f1f5f9; padding: 10px; border-radius: 8px; text-align: center; margin-bottom: 20px; font-weight: bold; color: #3b82f6; }
    </style>
</head>
<body>

<div class="contenedor">
    <h2>✅ Finalizar Entrega</h2>
    <div class="info-pedido">Pedido #<%= idPedido %></div>

    <form action="FinalizarEntregaServlet" method="post" enctype="multipart/form-data">
        <input type="hidden" name="txtIdPedido" value="<%= idPedido %>">

        <div class="campo">
            <label>📸 Foto de evidencia:</label>
            <input type="file" name="fotoEvidencia" accept="image/*" capture="camera" required>
        </div>

        <div class="campo">
            <label>💬 Comentarios del repartidor:</label>
            <textarea name="txtComentario" placeholder="Ej: Entregado en recepción, cliente recibió conforme..."></textarea>
        </div>

        <button type="submit" class="btn-finalizar">Confirmar Entrega Total</button>
    </form>
</div>

</body>
</html>