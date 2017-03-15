package Logica;
 
import Clases.Usuarios;
import Vistas.FormInicio;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;  
import java.util.ArrayList;
import javax.swing.JOptionPane;
import javax.swing.table.DefaultTableModel;

public class DatosUsuario {
    
    FormInicio forini;
    
    //Conectar a la base de datos
    private final Conexion conex = new Conexion();
    private final Connection con = conex.Conectar();
    private String mysql="";
    private ResultSet rs;
    private PreparedStatement pst;
    private Usuarios usu;
    public  Integer totalRegistros;
   

  
    //Validamos usuario
    public Usuarios ValidaUsuario(String idusuarios, String password) {
        try {
            mysql = "select * from usuarios where idusuarios= ? and password= ?";
            pst = con.prepareStatement(mysql);
            pst.setString(1, idusuarios);
            pst.setString(2, password);
            rs = pst.executeQuery();
            if (!rs.next()) {
                return null;
            }
            usu = new Usuarios(
                    rs.getString("idusuarios"),
                    rs.getString("nombre"),
                    rs.getString("apellidos"),
                    rs.getString("email"),
                    rs.getString("password"),
                    rs.getString("perfil"));
            return usu;
        } catch (SQLException e) {
            JOptionPane.showConfirmDialog(null, e);
            return null;
        }
    }
  
    public boolean nuevoUsuario(Usuarios usu) {
        try {
            mysql = "Insert into usuarios(idusuarios,nombre,apellidos,email,"
                    + "password,perfil)values(?,?,?,?,?,?)";
            pst = con.prepareStatement(mysql);
            pst.setString(1, usu.getIdusuarios());
            pst.setString(2, usu.getNombre());
            pst.setString(3, usu.getApellidos());
            pst.setString(4, usu.getEmail());
            pst.setString(5, usu.getPassword());
            pst.setString(6, usu.getPerfil());
            int us = pst.executeUpdate();
            return us!=0;           
        }  catch (SQLException e) {
            conex.CerrarConexion();
            JOptionPane.showConfirmDialog(null,"Usuario ya existe","Control de Acceso",JOptionPane.ERROR_MESSAGE);
            return false;
            }
    }

    public boolean modificarUsuario(Usuarios usu) {
        try {
            mysql = "UPDATE usuarios SET nombre = ?, apellidos= ?,email=?, password = ?, perfil= ? WHERE idusuarios = ?";
            pst = con.prepareStatement(mysql);
            pst.setString(1, usu.getNombre());
            pst.setString(2, usu.getApellidos());
            pst.setString(3, usu.getEmail());
            pst.setString(4, usu.getPassword());
            pst.setString(5, usu.getPerfil());
            pst.setString(6, usu.getIdusuarios());
            int us= pst.executeUpdate();
            return us!=0;     
        }  catch (SQLException e) {
            conex.CerrarConexion();
            JOptionPane.showConfirmDialog(null,e);
            return false;
        }
    }

    public boolean eliminarUsuario(Usuarios usu) {
        try {
            mysql = "delete from usuarios where idusuarios= ? ";
            pst = con.prepareStatement(mysql);   
            pst.setString(1, usu.getIdusuarios());
            int us= pst.executeUpdate();
            return us!=0;  
          
        } catch (SQLException e) {
            conex.CerrarConexion();
            JOptionPane.showConfirmDialog(null,e);
            return false;
        }
    }  

      public ArrayList<Usuarios> getAllUsuarios(String buscar) {

        ArrayList<Usuarios> listausu = new ArrayList<>();        
        try {
            totalRegistros= 0;
            String sql = "select * from usuarios where idusuarios like '%" + buscar + "%' order by idusuarios";
            pst = con.prepareStatement(sql);
            rs = pst.executeQuery();
            while (rs.next()) {
                usu = new Usuarios();
                usu.setIdusuarios(rs.getString("idusuarios"));
                usu.setNombre(rs.getString("nombre"));
                usu.setApellidos(rs.getString("apellidos"));
                usu.setEmail(rs.getString("email"));
                usu.setPassword(rs.getString("password"));
                usu.setPerfil(rs.getString("perfil"));
                totalRegistros= totalRegistros+1;
                listausu.add(usu);
            }
          conex.CerrarConexion();
          return listausu;
        } catch (SQLException e) {
            JOptionPane.showConfirmDialog(null,e); 
            return null;
        } 
    }
    
    public DefaultTableModel UsuTable(String buscar){
        
        DefaultTableModel modelo;
        String []titulos ={"Usuarios", "Nombre", "Apellidos","Email", "Password","Password2","Perfil"};
        String []registro = new String[7];
        totalRegistros= 0;
        modelo = new DefaultTableModel(null,titulos);
        
        mysql= "select * from usuarios where idusuarios like '%" + buscar + "%' order by idusuarios";
        try {
            pst = con.prepareStatement(mysql);
            rs =pst.executeQuery();
            while(rs.next()){
                registro[0] = rs.getString("idusuarios");
                registro[1] = rs.getString("nombre");
                registro[2] = rs.getString("apellidos");
                registro[3] = rs.getString("email");
                registro[4] = rs.getString("password");
                registro[5] = rs.getString("password");
                registro[6] = rs.getString("perfil");
                totalRegistros= totalRegistros+1;
                modelo.addRow(registro);
            }
            return modelo;
        } catch (SQLException e) {
            conex.CerrarConexion();
            JOptionPane.showConfirmDialog(null,e); 
            return null;
        }
    }  
     
}
