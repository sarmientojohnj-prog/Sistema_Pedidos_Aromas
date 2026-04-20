package servicio;
import java.sql.*;
import java.util.ArrayList;
import conexion.ConexionDB;
import modelo.Cliente;

public class ClienteService {

    public int agregarCliente(String nombre, String apellidos, String identificacion,
                         String direccion, String telefono, String email, String contrasena) {

    System.out.println(">>> PRUEBA 26-03-26 <<<");
    Connection con = null;

    try {
        con = ConexionDB.getConnection();
        con.setAutoCommit(false); // 🔥 IMPORTANTE

        // 1. PERSONA
        String sqlPersona = "INSERT INTO persona (Nombre, Apellidos, Identificacion, Direccion, Telefono, Correo_Electronico) VALUES (?, ?, ?, ?, ?, ?)";
        PreparedStatement psPersona = con.prepareStatement(sqlPersona, Statement.RETURN_GENERATED_KEYS);
        psPersona.setString(1, nombre);
        psPersona.setString(2, apellidos);
        psPersona.setString(3, identificacion);
        psPersona.setString(4, direccion);
        psPersona.setString(5, telefono);
        psPersona.setString(6, email);
        psPersona.executeUpdate();

        ResultSet rsPersona = psPersona.getGeneratedKeys();
        if (!rsPersona.next()) {
            throw new SQLException("No se generó ID de persona");
        }

        int idPersonaGenerado = rsPersona.getInt(1);

        // 2. CLIENTE
        String sqlCliente = "INSERT INTO cliente (Id_Persona) VALUES (?)";
        PreparedStatement psCliente = con.prepareStatement(sqlCliente, Statement.RETURN_GENERATED_KEYS);
        psCliente.setInt(1, idPersonaGenerado);
        psCliente.executeUpdate();

        ResultSet rsCliente = psCliente.getGeneratedKeys();
        if (!rsCliente.next()) {
            throw new SQLException("No se generó ID de cliente");
        }

        int idClienteGenerado = rsCliente.getInt(1);

        // 3. USUARIO  🔥 AQUÍ ESTÁ TU PROBLEMA
        String sqlUsuario = "INSERT INTO usuario (Id_Persona_FK, Nombre_Usuario, Estado, Rol, Area_acceso, Contrasena) VALUES (?, ?, ?, ?, ?, ?)";

        PreparedStatement psUsuario = con.prepareStatement(sqlUsuario);
        psUsuario.setInt(1, idPersonaGenerado);
        psUsuario.setString(2, email);
        psUsuario.setInt(3, 1); // Asegúrate que sea compatible
        psUsuario.setString(4, "Cliente");
        psUsuario.setString(5, "General");
        psUsuario.setString(6, contrasena);

        int filas = psUsuario.executeUpdate();

        if (filas == 0) {
            throw new SQLException("No se insertó el usuario");
        }

        //  confirma  
        con.commit();
            System.out.println("✅ ¡ALELUYA! TODO SE GUARDÓ EN LAS 3 TABLAS");
        return idClienteGenerado; 

    } catch (SQLException e) {
        try {
            if (con != null) con.rollback(); // 🔥 REVERSIÓN
        } catch (SQLException ex) {
            ex.printStackTrace();
        }

        System.err.println("❌ ERROR REAL:");
        e.printStackTrace(); // 🔥 AQUÍ VERÁS EL PROBLEMA REAL

        return -1;

    } finally {
        try {
            if (con != null) con.setAutoCommit(true);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}

    public ArrayList<Cliente> listarClientes() {
        ArrayList<Cliente> lista = new ArrayList<>();
        String sql = "SELECT * FROM persona"; 
        try (Connection con = ConexionDB.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while(rs.next()) {
                Cliente c = new Cliente();
                c.setId(rs.getInt("IdPersona"));
                c.setNombre(rs.getString("Nombre"));
                c.setApellidos(rs.getString("Apellidos")); 
                c.setIdentificacion(rs.getString("Identificacion")); 
                c.setDireccion(rs.getString("Direccion")); 
                c.setTelefono(rs.getString("Telefono"));
                c.setEmail(rs.getString("Correo_Electronico"));
                lista.add(c);
            }
        } catch(SQLException e) { e.printStackTrace(); }
        return lista;
    }

    public boolean actualizarCliente(int id, String nombre, String email, String telefono) {
        try (Connection con = ConexionDB.getConnection()) {
            String sql = "UPDATE persona SET Nombre=?, Correo_Electronico=?, Telefono=? WHERE IdPersona=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, nombre);
            ps.setString(2, email);
            ps.setString(3, telefono);
            ps.setInt(4, id);
            return ps.executeUpdate() > 0;
        } catch(SQLException e) { e.printStackTrace(); }
        return false;
    }

    public boolean eliminarCliente(int id) {
        try (Connection con = ConexionDB.getConnection()) {
            String sql = "DELETE FROM persona WHERE IdPersona=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch(SQLException e) { e.printStackTrace(); }
        return false;
    }

    public boolean validarUsuario(String email, String password) {
        String sql = "SELECT * FROM usuario WHERE Nombre_Usuario = ? AND Contrasena= ?";
        try (Connection con = ConexionDB.getConnection();
             PreparedStatement ps= con.prepareStatement(sql)) {
            ps.setString(1, email);
            ps.setString(2, password);
            try(ResultSet rs= ps.executeQuery()) {
                return rs.next();
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return false;
    }

    public String obtenerNombrePorEmail(String email) {
    String nombre = "Usuario"; 
    // Esta consulta une la tabla persona con usuario para traer el nombre real
    String sql = "SELECT p.Nombre FROM persona p " +
                 "JOIN usuario u ON p.IdPersona = u.Id_Persona_FK " +
                 "WHERE u.Nombre_Usuario = ?";
                 
    try (Connection con = ConexionDB.getConnection();
         PreparedStatement ps = con.prepareStatement(sql)) {
        
        ps.setString(1, email);
        ResultSet rs = ps.executeQuery();
        
        if (rs.next()) {
            nombre = rs.getString("Nombre"); // Aquí saca el nombre 'jas' o 'John'
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return nombre; // Devuelve el nombre al Servlet
}


    public Cliente obtenerDatosCompletosPorEmail(String email) {
        Cliente c = null;
        String sql = "SELECT p.* FROM persona p " +
                     "JOIN usuario u ON p.IdPersona = u.Id_Persona_FK " +
                     "WHERE u.Nombre_Usuario = ?";
                     
        try (Connection con = ConexionDB.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                c = new Cliente();
                c.setId(rs.getInt("IdPersona"));
                c.setNombre(rs.getString("Nombre"));
                c.setApellidos(rs.getString("Apellidos"));
                c.setIdentificacion(rs.getString("Identificacion"));
                c.setDireccion(rs.getString("Direccion"));
                c.setTelefono(rs.getString("Telefono"));
                c.setEmail(rs.getString("Correo_Electronico"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return c;
    }

    public boolean actualizarPerfilCompleto(int id, String nombre, String apellidos, String direccion, String telefono, String email) {
    String sql = "UPDATE persona SET Nombre=?, Apellidos=?, Direccion=?, Telefono=?, Correo_Electronico=? WHERE IdPersona=?";
    try (Connection con = ConexionDB.getConnection();
         PreparedStatement ps = con.prepareStatement(sql)) {
        ps.setString(1, nombre);
        ps.setString(2, apellidos);
        ps.setString(3, direccion);
        ps.setString(4, telefono);
        ps.setString(5, email);
        ps.setInt(6, id);
        return ps.executeUpdate() > 0;
    } catch (SQLException e) {
        e.printStackTrace();
        return false;
    }
}

public String obtenerRolPorEmail(String email) {
    String rol = "Cliente"; // Por defecto, si algo falla, lo tratamos como cliente
    String sql = "SELECT Rol FROM usuario WHERE Nombre_Usuario = ?"; 
    
    // Usamos Nombre_Usuario porque en tu imagen veo que es la llave para el login
    try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/aromas_duo", "root", "");
         PreparedStatement ps = conn.prepareStatement(sql)) {
        
        ps.setString(1, email);
        ResultSet rs = ps.executeQuery();
        
        if (rs.next()) {
            rol = rs.getString("Rol");
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return rol;
}

public int obtenerIdPorEmail(String email) {
    int id = 0;
    // Buscamos directamente en la tabla usuario
    String sql = "SELECT Id_Usuario FROM usuario WHERE Nombre_Usuario = ?"; 
    
    try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/aromas_duo", "root", "");
         PreparedStatement ps = con.prepareStatement(sql)) {
        
        ps.setString(1, email);
        ResultSet rs = ps.executeQuery();
        
        if (rs.next()) {
            // Sacamos el ID de la columna real de la tabla usuario
            id = rs.getInt("Id_Usuario"); 
        }
        // No hace falta cerrar con.close() porque el try() lo hace solo
    } catch (Exception e) {
        System.out.println("Error al obtener Id_Usuario: " + e.getMessage());
    }
    return id; 
}


}