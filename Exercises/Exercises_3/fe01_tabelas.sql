show user;


CREATE TABLESPACE music_tables DATAFILE 'music_files_01.dbf' SIZE 200M;

SELECT table_name
FROM user_tables
ORDER BY table_name;

CREATE TABLE autor (
    "id_autor" NUMBER(4,0) NOT NULL ENABLE,
    "nome" VARCHAR2(200 byte) NOT NULL ENABLE,
    CONSTRAINT "AUTOR_PK" PRIMARY KEY ("id_autor")
    );
    
    
CREATE TABLE editora (
    "id_editora" NUMBER(4,0) NOT NULL ENABLE,
    "nome" VARCHAR2(200 byte) NOT NULL ENABLE,
    CONSTRAINT "EDITORA_PK" PRIMARY KEY ("id_editora")
    );
    
CREATE TABLE genero (
    "id_genero" NUMBER(4,0) NOT NULL ENABLE,
    "nome" VARCHAR2(200 byte) NOT NULL ENABLE,
    CONSTRAINT "GENERO_PK" PRIMARY KEY ("id_genero")
    );
    
CREATE TABLE suporte (
    "id_suporte" NUMBER(4,0) NOT NULL ENABLE,
    "nome" VARCHAR2(200 byte) NOT NULL ENABLE,
    CONSTRAINT "SUPORTE_PK" PRIMARY KEY ("id_suporte")
    );
    
CREATE TABLE titulo (
    "id_titulo" NUMBER(4,0) NOT NULL ENABLE,
    "titulo" VARCHAR2(200 byte) NOT NULL ENABLE,
    "preco" NUMBER,
    "dta_compra" DATE,
    "id_editora_fk" NUMBER(4,0) NOT NULL ENABLE,
    "id_suporte_fk" NUMBER(4,0) NOT NULL ENABLE,
    "id_genero_fk" NUMBER(4,0) NOT NULL ENABLE,
    "id_autor_fk" NUMBER(4,0) NOT NULL ENABLE,
    CONSTRAINT "TITULO_PK" PRIMARY KEY ("id_titulo"),
    CONSTRAINT "TITULO_EDITORA_FK"
        FOREIGN KEY ("id_editora_fk")
        REFERENCES editora("id_editora"),
    CONSTRAINT "TITULO_SUPORTE_FK"
        FOREIGN KEY ("id_suporte_fk")
        REFERENCES suporte("id_suporte"),
    CONSTRAINT "TITULO_GENERO_FK"
        FOREIGN KEY ("id_genero_fk")
        REFERENCES genero("id_genero"),
    CONSTRAINT "TITULO_AUTOR_FK"
        FOREIGN KEY ("id_autor_fk")
        REFERENCES autor("id_autor")
    );

CREATE TABLE musica (
    "id_musica" NUMBER(4,0) NOT NULL ENABLE,
    "nome" VARCHAR2(200 byte) NOT NULL ENABLE,
    "id_autor_fk" NUMBER(4,0) NOT NULL ENABLE,
    "id_titulo_fk" NUMBER(4,0) NOT NULL ENABLE,
    CONSTRAINT "MUSICA_PK" PRIMARY KEY ("id_musica"),
    CONSTRAINT "MUSICA_AUTOR_FK"
        FOREIGN KEY ("id_autor_fk")
        REFERENCES autor("id_autor"),
    CONSTRAINT "MUSICA_TITULO_FK"
        FOREIGN KEY ("id_titulo_fk")
        REFERENCES titulo("id_titulo")
    );
    
CREATE TABLE review (
    "id_review" NUMBER(4,0) NOT NULL ENABLE,
    "id_titulo_fk" NUMBER(4,0) NOT NULL ENABLE,
    "dta_review" DATE,
    "conteudo" VARCHAR2(200 byte) NOT NULL ENABLE,
    CONSTRAINT "REVIEW_PK" PRIMARY KEY ("id_review"),
    CONSTRAINT "REVIEW_TITULO_FK"
        FOREIGN KEY ("id_titulo_fk")
        REFERENCES titulo("id_titulo")
    );    
