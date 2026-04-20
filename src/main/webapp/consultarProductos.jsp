<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    // BLOQUE DE SEGURIDAD
    String rol = (String) session.getAttribute("rol");
    if ("Repartidor".equals(rol)) {
        response.sendRedirect("principal.jsp");
        return;
    }
%>

<html>
<head>
    <title>Inventario de Productos</title>
    <style>
        table { border-collapse: collapse; width: 100%; }
        th, td { border: 1px solid #ddd; padding: 8px; text-align: left; }
        th { background-color: #4CAF50; color: white; }
    </style>
</head>
<body>
    <h2>Lista de Productos en Inventario</h2>

    <% 
        if ("eliminado".equals(request.getParameter("mensaje"))) { 
    %>
        <p style="color: #28a745; font-weight: bold; background-color: #d4edda; padding: 10px; border: 1px solid #c3e6cb; border-radius: 5px;">
            ¡Producto eliminado correctamente!
        </p>
    <% 
        } 
    %>

    <% 
        if ("actualizado".equals(request.getParameter("mensaje"))) { 
    %>
        <p style="color: #ffffff; font-weight: bold; background-color: #007bff; padding: 10px; border: 1px solid #0056b3; border-radius: 5px;">
            ¡Producto actualizado con éxito!
        </p>
    <% 
        } 
    %>

    <div style="margin-bottom: 25px; width: 100%; display: flex; justify-content: center; font-family: 'Segoe UI', sans-serif;">
    <form action="ConsultarProductosServlet" method="GET" style="display: flex; gap: 10px; align-items: center; background: white; padding: 15px 25px; border-radius: 10px; box-shadow: 0 4px 10px rgba(0,0,0,0.08);">
        
        <input type="text" name="buscar" placeholder="Escribe el nombre del producto..." 
               style="width: 320px; padding: 12px; border: 1px solid #ddd; border-radius: 6px; font-size: 15px; outline: none; transition: border-color 0.3s;">
        
        <button type="submit" style="background-color: #2c3e50; color: white; padding: 12px 24px; border: none; border-radius: 6px; font-size: 15px; font-weight: bold; cursor: pointer; transition: background 0.3s; display: flex; align-items: center; gap: 8px;">
            <span>🔍</span> Buscar
        </button>
        
        <a href="ConsultarProductosServlet" style="text-decoration: none; color: #e74c3c; font-size: 14px; font-weight: 600; margin-left: 10px; padding: 10px; border-radius: 6px; transition: background 0.3s;">
            ✕ Limpiar filtros
        </a>
    </form>
</div>

<%
    // Boton de regreso inteligente
    String rolParaVolver = (String) session.getAttribute("rol");
    String destino = "principal.jsp"; 

    if ("Administrativo".equals(rolParaVolver)) {
        destino = "admin_principal.jsp";
    } else if ("Operativo".equals(rolParaVolver)) {
        destino = "operativo_principal.jsp";
    }
%>

<div style="width: 100%; display: flex; justify-content: space-between; margin-bottom: 15px; font-family: 'Segoe UI', sans-serif;">
    
    <a href="<%= destino %>" style="text-decoration: none; background-color: #64748b; color: white; padding: 10px 20px; border-radius: 8px; font-weight: bold;">
        ⬅ Volver al Panel
    </a>

    <% if ("Administrativo".equals(rolParaVolver)) { %>
        <a href="productos.jsp" style="text-decoration: none; background-color: #28a745; color: white; padding: 10px 20px; border-radius: 5px; font-weight: bold; box-shadow: 0 2px 5px rgba(0,0,0,0.1);">
            + Registrar Nuevo Producto
        </a>
    <% } %>
</div>

    <table>
        <tr>
            <th>Nombre</th>
            <th>Descripción</th>
            <th>Categoría</th>
            <th>Precio</th>
            <th>Stock</th>
            <th>Acciones</th> </tr>
        </tr>
       
        <% 
            String datos = (String) request.getAttribute("listaProductos");
            if (datos != null) { 
                out.print(datos); 
            } 
        %>

    </table> 

    <br>
    
</body>
</html>