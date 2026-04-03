<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>

<!-- Fragment JSP chargé dynamiquement par HTMX -->
<!-- Ce fragment peut contenir du HTML, du JSTL, et être rendu côté serveur -->

<div>
    <h2>Contenu Dynamique Chargé</h2>
    <p>Cette section a été chargée depuis le serveur via HTMX sans recharger la page entière.</p>

    <!-- Exemple d'utilisation de JSTL pour afficher des données dynamiques -->
    <!-- Ici, on simule une liste de messages (à remplacer par des données réelles) -->
    <c:set var="messages" value="${['Message 1', 'Message 2', 'Message 3']}" />
    <ul>
        <c:forEach var="msg" items="${messages}">
            <li><c:out value="${msg}" /></li>
        </c:forEach>
    </ul>

    <!-- Date actuelle formatée avec JSTL -->
    <p>Date actuelle : <fmt:formatDate value="${now}" pattern="dd/MM/yyyy HH:mm:ss" /></p>

    <!-- Commentaires pour le développement futur :
         - Récupérer des données depuis une base de données ou un service
         - Utiliser des conditions JSTL pour afficher du contenu conditionnel
         - Intégrer des formulaires dans ce fragment pour des interactions plus complexes
         - Gérer les erreurs et afficher des messages d'erreur appropriés
         - Optimiser le rendu pour de gros volumes de données
    -->
</div>