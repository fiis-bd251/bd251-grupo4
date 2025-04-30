-- Eliminación de datos previos
TRUNCATE TABLE solicitud CASCADE;

-- Poblamiento de la tabla Solicitud
COPY solicitud (
  id_solicitud,
  descripcion_solicitud,
  fecha_solicitud,
  fecha_firma,
  id_cliente
)
FROM 'C:\\Users\\usuario\\Desktop\\UNI-FIIS\\2025-I\\DBD\\solicitudes.csv'
WITH (
  FORMAT csv,
  HEADER true,
  DELIMITER ','
);

-- Poblamiento masivo de la tabla  contacto
COPY contacto (
  id_contacto,
  nombre_contacto,
  email_contacto,
  telefono_contacto,
  cargo_contacto,
  origen,
  id_empresa,
  id_ejecutivo_comercial
)
FROM 'C:\\Users\\usuario\\Desktop\\UNI-FIIS\\2025-I\\DBD\\contactos.csv'
WITH (
  FORMAT csv,
  HEADER true,
  DELIMITER ','
);