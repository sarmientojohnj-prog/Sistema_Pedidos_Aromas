<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Registro de Empleados - Aromas a Dúo</title>
    <style>
        body { font-family: 'Segoe UI', sans-serif; background-color: #f1f5f9; padding: 40px; }
        .form-container { max-width: 600px; margin: auto; background: white; padding: 30px; border-radius: 15px; box-shadow: 0 4px 15px rgba(0,0,0,0.1); border-top: 6px solid #d97706; }
        h2 { color: #1e293b; text-align: center; }
        .seccion-titulo { color: #d97706; font-size: 0.9em; text-transform: uppercase; margin-top: 20px; border-bottom: 1px solid #e2e8f0; padding-bottom: 5px; font-weight: bold; }
        .grid-campos { display: grid; grid-template-columns: 1fr 1fr; gap: 15px; margin-top: 15px; }
        .campo { margin-bottom: 15px; }
        .campo.full { grid-column: span 2; }
        label { display: block; margin-bottom: 5px; font-weight: bold; color: #475569; }
        input, select { width: 100%; padding: 10px; border: 1px solid #cbd5e1; border-radius: 8px; box-sizing: border-box; }
        .btn-guardar { background: #d97706; color: white; border: none; padding: 15px; width: 100%; border-radius: 8px; cursor: pointer; font-weight: bold; font-size: 1.1em; margin-top: 20px; }
        .btn-volver { display: block; text-align: center; margin-top: 15px; color: #64748b; text-decoration: none; }
    </style>
</head>
<body>

<div class="form-container">
    <h2>👤 Registro de Nuevo Empleado</h2>
    
    <form action="RegistroEmpleadoServlet" method="POST">
        
        <div class="seccion-titulo">Datos del Empleado</div>
        <div class="grid-campos">
            <div class="campo">
                <label>Nombre:</label>
                <input type="text" name="nombre" required>
            </div>
            <div class="campo">
                <label>Apellidos:</label>
                <input type="text" name="apellidos" required>
            </div>
            <div class="campo">
                <label>Identificación:</label>
                <input type="number" name="cedula" required>
            </div>
            <div class="campo">
                <label>Teléfono:</label>
                <input type="tel" name="telefono" required>
            </div>
            <div class="campo full">
                <label>Dirección:</label>
                <input type="text" name="direccion" required>
            </div>
            <div class="campo full">
                <label>Correo Electrónico:</label>
                <input type="email" name="email" required>
            </div>
            <div class="campo">
                <label>Contraseña:</label>
                <input type="password" name="password" required>
            </div>
            <div class="campo">
                <label>Rol del Empleado:</label>
                <select name="rol" required>
                    <option value="Operativo">Operativo</option>
                    <option value="Repartidor">Repartidor</option>
                    <option value="Administrativo">Administrativo</option>
                </select>
            </div>
        </div>

        <button type="submit" class="btn-guardar">Registrar Empleado</button>
        <a href="admin_principal.jsp" class="btn-volver">⬅ Volver al Panel</a>
    </form>
</div>

</body>
</html>