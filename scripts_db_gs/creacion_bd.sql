TRUNCATE TABLE solicitud CASCADE;

-- Carga masiva de datos desde el archivo 'solicitudes.csv'
-- ubicado en la ruta local especificada
COPY solicitud (
  id_solicitud,
  descripcion_solicitud,
  fecha_solicitud,
  fecha_firma,
  id_cliente
)
FROM 'C:/Users/usuario/Desktop/UNI-FIIS/2025-I/DBD/solicitudes.csv'
DELIMITER ','
CSV HEADER;
