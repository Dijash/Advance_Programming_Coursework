# 🚀 Advance Programming Coursework

A full-stack Java web application developed for the **Advanced Programming coursework**.  
This project demonstrates modern web application development using **Java, JSP, Servlets, JDBC, and MySQL**, following
the **MVC architecture**.

---

## ✨ Features

- 🔐 User Authentication & Authorization
- 🧑‍💼 Admin Dashboard
- 🚗 Vehicle Management System
- 📅 Booking Management System
- 👤 Customer Management System
- ⭐ Review & Feedback System
- 🔔 Notification System
- 📱 Responsive UI Design
- 🧩 Full CRUD Operations
- 🗄️ MySQL Database Integration
- 🏗️ MVC Architecture Implementation

---

## 🛠️ Technologies Used

### Backend

- Java
- JSP (Java Server Pages)
- Servlets
- JDBC

### Frontend

- HTML5
- CSS3
- JavaScript

### Database

- MySQL

### Tools & Environment

- IntelliJ IDEA
- Apache Tomcat
- Git & GitHub

---

## 📁 Project Structure

```
Advance_Programming_Coursework/
│
├── src/
│   ├── com.DAO/
│   ├── com.model/
│   ├── com.service/
│   ├── com.util/
│
├── webapp/
│   ├── css/
│   ├── js/
│   ├── images/
│   ├── WEB-INF/
│   └── *.jsp
│
├── database/
│   └── SQL scripts
│
└── README.md
```

---

## ⚙️ Installation Guide

### 1. Clone the Repository

```bash
git clone https://github.com/Dijash/Advance_Programming_Coursework.git
```

---

### 2. Open in IntelliJ IDEA

- Open **IntelliJ IDEA**
- Click **Open Project**
- Select the cloned repository folder

---

### 3. Configure Apache Tomcat

- Install Apache Tomcat
- Add Tomcat server in IntelliJ IDEA
- Configure deployment artifacts

---

### 4. Setup MySQL Database

- Create a MySQL database
- Import SQL file from `/database` folder
- Update credentials in:

```java
DBConnection.java
```

Example:

```java
private static final String URL = "jdbc:mysql://localhost:3306/your_database";
private static final String USER = "root";
private static final String PASSWORD = "password";
```

---

### 5. Run the Project

- Start Apache Tomcat server
- Open browser and visit:

```
http://localhost:8080/Advance_Programming_Coursework
```

---

## 🎯 Learning Objectives

- Object-Oriented Programming (OOP)
- MVC Design Pattern
- JDBC Database Connectivity
- Session Management
- Form Handling & Validation
- Full-stack Java Web Development
- CRUD Operations
- Responsive Web Design

---

## 🚀 Future Improvements

- REST API integration (Spring Boot migration)
- Email notification system
- Payment gateway integration
- Role-based access control
- Advanced search & filtering
- Dark mode UI
- Logging & analytics system

---

## 👨‍💻 Author

Developed by **Dijash and Team**

GitHub: https://github.com/Dijash

---

## 📄 License

This project is created for **educational purposes only**.