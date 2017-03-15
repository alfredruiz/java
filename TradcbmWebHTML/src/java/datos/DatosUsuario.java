package datos;

import clases.Usuarios;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DatosUsuario {

    private Connection con;
    private ResultSet rs;
    private PreparedStatement pst;
    private Usuarios usu;
    //Conectar a la base de datos
    Conexion conex = new Conexion();


    public Usuarios LogUsuario(String idusuarios, String password) {
        usu = null;
        try {
            String sql = "select * from usuarios where idusuarios= ? and password= ?";
            pst = conex.con.prepareStatement(sql);
            pst.setString(1, idusuarios);
            pst.setString(2, password);
            rs = pst.executeQuery();
            if (rs.next()) {
                usu = new Usuarios(
                        rs.getString("idusuarios"), rs.getString("nombre"),
                        rs.getString("apellidos"), rs.getString("email"),
                        rs.getString("password"), rs.getString("perfil"));
            }
            return usu;
        } catch (SQLException ex) {
            Logger.getLogger(DatosUsuario.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
    }

    public Usuarios getUsuario(String idusuarios) {
        usu = null;
        try {
            String sql = "select * from usuarios where idusuarios= ? ";
            pst = conex.con.prepareStatement(sql);
            pst.setString(1, idusuarios);
            rs = pst.executeQuery();
            if (rs.next()) {
                usu = new Usuarios(
                        rs.getString("idusuarios"), rs.getString("nombre"),
                        rs.getString("apellidos"), rs.getString("email"),
                        rs.getString("password"), rs.getString("perfil"));
            }
            return usu;
        } catch (SQLException ex) {
            Logger.getLogger(DatosUsuario.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
    }

    public ResultSet AllUsuarios() {
        usu = null;
        try {
            String sql = "select * from usuarios";
            pst = conex.con.prepareStatement(sql);
            return pst.executeQuery();
        } catch (SQLException ex) {
            Logger.getLogger(DatosUsuario.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
    }
    
    public void nuevoUsuario(Usuarios usu) {
        try {
            String sql = "Insert into usuarios(idusuarios,nombre,apellidos,email,"
                    + "password,perfil)values(?,?,?,?,?,?)";
            pst = conex.con.prepareStatement(sql);
            pst.setString(1, usu.getIdusuarios());
            pst.setString(2, usu.getNombre());
            pst.setString(3, usu.getApellidos());
            pst.setString(4, usu.getEmail());
            pst.setString(5, usu.getPassword());
            pst.setString(6, usu.getPerfil());
            pst.executeUpdate(); 
            pst.close();
        } catch (SQLException ex) {
            Logger.getLogger(DatosUsuario.class.getName()).log(Level.SEVERE, null, ex);  
        }
    }

    public void modificarUsuario(Usuarios usu) {
        try {
            String sql = "UPDATE usuarios SET nombre = ?, apellidos= ?,email=?, password = ?, perfil= ? WHERE idusuarios = ?";
            pst = conex.con.prepareStatement(sql);
            pst.setString(1, usu.getNombre());
            pst.setString(2, usu.getApellidos());
            pst.setString(3, usu.getEmail());
            pst.setString(4, usu.getPassword());
            pst.setString(5, usu.getPerfil());
            pst.setString(6, usu.getIdusuarios());
            pst.executeUpdate();
            pst.close();
        } catch (SQLException ex) {
            Logger.getLogger(DatosUsuario.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void eliminarUsuario(String idusuarios) {
        try {
            String sql = "delete from usuarios where idusuarios= ? ";
            pst = conex.con.prepareStatement(sql);
            pst.setString(1, idusuarios);
            pst.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(DatosUsuario.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public ArrayList<Usuarios> getAllUsuarios() {

        ArrayList<Usuarios> listausu = new ArrayList<>();
        usu = null;
        try {

            String sql = "select * from usuarios";
            pst = conex.con.prepareStatement(sql);
            rs = pst.executeQuery();
            while (rs.next()) {
                usu = new Usuarios();
                usu.setIdusuarios(rs.getString("idusuarios"));
                usu.setNombre(rs.getString("nombre"));
                usu.setApellidos(rs.getString("apellidos"));
                usu.setEmail(rs.getString("email"));
                usu.setPassword(rs.getString("password"));
                usu.setPerfil(rs.getString("perfil"));
                listausu.add(usu);
            }
        } catch (SQLException ex) {
            Logger.getLogger(DatosUsuario.class.getName()).log(Level.SEVERE, null, ex);
        }
        return listausu;
    }
}
 