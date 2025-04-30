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
