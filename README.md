# MoneyFlow

> International money transfer web application — MoneyFlow inspired by [TapTapSend](https://taptapsend.com)

![Java](https://img.shields.io/badge/Java-ED8B00?style=for-the-badge&logo=openjdk&logoColor=white)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-316192?style=for-the-badge&logo=postgresql&logoColor=white)
![HTMX](https://img.shields.io/badge/HTMX-36C?style=for-the-badge&logo=htmx&logoColor=white)
![JSP](https://img.shields.io/badge/JSP-007396?style=for-the-badge&logo=java&logoColor=white)

---

##  About the Project

This project is a functional clone of TapTapSend, an international money transfer platform. 
The application allows managing clients, processing money transfers, automatically calculating fees, and handling exchange rates between currencies.

---

##  Features

-  **Client Management** — Add, edit, delete, and search for clients
-  **Money Transfers** — Send funds between countries with currency conversion
-  **Fee Calculation** — Automatic fee application based on amount and destination
-  **Exchange Rates** — Manage and update exchange rates per currency
-  **Filter & Search** — Dynamic search and data filtering
-  **Safe Deletion** — Confirmation prompt before any data deletion

---

##  Project Structure

```
src/main/
├── java/com/example/
│   ├── config/          # Spring configuration (DispatcherServlet, DataSource...)
│   ├── controller/      # MVC Controllers (HTTP endpoints)
│   ├── dao/             # Data Access Layer (JDBC/Hibernate)
│   ├── model/           # Business entities (Client, Transfer, Fee, Rate...)
│   └── service/         # Business logic
└── webapp/
    ├── js/              # JavaScript files (search, filter, delete)
    ├── WEB-INF/
    │   ├── views/       # JSP pages (client, send, fees, rates...)
    │   └── web.xml      # Servlet configuration
    └── index.jsp
    └── styles.css       # Global stylesheet
```

---

##  Tech Stack

| Layer | Technology |
|-------|------------|
| Backend | Java 11+, Spring MVC |
| Frontend | JSP, HTMX, CSS3, JavaScript |
| Database | POSTGRESQL |
| Build | Maven |
| Server | Apache Tomcat |

---

## Getting Started

### Prerequisites

- Java 11 or higher
- Maven 3.6+
- Postgres 8.0+
- Apache Tomcat 9+

### Steps

**1. Clone the repository**
```bash
git clone https://github.com/your-username/taptapsend-clone.git
cd taptapsend-clone
```

**2. Set up the database**
```bash
# Create the Posgresql database
psql -u root -p
CREATE DATABASE taptapsend_db;
```

Update the credentials in `src/main/java/com/example/config/`:
```java
// DataSource config
url = "jdbc:postgresql://localhost:5432/taptapsend_db"
username = "root"
password = "your_password"
```

**3. Build the project**
```bash
mvn clean install
```

**4. Deploy to Tomcat**

Copy the generated `.war` file into Tomcat's `webapps/` folder, or deploy directly from your IDE (IntelliJ / Eclipse).

**5. Access the app**
```
http://localhost:8080/taptapsend-clone/
```

---

##  Screenshots

| Page |
| <img width="1484" height="837" alt="image" src="https://github.com/user-attachments/assets/9f9da1c8-9f11-47e8-bc31-a4c51d5c2f56" />
| <img width="1407" height="777" alt="image" src="https://github.com/user-attachments/assets/943a9653-9851-4112-b89c-2a6462e8c71a" />
| <img width="1473" height="813" alt="image" src="https://github.com/user-attachments/assets/6279c6c2-bf5f-484a-a294-f431e9dc9f41" />|

---

##  What You'll Learned

This project will help you practice:
- **MVC architecture** with Java
- **DAO pattern** and data persistence
- Building **dynamic views** with JSP and JSTL
- Using **vanilla JavaScript** for interactivity (search, filter)
- Configuring a **Maven project** with Tomcat

---

##  License

This project was built for **academic and educational purposes** only.  
It is not affiliated with TapTapSend or its owners.

---

* Don't forget to leave a star if you found this project useful!*
