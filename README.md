# 🚀 TalentFlow - Sistema de Gestión de Personal

**TalentFlow** es una aplicación web robusta desarrollada en **Java Jakarta EE** bajo el patrón de arquitectura **MVC (Model-View-Controller)**. El sistema permite la gestión integral de empleados con una experiencia de usuario fluida y un despliegue moderno basado en contenedores.



## ✨ Características Destacadas

* **Búsqueda Asíncrona (AJAX):** Filtrado de empleados en tiempo real mediante `Fetch API`, evitando recargas de página innecesarias.
* **Arquitectura Desacoplada:** Código JavaScript organizado en archivos externos para mejorar la mantenibilidad y evitar conflictos con el motor JSP.
* **Conexión Híbrida Inteligente:** Lógica de conexión a base de datos que detecta automáticamente el entorno (Local/Docker) mediante variables de entorno.
* **Interfaz Responsiva:** Diseño profesional y limpio utilizando **Bootstrap 5** y **FontAwesome**.

## 🛠️ Stack Tecnológico

* **Backend:** Java 17, Jakarta EE (Servlets & JSP), JSTL.
* **Frontend:** JavaScript Vanilla (ES6+), Bootstrap 5, CSS3.
* **Base de Datos:** MySQL 8.0.
* **DevOps:** Docker, Docker Compose, Maven.

## 📦 Despliegue con Docker (Recomendado)

Este proyecto está configurado para ejecutarse en cualquier entorno sin necesidad de instalar dependencias locales.

1.  **Generar el artefacto:**
    Desde Eclipse (Run As -> Maven build) o terminal:
    ```bash
    mvn clean package -DskipTests
    ```

2.  **Lanzar la infraestructura:**
    ```bash
    docker-compose up -d --build
    ```

3.  **Acceso:**
    Abre tu navegador en [http://localhost:8080](http://localhost:8080)

## 📂 Estructura del Proyecto

```text
├── src/main/java
│   ├── config/         # Configuración de Conexión (Híbrida)
│   ├── controlador/    # Servlets (Control de flujo)
│   ├── modelo/         # Entidades y DAOs (Lógica de datos)
├── webapp/
│   ├── js/             # Lógica de búsqueda AJAX (Separada de JSP)
│   ├── vista/          # Páginas JSP (Interfaz de usuario)
├── db/                 # Script SQL de inicialización automática
├── Dockerfile          # Definición de imagen Tomcat
└── docker-compose.yml  # Orquestación App + Base de Datos
