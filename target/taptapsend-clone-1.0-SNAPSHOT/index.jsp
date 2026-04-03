<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
            <!DOCTYPE html>
            <html lang="fr">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>TapTapSend Clone - Accueil</title>
                <script src="https://unpkg.com/htmx.org@1.9.10"></script>
                <script src="https://cdn.tailwindcss.com"></script>
                <style>
                    body {
                        font-family: Arial, sans-serif;
                        margin: 20px;
                    }

                    .welcome {
                        text-align: center;
                        margin-bottom: 20px;
                    }

                    .dynamic-content {
                        border: 1px solid #ccc;
                        padding: 10px;
                        margin-top: 20px;
                    }
                </style>
            </head>

            <body>
                <c:set var="ctx" value="${pageContext.request.contextPath}" />
                <div class="text-center mb-6">
                    <h1 class="text-3xl font-bold text-blue-600">
                        Bienvenue sur TapTapSend Clone
                    </h1>
                    <p class="text-gray-600">
                        JSP + JSTL + HTMX + Tailwind 😎
                    </p>
                </div>

                <button hx-get="${ctx}/fragment" hx-target="#dynamic-content"
                    class="bg-blue-500 hover:bg-blue-600 text-white px-4 py-2 rounded shadow">
                    Charger le contenu dynamique
                </button>

                <div id="dynamic-content" class="mt-4 p-4 border rounded">
                    <p>Cliquez pour charger du contenu.</p>
                </div>F
            </body>

            </html>