-- =====================
-- ELIMINAR TABLAS EXISTENTES
-- (facts primero para respetar FK, luego dims)
-- =====================
DROP TABLE fact_rating CASCADE CONSTRAINTS;
DROP TABLE fact_sales CASCADE CONSTRAINTS;
DROP TABLE dim_game CASCADE CONSTRAINTS;
DROP TABLE dim_publisher CASCADE CONSTRAINTS;
DROP TABLE dim_time CASCADE CONSTRAINTS;
DROP TABLE dim_platform CASCADE CONSTRAINTS;
DROP TABLE dim_genre CASCADE CONSTRAINTS;

-- =====================
-- CREAR DIMENSIONES + SECUENCIAS + TRIGGERS
-- =====================
CREATE TABLE dim_genre (
    id_genre   INTEGER NOT NULL,
    genre      VARCHAR2(100)
);
ALTER TABLE dim_genre ADD CONSTRAINT dim_genre_pk PRIMARY KEY ( id_genre );

CREATE TABLE dim_platform (
    id_platform   INTEGER NOT NULL,
    platform      VARCHAR2(100)
);
ALTER TABLE dim_platform ADD CONSTRAINT dim_platform_pk PRIMARY KEY ( id_platform );

CREATE TABLE dim_time (
    id_time   INTEGER NOT NULL,
    year      INTEGER
);
ALTER TABLE dim_time ADD CONSTRAINT dim_time_pk PRIMARY KEY ( id_time );

CREATE TABLE dim_publisher (
    id_publisher   INTEGER NOT NULL,
    publisher      VARCHAR2(200)
);
ALTER TABLE dim_publisher ADD CONSTRAINT dim_publisher_pk PRIMARY KEY ( id_publisher );

CREATE TABLE dim_game (
    id_game     INTEGER NOT NULL,
    game        VARCHAR2(200),
    developer   VARCHAR2(200),
    rating      VARCHAR2(50)
);
ALTER TABLE dim_game ADD CONSTRAINT dim_game_pk PRIMARY KEY ( id_game );

-- TABLAS DE HECHO

CREATE TABLE fact_sales (
    na_sales       DECIMAL(12,2),
    eu_sales       DECIMAL(12,2),
    jp_sales       DECIMAL(12,2),
    other_sales    DECIMAL(12,2),
    global_sales   DECIMAL(12,2),
    game_id        INTEGER NOT NULL,
    platform_id    INTEGER NOT NULL,
    time_id        INTEGER,
    genre_id       INTEGER NOT NULL,
    publisher_id   INTEGER
);

ALTER TABLE fact_sales ADD CONSTRAINT fact_sales_game_fk      FOREIGN KEY ( game_id )      REFERENCES dim_game ( id_game );
ALTER TABLE fact_sales ADD CONSTRAINT fact_sales_platform_fk  FOREIGN KEY ( platform_id )  REFERENCES dim_platform ( id_platform );
ALTER TABLE fact_sales ADD CONSTRAINT fact_sales_time_fk      FOREIGN KEY ( time_id )      REFERENCES dim_time ( id_time );
ALTER TABLE fact_sales ADD CONSTRAINT fact_sales_genre_fk     FOREIGN KEY ( genre_id )     REFERENCES dim_genre ( id_genre );
ALTER TABLE fact_sales ADD CONSTRAINT fact_sales_publisher_fk FOREIGN KEY ( publisher_id ) REFERENCES dim_publisher ( id_publisher );

CREATE TABLE fact_rating (
    critic_score    INTEGER,
    critic_count    INTEGER,
    user_score      DECIMAL(4,2),
    user_count      INTEGER,
    game_id         INTEGER NOT NULL,
    platform_id     INTEGER NOT NULL,
    time_id         INTEGER,
    genre_id        INTEGER NOT NULL,
    publisher_id    INTEGER
);

ALTER TABLE fact_rating ADD CONSTRAINT fact_rating_game_fk      FOREIGN KEY ( game_id )      REFERENCES dim_game ( id_game );
ALTER TABLE fact_rating ADD CONSTRAINT fact_rating_platform_fk  FOREIGN KEY ( platform_id )  REFERENCES dim_platform ( id_platform );
ALTER TABLE fact_rating ADD CONSTRAINT fact_rating_time_fk      FOREIGN KEY ( time_id )      REFERENCES dim_time ( id_time );
ALTER TABLE fact_rating ADD CONSTRAINT fact_rating_genre_fk     FOREIGN KEY ( genre_id )     REFERENCES dim_genre ( id_genre );
ALTER TABLE fact_rating ADD CONSTRAINT fact_rating_publisher_fk FOREIGN KEY ( publisher_id ) REFERENCES dim_publisher ( id_publisher );
