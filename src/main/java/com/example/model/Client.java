package com.example.model;

public class Client {
    private String numtel;
    private String nom;
    private String sexe;
    private String pays;
    private int solde;
    private String email;

    public Client () {}

    public Client(String numtel, String nom, String sexe, String pays, int solde, String email) {
        this.numtel = numtel;
        this.nom = nom;
        this.sexe = sexe;
        this.pays = pays;
        this.solde = solde;
        this.email = email;
    }

    public String getNumtel() { return numtel; }
    public void setNumtel(String numtel) { this.numtel = numtel; }

    public String getNom() { return nom; }
    public void setNom(String nom) { this.nom = nom; }

    public String getSexe() { return sexe; }
    public void setSexe(String sexe) { this.sexe = sexe; }

    public String getPays() { return pays; }
    public void setPays(String pays) { this.pays = pays; }

    public int getSolde() { return solde; }
    public void setSolde(int solde) { this.solde = solde; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

}
