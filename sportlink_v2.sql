CREATE TABLE usuario (
    id_usuario     SERIAL PRIMARY KEY,
    nombre         VARCHAR(100) NOT NULL,
    apellidos      VARCHAR(100) NOT NULL,
    username       VARCHAR(50)  UNIQUE NOT NULL,
    correo         VARCHAR(150) UNIQUE NOT NULL,
    password       VARCHAR(255) NOT NULL,
    rol            VARCHAR(20)  NOT NULL CHECK (rol IN ('alumno','maestro','escuela')),
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE alumno (
    id_usuario        INTEGER PRIMARY KEY REFERENCES usuario(id_usuario) ON DELETE CASCADE,
    codigo_estudiante VARCHAR(50),
    edad              INTEGER,
    telefono          VARCHAR(20),
    deporte_interes   VARCHAR(100),
    foto              VARCHAR(255)
);

CREATE TABLE maestro (
    id_usuario   INTEGER PRIMARY KEY REFERENCES usuario(id_usuario) ON DELETE CASCADE,
    especialidad VARCHAR(100),
    experiencia  VARCHAR(255),
    precio       NUMERIC(10,2),
    ubicacion    VARCHAR(255),
    telefono     VARCHAR(20),
    red_social VARCHAR(100),
    descripcion  TEXT,
    dias         VARCHAR(100),
    foto         VARCHAR(255)
);

CREATE TABLE escuela (
    id_usuario         INTEGER PRIMARY KEY REFERENCES usuario(id_usuario) ON DELETE CASCADE,
    nombre_escuela     VARCHAR(150),
    direccion          VARCHAR(255),
    deporte            VARCHAR(100),
    deportes_ofrecidos TEXT,
    precio             NUMERIC(10,2),
    mensualidad        NUMERIC(10,2),
    ubicacion          VARCHAR(255),
    telefono           VARCHAR(20),
red_social VARCHAR(100),
    descripcion        TEXT,
    dias               VARCHAR(100),
    foto               VARCHAR(255)
);

CREATE TABLE favorito (
    id_favorito   SERIAL PRIMARY KEY,
    id_alumno     INTEGER NOT NULL REFERENCES usuario(id_usuario) ON DELETE CASCADE,
    id_proveedor  INTEGER NOT NULL REFERENCES usuario(id_usuario) ON DELETE CASCADE,
    tipo          VARCHAR(20) NOT NULL CHECK (tipo IN ('maestro','escuela')),
    fecha         TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(id_alumno, id_proveedor)
);

CREATE TABLE resena (
    id_resena    SERIAL PRIMARY KEY,
    id_alumno    INTEGER NOT NULL REFERENCES usuario(id_usuario) ON DELETE CASCADE,
    id_proveedor INTEGER NOT NULL REFERENCES usuario(id_usuario) ON DELETE CASCADE,
    tipo         VARCHAR(20) NOT NULL CHECK (tipo IN ('maestro','escuela')),
    calificacion INTEGER NOT NULL CHECK (calificacion BETWEEN 1 AND 5),
    comentario   TEXT,
    fecha        TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(id_alumno, id_proveedor)
);

CREATE TABLE mensaje_contacto (
    id_mensaje   SERIAL PRIMARY KEY,
    id_alumno    INTEGER NOT NULL REFERENCES usuario(id_usuario) ON DELETE CASCADE,
    id_proveedor INTEGER NOT NULL REFERENCES usuario(id_usuario) ON DELETE CASCADE,
    tipo         VARCHAR(20) NOT NULL,
    asunto       VARCHAR(150),
    mensaje      TEXT NOT NULL,
    fecha        TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    leido        BOOLEAN DEFAULT FALSE
);

-- Indices recomendados para busquedas con filtros
CREATE INDEX IF NOT EXISTS idx_maestro_especialidad ON maestro (LOWER(especialidad));
CREATE INDEX IF NOT EXISTS idx_maestro_precio       ON maestro (precio);
CREATE INDEX IF NOT EXISTS idx_escuela_deporte      ON escuela (LOWER(deporte));
CREATE INDEX IF NOT EXISTS idx_escuela_mensualidad  ON escuela (mensualidad);
CREATE INDEX IF NOT EXISTS idx_favorito_alumno      ON favorito (id_alumno);
CREATE INDEX IF NOT EXISTS idx_resena_proveedor     ON resena (id_proveedor);


