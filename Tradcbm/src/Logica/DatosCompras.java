package Logica;

import Clases.Compras;
import Clases.Utilidades;
import Vistas.FormCompras;
import Vistas.FormInicio;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import javax.swing.JOptionPane;
import javax.swing.table.DefaultTableModel;
import javax.swing.DefaultComboBoxModel;

public class DatosCompras {

    FormInicio forini;

    //Conectar a la base de datos
    private final Conexion conex = new Conexion();
    private final Connection con = conex.Conectar();
    private String mysql = "";
    private ResultSet rs;
    private PreparedStatement pst;
    private Compras comp;
    public Integer totalRegistros;

    public boolean nuevaCompra(Compras comp) {
        try {
            String sql = "Insert into clientes`compras`(IDProveedor,NumFactura,"
                    + "Concepto,Fecha,BaseFactura,TipoIVA,Amortizacion)"
                    + "values(?,?,?,?,?,?,?)";
            pst = con.prepareStatement(sql);
            pst.setInt(2, comp.getIDProveedor());
            pst.setString(3, comp.getNumFactura());
            pst.setString(4, comp.getConcepto());
            pst.setString(5, Utilidades.objectToString(comp.getFecha()));
            pst.setDouble(6, comp.getBaseFactura());
            pst.setDouble(7, comp.getTipoIVA());
            pst.setString(8, comp.getAmortización());
            int co = pst.executeUpdate();
            return co != 0;
        } catch (SQLException e) {
            conex.CerrarConexion();
            JOptionPane.showConfirmDialog(null, "La compra ya existe", "Control de Acceso", JOptionPane.ERROR_MESSAGE);
            return false;
        }
    }

    public boolean modificarCompra(Compras comp) {
        try {
            String sql = "UPDATE compras SET IDProveedor = ?, NumFactura = ?,"
                    + "Concepto = ?, Fecha = ?, BaseFactura = ?, TipoIVA = ?,"
                    + "Amortizacion = ? WHERE IDCompras = ?";
            pst = con.prepareStatement(sql);
            pst.setInt(2, comp.getIDProveedor());
            pst.setString(3, comp.getNumFactura());
            pst.setString(4, comp.getConcepto());
            pst.setString(5, Utilidades.objectToString(comp.getFecha()));
            pst.setDouble(6, comp.getBaseFactura());
            pst.setDouble(7, comp.getTipoIVA());
            pst.setString(8, comp.getAmortización());
            int co = pst.executeUpdate();
            return co != 0;
        } catch (SQLException e) {
            conex.CerrarConexion();
            JOptionPane.showConfirmDialog(null, e);
            return false;
        }
    }

    public boolean eliminarCompra(Compras comp) {
        try {
            String sql = "delete from compras where IDCompras= ? ";
            pst = con.prepareStatement(mysql);
            pst.setString(1, Utilidades.objectToString(comp.getFecha()));
            int co = pst.executeUpdate();
            return co != 0;

        } catch (SQLException e) {
            conex.CerrarConexion();
            JOptionPane.showConfirmDialog(null, e);
            return false;
        }
    }

    public void LlenarComboProveedores() {
//        DefaultComboBoxModel modeloCombo = new DefaultComboBoxModel();
        try {
            String sql = "select * from proveedores";
            pst = con.prepareStatement(sql);
            rs = pst.executeQuery();
            FormCompras.cmbproveedor.removeAllItems();;
            while (rs.next()) {
                FormCompras.cmbproveedor.addItem(rs.getString("RazonSocial"));
            }

        } catch (SQLException e) {
            conex.CerrarConexion();
            JOptionPane.showConfirmDialog(null, e);
        }

    }

    public ArrayList<Compras> getAllCompras(String buscar) {

        ArrayList<Compras> listacompra = new ArrayList<>();
        try {
            totalRegistros = 0;
            String sql = "select * from usuarios where idusuarios like '%" + buscar + "%' order by idusuarios";
            pst = con.prepareStatement(sql);
            rs = pst.executeQuery();
            while (rs.next()) {
                comp = new Compras();
                comp.setIDCompras(rs.getInt("IDCompras"));
                comp.setIDProveedor(rs.getInt("IDProveedor"));
                comp.setNumFactura(rs.getString("NumFactura"));
                comp.setConcepto(rs.getString("Concepto"));
                comp.setFecha(rs.getDate("Fecha"));
                comp.setBaseFactura(rs.getDouble("BaseFactura"));
                comp.setTipoIVA(rs.getDouble("TipoIVA"));
                comp.setAmortización(rs.getString("Amortizacion"));
                listacompra.add(comp);
            }
            conex.CerrarConexion();
            return listacompra;
        } catch (SQLException e) {
            JOptionPane.showConfirmDialog(null, e);
            return null;
        }
    }

    public DefaultTableModel CompTable(String buscar) {

        DefaultTableModel modelo;
        String[] titulos = {"Id. Compras", "Proveedor", "Num. Factura", "Concepto", "Fecha", "Base Factura", "Tipo IVA", "Amortiz."};
        String[] registro = new String[8];
        totalRegistros = 0;
        modelo = new DefaultTableModel(null, titulos);

        mysql = "select * from compras where IDCompras like '%" + buscar + "%' order by IDCompras";
        try {
            pst = con.prepareStatement(mysql);
            rs = pst.executeQuery();
            while (rs.next()) {
                registro[0] = rs.getString("IDCompras");
                registro[1] = rs.getString("IDProveedor");
                registro[2] = rs.getString("NumFactura");
                registro[3] = rs.getString("Concepto");
                registro[4] = rs.getString("Fecha");
                registro[5] = rs.getString("BaseFactura");
                registro[6] = rs.getString("TipoIVA");
                registro[7] = rs.getString("Amortizacion");
                totalRegistros = totalRegistros + 1;
                modelo.addRow(registro);
            }
            return modelo;
        } catch (SQLException e) {
            conex.CerrarConexion();
            JOptionPane.showConfirmDialog(null, e);
            return null;
        }
    }

}
