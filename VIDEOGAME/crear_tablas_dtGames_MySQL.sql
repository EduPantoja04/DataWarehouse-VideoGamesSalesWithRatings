-- =====================
-- ELIMINAR TABLAS EXISTENTES
-- (facts primero para respetar FK, luego dims)
-- =====================
SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS fact_rating;
DROP TABLE IF EXISTS fact_sales;
DROP TABLE IF EXISTS dim_game;
DROP TABLE IF EXISTS dim_publisher;
DROP TABLE IF EXISTS dim_time;
DROP TABLE IF EXISTS dim_platform;
DROP TABLE IF EXISTS dim_genre;

SET FOREIGN_KEY_CHECKS = 1;

-- =====================
-- DIMENSIONES
-- =====================

CREATE TABLE dim_genre (
    id_genre   INT NOT NULL AUTO_INCREMENT,
    genre      VARCHAR(100),
    PRIMARY KEY (id_genre)
);

CREATE TABLE dim_platform (
    id_platform   INT NOT NULL AUTO_INCREMENT,
    platform      VARCHAR(100),
    PRIMARY KEY (id_platform)
);

CREATE TABLE dim_time (
    id_time   INT NOT NULL AUTO_INCREMENT,
    year      INT,
    PRIMARY KEY (id_time)
);

CREATE TABLE dim_publisher (
    id_publisher   INT NOT NULL AUTO_INCREMENT,
    publisher      VARCHAR(200),
    PRIMARY KEY (id_publisher)
);

CREATE TABLE dim_game (
    id_game     INT NOT NULL AUTO_INCREMENT,
    game        VARCHAR(200),
    developer   VARCHAR(200),
    rating      VARCHAR(50),
    PRIMARY KEY (id_game)
);

-- =====================
-- TABLAS DE HECHO
-- =====================

CREATE TABLE fact_sales (
    na_sales       DECIMAL(12,2),
    eu_sales       DECIMAL(12,2),
    jp_sales       DECIMAL(12,2),
    other_sales    DECIMAL(12,2),
    global_sales   DECIMAL(12,2),
    game_id        INT NOT NULL,
    platform_id    INT NOT NULL,
    time_id        INT,
    genre_id       INT NOT NULL,
    publisher_id   INT,
    CONSTRAINT fact_sales_game_fk      FOREIGN KEY (game_id)      REFERENCES dim_game (id_game),
    CONSTRAINT fact_sales_platform_fk  FOREIGN KEY (platform_id)  REFERENCES dim_platform (id_platform),
    CONSTRAINT fact_sales_time_fk      FOREIGN KEY (time_id)      REFERENCES dim_time (id_time),
    CONSTRAINT fact_sales_genre_fk     FOREIGN KEY (genre_id)     REFERENCES dim_genre (id_genre),
    CONSTRAINT fact_sales_publisher_fk FOREIGN KEY (publisher_id) REFERENCES dim_publisher (id_publisher)
);

CREATE TABLE fact_rating (
    critic_score    INT,
    critic_count    INT,
    user_score      DECIMAL(4,2),
    user_count      INT,
    game_id         INT NOT NULL,
    platform_id     INT NOT NULL,
    time_id         INT,
    genre_id        INT NOT NULL,
    publisher_id    INT,
    CONSTRAINT fact_rating_game_fk      FOREIGN KEY (game_id)      REFERENCES dim_game (id_game),
    CONSTRAINT fact_rating_platform_fk  FOREIGN KEY (platform_id)  REFERENCES dim_platform (id_platform),
    CONSTRAINT fact_rating_time_fk      FOREIGN KEY (time_id)      REFERENCES dim_time (id_time),
    CONSTRAINT fact_rating_genre_fk     FOREIGN KEY (genre_id)     REFERENCES dim_genre (id_genre),
    CONSTRAINT fact_rating_publisher_fk FOREIGN KEY (publisher_id) REFERENCES dim_publisher (id_publisher)
);
