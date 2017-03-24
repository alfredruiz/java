package Clases;

import java.awt.Component;
import java.awt.Graphics;
import java.awt.Insets;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.net.URL;
import javax.imageio.ImageIO;
import javax.swing.border.Border;

/**
 *
 * @author Ana
 */
public class ImagenFondo implements Border {

    //Almacena la imagen en la memoria del sistema
    public BufferedImage imagen;

    public ImagenFondo() {
        try {
            URL imagePath = new URL(getClass().getResource("../Archivos/intro.jpg").toString());
            imagen = ImageIO.read(imagePath);
        } catch (IOException ex) {
            ex.getMessage();
        }
    }

    //Pintamos los bordes
    @Override
    public void paintBorder(Component c, Graphics g, int x, int y, int width, int height) {
        g.drawImage(imagen, (x + (width - imagen.getWidth()) / 2), (y + (height - imagen.getHeight()) / 2), null);
    }

    @Override
    public Insets getBorderInsets(Component c) {
        return new Insets(0, 0, 0, 0); //Centre imagen
    }

    @Override
    public boolean isBorderOpaque() {
        return false;
    }

}
