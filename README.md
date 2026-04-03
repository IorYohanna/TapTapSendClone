# TapTapSend Clone

Ce projet est une application web Java utilisant JSP, JSTL et HTMX pour créer des interfaces dynamiques sans JavaScript personnalisé.

## Structure du Projet

- `src/main/java/` : Code source Java (servlets)
- `src/main/resources/` : Ressources statiques
- `src/main/webapp/` : Pages web (JSP, web.xml)
- `src/test/java/` : Tests unitaires

## Technologies Utilisées

- **Jakarta EE 10** : Pour les servlets et JSP
- **JSTL 3.0** : Pour les balises JSP
- **HTMX** : Pour les interactions dynamiques côté client
- **Maven** : Gestion des dépendances et build
- **Tomcat 10** : Serveur d'application

## Démarrage

1. Importer le projet dans IntelliJ IDEA ou Eclipse comme projet Maven
2. Compiler avec `mvn clean compile`
3. Déployer sur Tomcat ou utiliser `mvn tomcat7:run` (avec le plugin approprié)
4. Accéder à `http://localhost:8080/`

## Développement Futur

- Ajouter des contrôleurs pour gérer différentes pages
- Intégrer une base de données (JDBC)
- Implémenter l'authentification et la gestion des sessions
- Ajouter des tests unitaires et d'intégration
- Optimiser les performances et la sécurité