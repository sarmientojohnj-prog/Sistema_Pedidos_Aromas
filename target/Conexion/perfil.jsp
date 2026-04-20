<%@ page import="modelo.Cliente" %>
<%@ page import="servicio.ClienteService" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    // 1. Verificamos seguridad
    String emailUsuario = (String) session.getAttribute("email_sesion");
    if (emailUsuario == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // 2. Buscamos los datos reales en la base de datos
    ClienteService servicio = new ClienteService();
    Cliente miPerfil = servicio.obtenerDatosCompletosPorEmail(emailUsuario);
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Mi Perfil - Aromas a Dúo</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <div class="container mt-5">
        <div class="card shadow-lg border-0">
            <div class="card-header bg-dark text-white text-center">
                <h3>Gestionar Mi Perfil 👤</h3>
            </div>
            
            <div class="card-body p-4">
                
                <%-- PARTE B: MENSAJE DE ÉXITO --%>
                <% if ("success".equals(request.getParameter("update"))) { %>
                    <div class="alert alert-success text-center alert-dismissible fade show" role="alert">
                        ✅ ¡Tus datos se actualizaron con éxito!
                    </div>
                <% } %>
                <% if ("error".equals(request.getParameter("update"))) { %>
                    <div class="alert alert-danger text-center">
                        ❌ Hubo un error al actualizar los datos.
                    </div>
                <% } %>

                <%-- PARTE A: EL FORMULARIO CON LA CONFIRMACIÓN --%>
                <form action="ActualizarPerfilServlet" method="post" onsubmit="return confirm('¿Estás seguro de que deseas actualizar tus datos personales?');">
                    
                    <input type="hidden" name="id" value="<%= miPerfil.getId() %>">

                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label font-weight-bold">Nombre</label>
                            <input type="text" name="nombre" class="form-control" value="<%= miPerfil.getNombre() %>">
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Apellidos</label>
                            <input type="text" name="apellidos" class="form-control" value="<%= miPerfil.getApellidos() %>">
                        </div>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Identificación</label>
                        <input type="text" class="form-control" value="<%= miPerfil.getIdentificacion() %>" readonly>
                        <small class="text-muted">La identificación no se puede cambiar por seguridad.</small>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Correo Electrónico</label>
                        <input type="email" name="email" class="form-control" value="<%= miPerfil.getEmail() %>">
                    </div>

                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Teléfono</label>
                            <input type="text" name="telefono" class="form-control" value="<%= miPerfil.getTelefono() %>">
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Dirección</label>
                            <input type="text" name="direccion" class="form-control" value="<%= miPerfil.getDireccion() %>">
                        </div>
                    </div>

                    <div class="d-grid gap-2 mt-4">
                        <button type="submit" class="btn btn-success btn-lg">Guardar Cambios 💾</button>
                        <a href="principal.jsp" class="btn btn-outline-secondary">Volver al Menú</a>
                    </div>
                </form>
            </div>
        </div>
    </div>
</body>
</html>