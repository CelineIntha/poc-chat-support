-- Base de données : your_car_your_way

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

CREATE DATABASE IF NOT EXISTS your_car_your_way
    DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE your_car_your_way;

-- --------------------------------------------------------
-- Table : agence
-- --------------------------------------------------------
CREATE TABLE agence (
                        id BIGINT NOT NULL AUTO_INCREMENT,
                        ville VARCHAR(100) NOT NULL,
                        pays VARCHAR(100) NOT NULL,
                        coordonnees VARCHAR(255) DEFAULT NULL,
                        PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------
-- Table : utilisateur
-- --------------------------------------------------------
CREATE TABLE utilisateur (
                             id BIGINT NOT NULL AUTO_INCREMENT,
                             email VARCHAR(255) NOT NULL UNIQUE,
                             mot_de_passe_hash VARCHAR(255) NOT NULL,
                             nom VARCHAR(100) DEFAULT NULL,
                             prenom VARCHAR(100) DEFAULT NULL,
                             date_naissance DATE DEFAULT NULL,
                             adresse TEXT DEFAULT NULL,
                             num_permis VARCHAR(50) DEFAULT NULL,
                             created_at DATETIME DEFAULT current_timestamp(),
                             updated_at DATETIME DEFAULT current_timestamp() ON UPDATE current_timestamp(),
                             PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------
-- Table : moyen_paiement
-- --------------------------------------------------------
CREATE TABLE moyen_paiement (
                                id BIGINT NOT NULL AUTO_INCREMENT,
                                utilisateur_id BIGINT NOT NULL,
                                stripe_payment_method_id VARCHAR(255) NOT NULL,
                                actif BOOLEAN DEFAULT TRUE,
                                created_at DATETIME DEFAULT current_timestamp(),
                                PRIMARY KEY (id),
                                FOREIGN KEY (utilisateur_id) REFERENCES utilisateur(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------
-- Table : offre
-- --------------------------------------------------------
CREATE TABLE offre (
                       id BIGINT NOT NULL AUTO_INCREMENT,
                       agence_depart_id BIGINT NOT NULL,
                       agence_retour_id BIGINT NOT NULL,
                       date_heure_depart DATETIME NOT NULL,
                       date_heure_retour DATETIME NOT NULL,
                       categorie_acriss VARCHAR(50) NOT NULL,
                       prix DECIMAL(10,2) NOT NULL,
                       PRIMARY KEY (id),
                       FOREIGN KEY (agence_depart_id) REFERENCES agence(id),
                       FOREIGN KEY (agence_retour_id) REFERENCES agence(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------
-- Table : reservation
-- --------------------------------------------------------
CREATE TABLE reservation (
                             id BIGINT NOT NULL AUTO_INCREMENT,
                             utilisateur_id BIGINT NOT NULL,
                             offre_id BIGINT NOT NULL,
                             statut VARCHAR(50) DEFAULT 'EN_COURS',
                             paiement_id VARCHAR(255) DEFAULT NULL,
                             created_at DATETIME DEFAULT current_timestamp(),
                             updated_at DATETIME DEFAULT current_timestamp() ON UPDATE current_timestamp(),
                             PRIMARY KEY (id),
                             FOREIGN KEY (utilisateur_id) REFERENCES utilisateur(id) ON DELETE CASCADE,
                             FOREIGN KEY (offre_id) REFERENCES offre(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------
-- Table : conversation_support
-- (table pour gérer les chats entre client et support)
-- --------------------------------------------------------
CREATE TABLE conversation_support (
                                      id BIGINT NOT NULL AUTO_INCREMENT,
                                      utilisateur_id BIGINT NOT NULL,
                                      statut VARCHAR(50) DEFAULT 'OUVERT',
                                      created_at DATETIME DEFAULT current_timestamp(),
                                      updated_at DATETIME DEFAULT current_timestamp() ON UPDATE current_timestamp(),
                                      PRIMARY KEY (id),
                                      FOREIGN KEY (utilisateur_id) REFERENCES utilisateur(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------
-- Table : message_support
-- --------------------------------------------------------
CREATE TABLE message_support (
                                 id BIGINT NOT NULL AUTO_INCREMENT,
                                 conversation_id BIGINT NOT NULL,
                                 utilisateur_id BIGINT NOT NULL,
                                 contenu TEXT NOT NULL,
                                 type VARCHAR(50) DEFAULT 'CLIENT',
                                 statut VARCHAR(50) DEFAULT 'ENVOYE',
                                 created_at DATETIME DEFAULT current_timestamp(),
                                 PRIMARY KEY (id),
                                 FOREIGN KEY (conversation_id) REFERENCES conversation_support(id) ON DELETE CASCADE,
                                 FOREIGN KEY (utilisateur_id) REFERENCES utilisateur(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

COMMIT;
