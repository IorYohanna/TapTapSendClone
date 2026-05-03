<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
    <c:set var="ctx" value="${pageContext.request.contextPath}" />
        <div id="toast-container" class="fixed top-8 right-8 z-[100] flex flex-col gap-3">

            <c:if test="${not empty param.success}">
                <c:set var="msg" value="Opération réussie !" />
                <c:choose>
                    <c:when test="${param.success == 'ajouter'}">
                        <c:set var="msg" value="Enregistré avec succès." />
                    </c:when>
                    <c:when test="${param.success == 'modifier'}">
                        <c:set var="msg" value="Mise a jour reussi." />
                    </c:when>
                    <c:when test="${param.success == 'supprime'}">
                        <c:set var="msg" value="Suppression reussi." />
                    </c:when>
                </c:choose>

                <div class="toast success flex items-center gap-3 shadow-2xl">
                    <span class="text-xl">✅</span>
                    <span class="font-medium">${msg}</span>
                    <button onclick="this.parentElement.remove()"
                        class="ml-4 opacity-30 hover:opacity-100">&times;</button>
                </div>
            </c:if>

            <c:if test="${not empty param.error or not empty error}">
                <div class="toast error flex items-center gap-3 shadow-2xl">
                    <span class="text-xl">❌</span>
                    <span class="font-medium">${not empty error ? error : param.error}</span>
                    <button onclick="this.parentElement.remove()"
                        class="ml-4 opacity-30 hover:opacity-100">&times;</button>
                </div>
            </c:if>
        </div>
        <script src="${ctx}/js/toast/toast.js"></script>