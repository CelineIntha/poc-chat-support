# PoC Chat Support – Your Car Your Way

Ce projet est une preuve de concept permettant de démontrer la faisabilité d’un système de chat en ligne entre un client
et le support, basé sur WebSocket.
Il s’intègre dans l’architecture globale de l’application Your Car Your Way.

## Technologies

- Java 21
- Spring Boot 3.5
- Maven
- Node.js 22
- Npm
- Angular CLI 20

## Lancer le projet back

Depuis le dossier back/chat-poc :

1. Installation des dépendances :
```
mvn clean install
```

ou

```
./mvnw clean install 
```
2. Lancer le projet avec la commande

```
.mvn spring-boot:run
```

ou

```
./mvnw spring-boot:run
```

3. Le serveur démarre sur :

```
http://localhost:8080/chat
```

4. Le WebSocket est disponible sur :

```
ws://localhost:8080/chat
```

## Lancer le projet front

Depuis le dossier front/chat-app :

1. Installation des dépendances :

```
npm install
```

2. Lancer le serveur avec la commande :

```
ng serve
```

3. L'application Angular démarre sur :

```
http://localhost:4200
```

## Les fonctionnalités

- Connexion au backend via WebSocket 
- Envoi et réception de messages en temps réel
- Interface en Angular avec : zone de messages, champ de saisie, bouton envoyer
- UI simple avec Angular Material + Bootstrap

## Comment tester le PoC

1. Lancer le backend (mvn spring-boot:run)
2. Lancer le frontend (ng serve)
3. Ouvrir http://localhost:4200 dans 2 onglets différents.
4. Envoyer un message depuis un onglet → il apparaît dans les deux.

## Limites actuelles
- Pas d’authentification (simplification pour le PoC)
- Pas de persistance des données
- UI minimale (pas encore de différenciation claire entre “moi” et “les autres”)

## Les prochaines étapes
- Ajouter l'authentification, la gestion des utilisateurs connectés
- Sauvegarder les messages dans la base de données
- Améliorer l’UI (bulles, avatars, couleurs)
- Sécuriser la communication avec authentification