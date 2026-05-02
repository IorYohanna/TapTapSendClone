package com.example.model;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

public class Envoyer {
    private String idEnv;
    private String numEnvoyeur;
    private String numRecepteur;
    private int montant;
    private LocalDate date;
    private String raison;

    public Envoyer() {
    }

    public Envoyer(String idEnv, String numEnvoyeur, String numRecepteur, int montant, LocalDate date, String raison) {
        this.idEnv = idEnv;
        this.numEnvoyeur = numEnvoyeur;
        this.numRecepteur = numRecepteur;
        this.montant = montant;
        this.date = date;
        this.raison = raison;
    }

    public String getIdEnv() {
        return idEnv;
    }

    public void setIdEnv(String idEnv) {
        this.idEnv = idEnv;
    }

    public String getNumEnvoyeur() {
        return numEnvoyeur;
    }

    public void setNumEnvoyeur(String numEnvoyeur) {
        this.numEnvoyeur = numEnvoyeur;
    }

    public String getNumRecepteur() {
        return numRecepteur;
    }

    public void setNumRecepteur(String numRecepteur) {
        this.numRecepteur = numRecepteur;
    }

    public int getMontant() {
        return montant;
    }

    public void setMontant(int montant) {
        this.montant = montant;
    }

    public LocalDate getDate() {
        return date;
    }

    public void setDate(LocalDate date) {
        this.date = date;
    }

    public String getRaison() {
        return raison;
    }

    public void setRaison(String raison) {
        this.raison = raison;
    }

    public String getFormattedDate() {
        if (this.date == null)
            return "";
        return this.date.format(DateTimeFormatter.ofPattern("dd/MM/yyyy"));
    }

}
