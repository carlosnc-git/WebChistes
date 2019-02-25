/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import entities.Chiste;
import java.math.BigDecimal;
import javax.persistence.*;

/**
 *
 * @author Diurno
 */

public class ChistePuntuado {
    
    private Chiste chiste;
    private BigDecimal puntuacion;

    public ChistePuntuado(Chiste chiste, BigDecimal puntuacion) {
        this.chiste = chiste;
        this.puntuacion = puntuacion;
    }

    public ChistePuntuado() {
    }

    public Chiste getChiste() {
        return chiste;
    }

    public BigDecimal getPuntuacion() {
        return puntuacion;
    }

    public void setChiste(Chiste chiste) {
        this.chiste = chiste;
    }

    public void setPuntuacion(BigDecimal puntuacion) {
        this.puntuacion = puntuacion;
    }

    @Override
    public String toString() {
        return "ChistePuntuado{" + "chiste=" + chiste + ", puntuacion=" + puntuacion + '}';
    }
    
    
}
