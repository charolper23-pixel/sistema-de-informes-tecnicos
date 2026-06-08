CREATE TABLE roles (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL UNIQUE, -- 'Solicitante', 'Técnico'
    descripcion VARCHAR(255)
);

CREATE TABLE usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    nombre_completo VARCHAR(100) NOT NULL,
    correo VARCHAR(100) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    rol_id INT NOT NULL,
    departamento VARCHAR(100) NOT NULL, -- Área de la institución a la que pertenece
    activo BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (rol_id) REFERENCES roles(id)
);

CREATE TABLE plantillas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL UNIQUE, -- Ej: 'Avería de Hardware'
    descripcion VARCHAR(255),
    activa BOOLEAN DEFAULT TRUE,
    creado_el TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE campos_plantilla (
    id INT AUTO_INCREMENT PRIMARY KEY,
    plantilla_id INT NOT NULL,
    nombre_campo VARCHAR(100) NOT NULL, -- Ej: 'codigo_bien_nacional', 'direccion_ip'
    etiqueta VARCHAR(100) NOT NULL,       -- Ej: 'Código de Bien Nacional', 'Dirección IP'
    tipo_dato VARCHAR(50) NOT NULL,      -- 'text', 'number', 'date', etc. (para renderizado)
    es_obligatorio BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (plantilla_id) REFERENCES plantillas(id) ON DELETE CASCADE
);

CREATE TABLE estados (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL UNIQUE -- 'Pendiente', 'Aprobado'
);

CREATE TABLE informes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    codigo_unico VARCHAR(20) NOT NULL UNIQUE, -- Ej: 'INF-2026-0001' (Para el documento oficial)
    plantilla_id INT NOT NULL,
    solicitante_id INT NOT NULL,
    tecnico_id INT NULL,                      -- NULL mientras esté 'Pendiente'
    estado_id INT NOT NULL,
    creado_el TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    aprobado_el TIMESTAMP NULL,                -- Estampa de tiempo de validación
    solucion_tecnica TEXT NULL,                -- Registro de la solución por el técnico
    FOREIGN KEY (plantilla_id) REFERENCES plantillas(id),
    FOREIGN KEY (solicitante_id) REFERENCES usuarios(id),
    FOREIGN KEY (tecnico_id) REFERENCES usuarios(id),
    FOREIGN KEY (estado_id) REFERENCES estados(id)
);

CREATE TABLE valores_informe (
    id INT AUTO_INCREMENT PRIMARY KEY,
    informe_id INT NOT NULL,
    campo_id INT NOT NULL,
    valor TEXT NOT NULL, -- Almacena la respuesta en texto (flexible para cualquier tipo)
    FOREIGN KEY (informe_id) REFERENCES informes(id) ON DELETE CASCADE,
    FOREIGN KEY (campo_id) REFERENCES campos_plantilla(id),
    UNIQUE KEY unica_respuesta (informe_id, campo_id) -- Evita respuestas duplicadas para un mismo campo
);