# `file-upload-reseau` : Simulation de vulnérabilité de téléversement de fichier

## Présentation du projet

Ce projet est une application web minimaliste développée avec **Symfony** et **PHP**, conçue pour simuler une fonctionnalité courante d'un réseau social : le **téléversement d'une image de profil**.

L'objectif principal de cette application est de servir de bac à sable pour la démonstration et la pratique de l'exploitation de la **vulnérabilité de téléversement de fichiers non sécurisé**.

### Contexte de sécurité

L'application est délibérément vulnérable afin de permettre des tentatives de contournement des restrictions. Le scénario d'exploitation se concentre sur l'éventualité où un attaquant parvient à :

1. Télécharger un fichier avec une extension non autorisée (ex : **`.php`**) à la place d'une image (ex : **`.jpg`** ou **`.png`**).
2. Exécuter ce fichier malveillant (souvent appelé **webshell**) sur le serveur.
3. Utiliser le webshell pour exécuter des commandes arbitraires.

Ce projet permet de comprendre l'importance de mettre en place des contrôles d'upload stricts (vérification du type MIME, renommage des fichiers, validation de l'extension, analyse du contenu) dans des environnements de production.

---

## Technologies utilisées

* **Framework :** Symfony (PHP)
* **Langage :** PHP
* **Conteneurisation :** Docker & Docker Compose
* **Base de données :** MySQL
* **Templates :** Twig

---

## Déploiement et démarrage

Ce projet utilise Docker Compose pour garantir un environnement simple à mettre en place.

### Prérequis

Vous devez avoir installé sur votre machine :

* **[Docker Engine](https://docs.docker.com/engine/install/)**
* **[Docker Compose](https://docs.docker.com/compose/install/)**

### Étapes de démarrage

1. **Cloner le dépôt**

   Ouvrez votre terminal et clonez le projet :

   ```bash
   git clone https://github.com/Mohafa-cat/file-upload-reseau.git
   cd file-upload-reseau
   ```

2. **Démarrer les conteneurs**

   Utilisez Docker Compose pour construire l'image et démarrer les services (serveur web, base de données, etc.). L'option `--build` est nécessaire lors du premier lancement :

   ```bash
   docker compose up -d --build
   ```

   *Le flag `-d` permet de lancer les conteneurs en arrière-plan.*

3. **Accéder à l'application**

   L'application devrait maintenant être accessible via votre navigateur à l'adresse suivante :

   `http://localhost:8000` (ou le port configuré dans votre `compose.yml`).

4. **Scripts utilisés**

   Lors de cet exercice vous aurez besoin de ces 2 scripts malveillants à compléter légèrement plus tard :

   **Script n°1 :**
   `
   `

   **Script n°2 :**
   `
   `

---


# 🎯 Exercice : Exploitation de la Vulnérabilité (WebShell)

Ce chapitre détaille les étapes pour exploiter la vulnérabilité de téléchargement de fichiers non sécurisé afin d'accéder aux informations sensibles du projet, y compris les identifiants de la base de données.

## 1. Upload de notre WebShell camouflé

### Qu'est-ce qu'un WebShell ?

Un WebShell est un script (souvent malveillant) installé sur un serveur web qui permet d’exécuter à distance des commandes et de contrôler le système via une interface HTTP.

Vous devez uploader sur le site le **script n°1** (contenant le WebShell). Ce script doit **simuler une photo de profil aux yeux du site**.

Étant donné que le site n'accepte que les extensions habituelles pour une photo de profil (`.jpg`, `.png`, `.gif`), vous devrez **camoufler** ce script pour permettre son upload.

## 2. Accès au WebShell

Après avoir réussi l'upload de votre script camouflé, le WebShell est désormais intégré au projet.

Pour trouver son lien d'accès :
1.  **Inspectez la balise de "l'image"** que vous venez d'uploader via les outils de développement de votre navigateur.
2.  Accédez au lien de votre WebShell via l'attribut `src` de cette balise.

## 3. Recherche des Informations clés de la Base de Données

Une fois votre WebShell accessible, vous devez l'utiliser pour **parcourir les fichiers du serveur** afin de récupérer les informations de connexion à la base de données.

Le fichier critique à rechercher est le suivant :

**Fichier recherché : `.env`**
Le fichier `.env` contient les variables d’environnement d’un projet (identifiants BDD, utilisateurs, clés API) en clair. (Ce fichier est très sensible : il ne doit si possible pas être committé dans Git et devrait être stocké en sécurité, par exemple dans un *vault*.)

Pour visualiser les fichiers cachés (dont le `.env`), n'oubliez pas d'utiliser l'option adéquate dans votre commande : **`-a`** (par exemple, avec la commande `ls`).

## 4. Compléter le script n°2

Après avoir récupéré les informations sensibles du fichier `.env`, vous allez compléter le **script n°2**. Ce script final permettra de se connecter directement à la base de données et de la récupérer.

Vous devez insérer les informations récupérées précédemment dans le script :
* Le nom d'utilisateur (`user`) de la Base de Données.
* Le mot de passe (`password`) de la Base de Données.
* Le port (`port`) de la Base de Données.

## 5. Récupération de la Base de Données

Pour finaliser l'exploitation, vous devez **uploader votre script final (script n°2)** de la même manière que vous l'avez fait pour le premier script et enfin

Une fois le script final exécuté via l'URL d'upload, la base de données sera à récupérer sur la balise de l'image comme pour le premier script.
---

## Arrêt du projet

Pour arrêter et supprimer les conteneurs (y compris la base de données), utilisez la commande suivante :

```bash
docker compose down -v
```

*Le flag `-v` supprime les volumes de données attachés, réinitialisant la base de données.*

### Documentation technique

* **Documentation Symfony :** Guide officiel pour le développement avec le framework PHP — [https://symfony.com/doc](https://symfony.com/doc)
* **Documentation Docker Compose :** Référence pour la configuration et la gestion des environnements multi-conteneurs — [https://docs.docker.com/compose/](https://docs.docker.com/compose/)

---

Lien du dépôt : [https://github.com/Mohafa-cat/file-upload-reseau/](https://github.com/Mohafa-cat/file-upload-reseau/)

*Remarque : ce projet est conçu à des fins éducatives pour sensibiliser aux risques liés au téléversement de fichiers. N'utilisez pas ces techniques en dehors d'un environnement contrôlé et avec l'autorisation explicite des propriétaires des systèmes ciblés.*
