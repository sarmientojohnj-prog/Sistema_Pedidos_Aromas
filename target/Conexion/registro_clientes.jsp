<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Aromas Duo - Registro</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <div class="card shadow">
                    <div class="card-header bg-success text-white text-center">
                        <h3>BIENVENIDO A AROMAS.DUO! </h3>
                        <p class="mb-0">Registro de Nuevo Cliente</p>
                    </div>
                    <div class="card-body p-4">
                        
                        <%-- Mensajes de estado --%>
                        <% String status = request.getParameter("exito");
                           if ("true".equals(status)) { %>
                            <div class="alert alert-success text-center">¡Cliente registrado con éxito!</div>
                        <% } else if ("error".equals(status)) { %>
                            <div class="alert alert-danger text-center">Error al registrar. Intente de nuevo.</div>
                        <% } %>

                        <form action="RegistroServlet" method="post">
                            <div class="mb-3">
                                <label class="form-label font-weight-bold">Nombre</label>
                                <input type="text" name="nombre" class="form-control" placeholder="Ej: Juan" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Apellidos</label>
                                <input type="text" name="apellidos" class="form-control" required>
                            </div>
                            <div class="mb-3 row">
                                <div class="col">
                                    <label class="form-label">Identificación</label>
                                    <input type="text" name="identificacion" class="form-control" required>
                                </div>
                                <div class="col">
                                    <label class="form-label">Teléfono</label>
                                    <input type="text" name="telefono" class="form-control" required>
                                </div>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Dirección</label>
                                <input type="text" name="direccion" class="form-control" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Correo Electrónico</label>
                                <input type="email" name="email" class="form-control" placeholder="nombre@correo.com" required>
                            </div>
                            <div class="mb-3 row">
                                <div class="col">
                                    <label class="form-label font-weight-bold text-primary">Contraseña</label>
                                    <input type="password" name="contrasena" class="form-control" placeholder="Crea tu clave" required>
                                </div>
                                <div class="col">
                                    <label class="form-label font-weight-bold text-primary">Confirmar Clave</label>
                                    <input type="password" name="confirmar_contrasena" class="form-control" placeholder="Repite tu clave" required>
                                </div>
                            </div>
                            <button type="submit" class="btn btn-success w-100 shadow-sm">Guardar Cliente</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <%
    // 1. Detectamos quién está registrando al cliente
    String rolParaVolver = (String) session.getAttribute("rol");
    String destino = "index.jsp"; // Por si acaso algo falla

    if ("Administrativo".equals(rolParaVolver)) {
        destino = "admin_principal.jsp";
    } else if ("Operativo".equals(rolParaVolver)) {
        destino = "operativo_principal.jsp";
    }
%>

<a href="<%= destino %>" style="text-decoration: none; background-color: #64748b; color: white; padding: 10px 20px; border-radius: 8px; font-weight: bold;">
    ⬅ Cancelar y Volver
</a>

    </body>
</html>