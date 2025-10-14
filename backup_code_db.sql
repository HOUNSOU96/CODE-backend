-- Table alembic_version
DROP TABLE IF EXISTS alembic_version;
CREATE TABLE alembic_version (
    version_num VARCHAR(32) PRIMARY KEY
);

INSERT INTO alembic_version (version_num) VALUES ('853541d6a8bd');

-- Table questions
DROP TABLE IF EXISTS questions;
CREATE TABLE questions (
    id VARCHAR(255) PRIMARY KEY,
    niveau VARCHAR(50),
    serie VARCHAR(50),
    matiere VARCHAR(50),
    notion VARCHAR(100),
    duration INT,
    question VARCHAR(500),
    choix JSONB,
    bonne_reponse VARCHAR(255),
    situation JSONB
);

-- Table remediation_videos
DROP TABLE IF EXISTS remediation_videos;
CREATE TABLE remediation_videos (
    id VARCHAR(255) PRIMARY KEY,
    titre VARCHAR(200),
    niveau VARCHAR(50),
    serie VARCHAR(50),
    matiere VARCHAR(50),
    mois JSONB,
    videoUrl VARCHAR(500),
    notions JSONB,
    prerequis JSONB
);

-- Table users
DROP TABLE IF EXISTS users;
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    prenom VARCHAR(100) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    telephone VARCHAR(20),
    sexe CHAR(1),
    date_naissance DATE,
    lieu_naissance VARCHAR(255),
    nationalite VARCHAR(100),
    pays_residence VARCHAR(100),
    hashed_password VARCHAR(255) NOT NULL,
    plain_password VARCHAR(255),
    status VARCHAR(50),
    validation_token VARCHAR(255),
    is_validated BOOLEAN DEFAULT FALSE,
    is_admin BOOLEAN DEFAULT FALSE,
    is_blocked BOOLEAN DEFAULT FALSE,
    is_active BOOLEAN DEFAULT TRUE,
    is_verified BOOLEAN DEFAULT FALSE,
    last_warning TIMESTAMP,
    date_inscription TIMESTAMP DEFAULT NOW(),
    created_at TIMESTAMP DEFAULT NOW(),
    reset_token VARCHAR(255),
    reset_token_expiry TIMESTAMP
);

-- Table video_questions
DROP TABLE IF EXISTS video_questions;
CREATE TABLE video_questions (
    id VARCHAR(255) PRIMARY KEY,
    question VARCHAR(500),
    choix JSONB,
    bonne_reponse VARCHAR(255),
    niveau VARCHAR(50),
    serie VARCHAR(50),
    matiere VARCHAR(50),
    notion VARCHAR(100),
    duration INT,
    remediation_video_id VARCHAR(255) NOT NULL,
    CONSTRAINT fk_remediation_video
        FOREIGN KEY(remediation_video_id)
        REFERENCES remediation_videos(id)
        ON DELETE CASCADE
);
