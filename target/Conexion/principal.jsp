<%@ page import="java.sql.*" %>
<%
    // 1. SEGURIDAD: Verificamos sesión
    if (session.getAttribute("nombre") == null) {
        response.sendRedirect("login.jsp");
    }
    String nombreUsuario = (String) session.getAttribute("nombre");
%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Panel Principal - Aromas a Dúo</title>
    <style>
        body { font-family: 'Segoe UI', sans-serif; background-color: #fef3c7; margin: 0; padding: 0; }
        
        /* BARRA SUPERIOR */
        header { 
            background-color: #d97706; color: white; padding: 15px 50px; 
            display: flex; justify-content: space-between; align-items: center; 
            position: sticky; top: 0; z-index: 1000; box-shadow: 0 2px 10px rgba(0,0,0,0.1); 
        }

        .container { max-width: 1200px; margin: 20px auto; padding: 20px; }
        
        /* BLOQUE DE BIENVENIDA Y PERFIL */
        .panel-usuario { 
            background: white; padding: 30px; border-radius: 15px; 
            text-align: center; margin-bottom: 30px; border-bottom: 5px solid #ea580c; 
            box-shadow: 0 4px 6px rgba(0,0,0,0.05);
        }

        .botones-accion { margin-top: 20px; display: flex; justify-content: center; gap: 15px; }
        
        .btn-perfil { 
            background-color: #f59e0b; color: white; text-decoration: none; 
            padding: 10px 20px; border-radius: 8px; font-weight: bold; 
        }

        /* MENÚ DE PRODUCTOS */
        .menu-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(260px, 1fr)); gap: 25px; margin-top: 20px; }
        .producto-card { background: white; border-radius: 15px; padding: 20px; text-align: center; box-shadow: 0 5px 15px rgba(0,0,0,0.05); }
        .precio { color: #d97706; font-weight: bold; font-size: 1.2em; display: block; margin: 10px 0; }
        .selector { background: #fff7ed; padding: 10px; border-radius: 10px; border: 1px solid #fed7aa; }
        
        .btn-finalizar { 
            position: fixed; bottom: 20px; right: 20px; background: #ea580c; color: white; 
            padding: 15px 30px; border-radius: 50px; font-size: 1.2em; font-weight: bold; 
            text-decoration: none; box-shadow: 0 5px 20px rgba(0,0,0,0.3); border: none; cursor: pointer;
        }
    </style>
</head>
<body>

<header>
    <span style="font-size: 1.4em; font-weight: bold;">Aromas a Dúo</span>
    <a href="index.jsp" style="color: white; text-decoration: none; font-weight: bold;">Cerrar Sesión</a>
</header>

<div class="container">
    <div class="panel-usuario">
    <h1>¡Hola de nuevo, <%= nombreUsuario %>! ☕</h1>
    <p>Desde aquí puedes gestionar tus pedidos y tu información personal.</p>
    
    <div class="botones-accion">
        <a href="perfil.jsp" class="btn-perfil">👤 Ver/Editar Mi Perfil</a>
        
        <a href="mis_pedidos.jsp" class="btn-perfil" style="background-color: #ea580c;">
            📦 Como van mis Pedidos?
        </a>

        <a href="#menu-seccion" class="btn-perfil" style="background-color: #d97706;">🍕 Ir al Menú</a>
    </div>
</div>

    <h2 id="menu-seccion" style="color: #ea580c; border-bottom: 3px solid #ea580c; padding-bottom: 10px;">
        Nuestro Menú del Día 🤤
    </h2>

    <form action="nuevo_pedido.jsp" method="POST">
        <div class="menu-grid">
            <%
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/aromas_duo", "root", "");
                Statement st = con.createStatement();
                ResultSet rs = st.executeQuery("SELECT id_producto, nombre, precio, descripcion FROM productos");
                
                while(rs.next()) {
                    int id = rs.getInt("id_producto");
                    String n = rs.getString("nombre");
                    double p = rs.getDouble("precio");
                    String d = rs.getString("descripcion");
            %>
                    <div class="producto-card">
                        <h3><%= n %></h3>
                        <p style="font-size: 0.9em; color: #666;"><%= d %></p>
                        <span class="precio">$<%= p %></span>
                        
                        <div class="selector">
                            Cant: 
                            <input type="number" name="cant_<%= id %>" value="0" min="0" style="width: 50px; text-align: center;">
                            <input type="hidden" name="nombre_<%= id %>" value="<%= n %>">
                            <input type="hidden" name="precio_<%= id %>" value="<%= p %>">
                        </div>
                    </div>
            <%
                }
                con.close();
            } catch (Exception e) {
                out.println("<p>Error al cargar productos: " + e.getMessage() + "</p>");
            }
            %>
        </div>

        <button type="submit" class="btn-finalizar">🛒 Ver mi pedido</button>
    </form>
</div>

</body>
</html>