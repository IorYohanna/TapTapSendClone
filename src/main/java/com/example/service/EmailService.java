package com.example.service;

import jakarta.mail.*;
import jakarta.mail.internet.*;
import java.util.Properties;

public class EmailService {

    private static final String SMTP_HOST = "smtp.gmail.com";
    private static final String SMTP_PORT = "587";
    private static final String EMAIL_FROM = "yorakotosandratana@gmail.com";
    private static final String EMAIL_PASSWORD = "ookkjgclrwpowuzf";

    private Session buildSession() {
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", SMTP_HOST);
        props.put("mail.smtp.port", SMTP_PORT);

        return Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(EMAIL_FROM, EMAIL_PASSWORD);
            }
        });
    }

    public void envoyerNotificationEnvoyeur(String emailDest, String nomEnvoyeur,
                                             int montantDebite, String devise,
                                             String numRecepteur) {
        String sujet = "Confirmation de votre transfert international";
        String corps = String.format(
            "Bonjour %s,\n\n" +
            "Votre transfert a bien été effectué.\n\n" +
            "Détails :\n" +
            "  - Destinataire : %s\n" +
            "  - Montant débité de votre compte : %d %s\n\n" +
            "Merci d'utiliser notre service.\n\n" +
            "Cordialement,\nL'équipe de transfert",
            nomEnvoyeur, numRecepteur, montantDebite, devise
        );
        envoyer(emailDest, sujet, corps);
    }

    public void envoyerNotificationRecepteur(String emailDest, String nomRecepteur,
                                              int montantCredite, String devise,
                                              String numEnvoyeur) {
        String sujet = "Vous avez reçu un transfert international";
        String corps = String.format(
            "Bonjour %s,\n\n" +
            "Vous avez reçu un transfert d'argent.\n\n" +
            "Détails :\n" +
            "  - Expéditeur : %s\n" +
            "  - Montant crédité sur votre compte : %d %s\n\n" +
            "Merci d'utiliser notre service.\n\n" +
            "Cordialement,\nL'équipe de transfert",
            nomRecepteur, numEnvoyeur, montantCredite, devise
        );
        envoyer(emailDest, sujet, corps);
    }

    private void envoyer(String emailDest, String sujet, String corps) {
        try {
            Session session = buildSession();
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(EMAIL_FROM));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(emailDest));
            message.setSubject(sujet);
            message.setText(corps);
            Transport.send(message);
            System.out.println("Mail envoyé à : " + emailDest);
        } catch (MessagingException e) {
            System.err.println("Échec envoi mail à " + emailDest + " : " + e.getMessage());
        }
    }
}