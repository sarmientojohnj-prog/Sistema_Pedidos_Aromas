
    <%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html>
    <head>
        <title>Ingresa a Aromas a Duo</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>

    <body class="bg-light">
        <div class="container mt-5">
            <div class="card mx-auto" style="max-width: 400px;">
                <div class="card-header bg-success text-white">
                    <h4 class="text-center">Iniciar Sesión</h4>
                </div>
                <div class="card-body">
                    <%-- si el servlet devuelve error con ?error=true, se muestra esto--%>
                    <% if (request.getParameter("error")!=null){%>
                        <div class="alert alert-danger">Datos incorrectos</div>
                    <%}%>
                <form action="LoginServlet" method="POST">
                    <div class="mb-3">
                        <label>Correo Electrónico</label>
                        <input type="email" name="email" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label>Contraseña</label>
                        <input type="password" name="password" class="form-control" required>
                    </div>
                    <button type="submit" class="btn btn-success w-100">Entrar</button>
                </form>
               </div>
            </div>
        </div>
    </body>
    </html>
