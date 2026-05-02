package com.example.model;

public class Taux {
    private String idtaux;
    private int montant1;
    private int montant2;
    private String pays1;
    private String pays2;

    public Taux (){}

    public Taux (String idtaux, int montant1, int montant2, String pays1, String pays2) {
        this.idtaux = idtaux;
        this.montant1 = montant1;
        this.montant2 = montant2;
        this.pays1 = pays1 ;
        this.pays2 = pays2 ;
    }

    public String getIdtaux() { return idtaux; }
    public void setIdtaux(String idtaux) { this.idtaux = idtaux; }

    public int getMontant1() { return montant1; }
    public void setMontant1(int montant1) { this.montant1 = montant1; }

    public int getMontant2() { return montant2; }
    public void setMontant2(int montant2) { this.montant2 = montant2; }

    public String getPays1 () { return pays1;}
    public void setPays1 (String pays1) {this.pays1 = pays1;}

    public String getPays2 () { return pays2;}
    public void setPays2 (String pays2) {this.pays2 = pays2;}

}
