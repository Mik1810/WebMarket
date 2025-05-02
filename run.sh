#!/bin/bash

# Directory del progetto (assicurati che sia la tua directory di lavoro)
PROJECT_DIR=$(pwd)

# Nome dell'immagine Docker (puoi modificarlo come preferisci)
IMAGE_NAME="webmarket"

# Nome del WAR compilato (modifica se il tuo WAR ha un nome diverso)
WAR_FILE="$PROJECT_DIR/target/webmarket-1.0-SNAPSHOT.war"

echo "Compilando il WAR..."

# 1. Compila il WAR usando Maven
mvn clean package

# 2. Costruisce l'immagine Docker usando Docker Compose
echo "Costruendo l'immagine Docker con Docker Compose..."

docker-compose build

# 3. Avvia il container Docker utilizzando Docker Compose
echo "Avviando il container Docker con Docker Compose..."

docker-compose up -d

# Mostra i log del container per verificare se è in esecuzione correttamente
echo "Mostrando i log di Tomcat..."
docker-compose logs -f backend

echo "Il container è in esecuzione su http://localhost:8080"
