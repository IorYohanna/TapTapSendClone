<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>

<div>
    <h2>Contenu Dynamique Chargé</h2>
    <p>Cette section a été chargée depuis le serveur via HTMX sans recharger la page entière.</p>

    <c:set var="messages" value="${['Message 1', 'Message 2', 'Message 3']}" />
    <ul>
        <c:forEach var="msg" items="${messages}">
            <li><c:out value="${msg}" /></li>
        </c:forEach>
    </ul>
    <p>Date actuelle : <fmt:formatDate value="${now}" pattern="dd/MM/yyyy HH:mm:ss" /></p>

</div>