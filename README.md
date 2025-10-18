# `file-upload-reseau` : Simulation de Vulnérabilité de Téléchargement de Fichier

## Présentation du Projet

Ce projet est une application web minimaliste développée avec **Symfony** et **PHP**, conçue pour simuler une fonctionnalité courante de réseau social : le **téléchargement d'une image de profil**.

L'objectif principal de cette application est de servir de bac à sable pour la démonstration et la pratique de l'exploitation de la **vulnérabilité de téléchargement de fichiers non sécurisé**.

### Contexte de Sécurité

L'application est délibérément vulnérable aux tentatives de contournement de restrictions. Le scénario d'exploitation se concentre sur l'éventualité où un attaquant parvient à :

1.  Télécharger un fichier avec une extension non autorisée (ex: **`.php`**) à la place d'une image (ex: `.jpg` ou `.png`).
2.  Exécuter ce fichier malveillant (souvent appelé **webshell**) sur le serveur.
3.  Utiliser le webshell pour exécuter des commandes arbitraires.

Ce projet permet de comprendre l'importance de mettre en place des contrôles d'upload stricts (vérification du type MIME, renommage des fichiers, validation de l'extension, analyse du contenu) dans des environnements de production.

-----

## Technologies Utilisées

  * **Framework:** Symfony (PHP)
  * **Langage:** PHP
  * **Conteneurisation:** Docker & Docker Compose
  * **Base de Données:** MySQL 
  * **Templates:** Twig

-----

## Déploiement et Démarrage

Ce projet utilise Docker Compose pour garantir un environnement simple à mettre en place.

### Prérequis

Vous devez avoir installé sur votre machine :

  * **[Docker Engine](https://docs.docker.com/engine/install/)**
  * **[Docker Compose](https://docs.docker.com/compose/install/)**

### Étapes de Démarrage

1.  **Cloner le dépôt**
    Ouvrez votre terminal et clonez le projet :

    ```bash
    git clone https://github.com/Mohafa-cat/file-upload-reseau.git
    cd file-upload-reseau
    ```

2.  **Démarrer les conteneurs**
    Utilisez Docker Compose pour construire l'image et démarrer les services (serveur web, base de données, etc.). L'option `--build` est nécessaire lors du premier lancement :

    ```bash
    docker compose up -d --build
    ```

    *Le flag `-d` permet de lancer les conteneurs en arrière-plan.*

3.  **Accéder à l'application**
    L'application devrait maintenant être accessible via votre navigateur à l'adresse suivante :

    [http://localhost:8000](http://localhost:8000) (ou le port configuré dans votre `compose.yml`).

-----

## Arrêt du Projet

Pour arrêter et supprimer les conteneurs (y compris la base de données), utilisez la commande suivante :

```bash
docker compose down -v
```

*Le flag `-v` supprime les volumes de données attachés, réinitialisant la base de données.*


### Documentation Technique

  * **Documentation Symfony:** Guide officiel pour le développement avec le framework PHP.
    [https://symfony.com/doc](https://symfony.com/doc)


  * **Documentation Docker Compose:** Référence pour la configuration et la gestion des environnements multi-conteneurs.
    [https://docs.docker.com/compose/](https://docs.docker.com/compose/)

