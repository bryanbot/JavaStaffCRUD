#!/bin/bash

echo "------------------------------------------"
echo "🛠️  Construyendo Gestion de Empleados..."
echo "------------------------------------------"

# 1. Compilar con Maven (asegúrate de tenerlo instalado)
mvn clean package -DskipTests

# 2. Levantar con Docker Compose
echo "🐳 Iniciando contenedores..."
docker-compose down # Detener ejecuciones previas
docker-compose up -d --build

echo "------------------------------------------"
echo "🚀 ¡Despliegue completado con éxito!"
echo "Accede a: http://localhost:8080"
echo "------------------------------------------"