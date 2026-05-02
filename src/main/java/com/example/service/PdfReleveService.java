package com.example.service;

import com.example.model.Envoyer;
import com.itextpdf.kernel.colors.ColorConstants;
import com.itextpdf.kernel.colors.DeviceRgb;
import com.itextpdf.kernel.pdf.PdfDocument;
import com.itextpdf.kernel.pdf.PdfWriter;
import com.itextpdf.layout.Document;
import com.itextpdf.layout.borders.Border;
import com.itextpdf.layout.borders.SolidBorder;
import com.itextpdf.layout.element.*;
import com.itextpdf.layout.properties.TextAlignment;
import com.itextpdf.layout.properties.UnitValue;

import java.io.OutputStream;
import java.time.Month;
import java.time.format.TextStyle;
import java.util.List;
import java.util.Locale;
import java.util.Map;

public class PdfReleveService {

        private static final DeviceRgb COULEUR_PRINCIPALE = new DeviceRgb(11, 11, 11);
        private static final DeviceRgb COULEUR_ACCENT = new DeviceRgb(80, 120, 255);
        private static final DeviceRgb COULEUR_GRIS = new DeviceRgb(230, 230, 230);

        public void genererReleve(OutputStream out, String numtel, Map<String, String> infosClient,
                        int mois, int annee, List<Envoyer> envois) throws Exception {

                PdfWriter writer = new PdfWriter(out);
                PdfDocument pdf = new PdfDocument(writer);
                Document document = new Document(pdf);
                document.setMargins(40, 50, 40, 50);

                String nomMois = Month.of(mois).getDisplayName(TextStyle.FULL, Locale.FRENCH);

                document.add(new Paragraph("MoneyFlow")
                                .setFontSize(26).setBold()
                                .setFontColor(COULEUR_ACCENT)
                                .setMarginBottom(2));

                document.add(new Paragraph("Relevé d'opérations — Envoyeur")
                                .setFontSize(11)
                                .setFontColor(ColorConstants.GRAY)
                                .setMarginBottom(20));

                document.add(new Paragraph("Informations du client")
                                .setBold().setFontSize(11).setMarginBottom(8));

                Table infoTable = new Table(UnitValue.createPercentArray(new float[] { 1, 1 }))
                                .useAllAvailableWidth()
                                .setMarginBottom(8);

                String[][] lignesClient = {
                                { "Numéro", numtel },
                                { "Nom", infosClient.getOrDefault("nom", "-") },
                                { "Sexe", infosClient.getOrDefault("sexe", "-") },
                                { "Pays", infosClient.getOrDefault("pays", "-") },
                                { "Email", infosClient.getOrDefault("email", "-") },
                                { "Solde actuel", infosClient.getOrDefault("solde", "-") },
                };

                boolean pair = false;
                for (String[] ligne : lignesClient) {
                        DeviceRgb bg = pair ? new DeviceRgb(248, 248, 248) : (DeviceRgb) ColorConstants.WHITE;
                        infoTable.addCell(new Cell()
                                        .add(new Paragraph(ligne[0]).setBold().setFontSize(9))
                                        .setBackgroundColor(bg).setBorder(Border.NO_BORDER).setPadding(5));
                        infoTable.addCell(new Cell()
                                        .add(new Paragraph(ligne[1]).setFontSize(9))
                                        .setBackgroundColor(bg).setBorder(Border.NO_BORDER).setPadding(5));
                        pair = !pair;
                }
                document.add(infoTable);


                Table periodeTable = new Table(UnitValue.createPercentArray(new float[] { 1, 1 }))
                                .useAllAvailableWidth()
                                .setMarginBottom(20);
                periodeTable.addCell(cellInfo("Période", nomMois + " " + annee));
                periodeTable.addCell(cellInfo("Nb opérations", String.valueOf(envois.size())));
                document.add(periodeTable);

                document.add(new LineSeparator(new com.itextpdf.kernel.pdf.canvas.draw.SolidLine())
                                .setMarginBottom(20));

                if (envois.isEmpty()) {
                        document.add(new Paragraph("Aucune opération pour cette période.")
                                        .setFontColor(ColorConstants.GRAY)
                                        .setTextAlignment(TextAlignment.CENTER)
                                        .setMarginTop(30));
                } else {
                        float[] colonnes = { 1.5f, 2f, 2f, 1.5f, 2f, 2.5f };
                        Table table = new Table(UnitValue.createPercentArray(colonnes))
                                        .useAllAvailableWidth().setMarginBottom(20);

                        for (String h : new String[] { "ID", "Envoyeur", "Récepteur", "Montant", "Date", "Raison" }) {
                                table.addHeaderCell(
                                                new Cell().add(new Paragraph(h).setBold().setFontSize(9))
                                                                .setBackgroundColor(COULEUR_PRINCIPALE)
                                                                .setFontColor(ColorConstants.WHITE)
                                                                .setPadding(6).setBorder(Border.NO_BORDER));
                        }

                        boolean pairLigne = false;
                        int totalMontant = 0;
                        for (Envoyer e : envois) {
                                DeviceRgb bg = pairLigne ? new DeviceRgb(248, 248, 248) : (DeviceRgb) ColorConstants.WHITE;
                                String[] vals = {
                                                e.getIdEnv(), e.getNumEnvoyeur(), e.getNumRecepteur(),
                                                e.getMontant() + " €", e.getFormattedDate(),
                                                e.getRaison() != null ? e.getRaison() : "-"
                                };
                                for (String v : vals) {
                                        table.addCell(new Cell().add(new Paragraph(v).setFontSize(8))
                                                        .setBackgroundColor(bg).setPadding(5)
                                                        .setBorder(Border.NO_BORDER)
                                                        .setBorderBottom(new SolidBorder(COULEUR_GRIS, 0.5f)));
                                }
                                totalMontant += e.getMontant();
                                pairLigne = !pairLigne;
                        }

                        table.addCell(new Cell(1, 5)
                                        .add(new Paragraph("TOTAL ENVOYÉ").setBold().setFontSize(9)
                                                        .setTextAlignment(TextAlignment.RIGHT))
                                        .setBorder(Border.NO_BORDER).setBackgroundColor(COULEUR_GRIS).setPadding(6));
                        table.addCell(new Cell()
                                        .add(new Paragraph(totalMontant + " €").setBold().setFontSize(9))
                                        .setBackgroundColor(COULEUR_GRIS).setBorder(Border.NO_BORDER).setPadding(6));

                        document.add(table);
                }

                document.add(new Paragraph("Document généré automatiquement par MoneyFlow.")
                                .setFontSize(8).setFontColor(ColorConstants.GRAY)
                                .setTextAlignment(TextAlignment.CENTER).setMarginTop(30));

                document.close();
        }

        private Cell cellInfo(String label, String valeur) {
                return new Cell()
                                .add(new Paragraph()
                                                .add(new Text(label + " : ").setBold().setFontSize(9))
                                                .add(new Text(valeur).setFontSize(9)))
                                .setBorder(Border.NO_BORDER)
                                .setPaddingBottom(4);
        }
}