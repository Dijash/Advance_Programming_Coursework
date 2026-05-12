# Advance Programming Coursework

A full-stack Java web application developed for Advanced Programming coursework.  
This project demonstrates the implementation of modern web application development concepts using Java, JSP, Servlets, JDBC, and MySQL.

## Features

- User Authentication & Authorization
- Admin Dashboard
- Vehicle Management System
- Booking Management
- Customer Management
- Review & Feedback System
- Notification System
- Responsive UI Design
- CRUD Operations
- Database Integration using JDBC
- MVC Architecture

## Technologies Used

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

### Tools & IDE
- IntelliJ IDEA
- Apache Tomcat
- Git & GitHub

## Project Structure

```bash
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
│   └── sql files
│
└── README.md
```

## Installation Guide

### 1. Clone the Repository

```bash
git clone https://github.com/Dijash/Advance_Programming_Coursework.git
```

### 2. Open in IntelliJ IDEA

- Open IntelliJ IDEA
- Select `Open Project`
- Choose the cloned project folder

### 3. Configure Apache Tomcat

- Install Apache Tomcat
- Add Tomcat Server in IntelliJ IDEA
- Configure deployment artifact

### 4. Setup MySQL Database

- Create a MySQL database
- Import the provided SQL file
- Update database credentials inside:

```java
DBConnection.java
```

Example:

```java
private static final String URL = "jdbc:mysql://localhost:3306/your_database";
private static final String USER = "root";
private static final String PASSWORD = "password";
```

### 5. Run the Project

- Start Tomcat Server
- Open the browser and visit:

```bash
http://localhost:8080/Advance_Programming_Coursework
```

## Learning Objectives

This coursework project was developed to practice:

- Object-Oriented Programming
- MVC Design Pattern
- Database Connectivity
- Session Management
- Form Handling & Validation
- CRUD Operations
- Responsive Web Design
- Java Web Development

## Future Improvements

- REST API Integration
- Email Notifications
- Payment Gateway
- Role-Based Access Control
- Search & Filtering
- Dark Mode UI

## Author

Developed by Dijash and his team

GitHub: https://github.com/Dijash

## License

This project is developed for educational purposes only.
