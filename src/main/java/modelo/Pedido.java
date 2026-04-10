package modelo;
public class Pedido {
    private int Id_Pedido;
    private int Id_Cliente_FK;
    private String Fecha_Hora_Pedido; 
    private String Tipo_Entrega;
    private String Notas_Cliente;
    private int Total; 

    // GETTERS Y SETTERS
    
    public int getId_Pedido() {
        return Id_Pedido;
    }
    public void setId_Pedido(int id_Pedido) {
        Id_Pedido = id_Pedido;
    }
    public int getId_Cliente_FK() {
        return Id_Cliente_FK;
    }
    public void setId_Cliente_FK(int id_Cliente_FK) {
        Id_Cliente_FK = id_Cliente_FK;
    }
    public String getFecha_Hora_Pedido() {
        return Fecha_Hora_Pedido;
    }
    public void setFecha_Hora_Pedido(String fecha_Hora_Pedido) {
        Fecha_Hora_Pedido = fecha_Hora_Pedido;
    }
    public String getTipo_Entrega() {
        return Tipo_Entrega;
    }
    public void setTipo_Entrega(String tipo_Entrega) {
        Tipo_Entrega = tipo_Entrega;
    }
    public String getNotas_Cliente() {
        return Notas_Cliente;
    }
    public void setNotas_Cliente(String notas_Cliente) {
        Notas_Cliente = notas_Cliente;
    }
    public int getTotal() {
        return Total;
    }
    public void setTotal(int total) {
        Total = total;
    }
    public String getEstado_Pedido() {
        return Estado_Pedido;
    }
    public void setEstado_Pedido(String estado_Pedido) {
        Estado_Pedido = estado_Pedido;
    }
    private String Estado_Pedido;

    public Pedido(int id_Pedido, int id_Cliente_FK, String fecha_Hora_Pedido, String tipo_Entrega, String notas_Cliente,
            int total, String estado_Pedido) {
        Id_Pedido = id_Pedido;
        Id_Cliente_FK = id_Cliente_FK;
        Fecha_Hora_Pedido = fecha_Hora_Pedido;
        Tipo_Entrega = tipo_Entrega;
        Notas_Cliente = notas_Cliente;
        Total = total;
        Estado_Pedido = estado_Pedido;
    }
    public Pedido() {
    }
 
   
}
