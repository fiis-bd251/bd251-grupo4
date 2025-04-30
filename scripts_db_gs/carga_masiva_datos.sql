--- Eliminación de datos anteriores ---
    DO $$ DECLARE
        row RECORD;
    BEGIN
        FOR row IN
            SELECT tablename
            FROM pg_tables
            WHERE schemaname = 'public'
        LOOP
            EXECUTE 'TRUNCATE TABLE ' || quote_ident(row.tablename) || ' CASCADE';
        END LOOP;
    END $$;

    -- Poblamiento de Cliente (10 filas)
INSERT INTO Cliente (
  id_cliente, direccion, nombre, cant_contratos, num_ruc,
  fecha_primera_compra, id_usuario, id_satisfaccion, id_empresa, id_respuesta_
) VALUES
  (1,  'Av. Lima 123',   'CarlosR', 2, 201234567, '2024-05-10', 1, 5, 1, 1),
  (2,  'Calle Roja 45',  'AnaV',    1, 204567890, '2024-06-15', 2, 4, 2, 2),
  (3,  'Jr. Paz 789',    'LuisT',   3, 207654321, '2024-07-20', 3, 6, 3, 3),
  (4,  'Av. Grau 56',    'SofiaG',  1, 209876543, '2024-08-25', 4, 7, 4, 4),
  (5,  'Calle Sol 12',   'MiguelH', 2, 202345678, '2024-09-30', 5, 8, 5, 5),
  (6,  'Jr. Luna 34',    'ElenaF',  1, 205678901, '2024-10-05', 6, 5, 6, 6),
  (7,  'Av. Rey 78',     'DavidM',  4, 208901234, '2024-11-10', 7, 6, 7, 7),
  (8,  'Calle Mar 90',   'LauraR',  2, 203456789, '2024-12-15', 8, 7, 8, 8),
  (9,  'Jr. Sol 21',     'JorgeS',  1, 206789012, '2025-01-20', 9, 4, 9, 9),
  (10, 'Av. Andes 11',   'MariaP',  3, 200123456, '2025-02-25',10, 5,10,10);

  copy solicitud (
  id_solicitud,
  descripción_solicitud,
  fecha_solicitud,
  fecha_firma,
  id_cliente
)
 -- Poblamiento de la Solicitudes
FROM 'C:/Users/usuario/Desktop/UNI-FIIS/2025-I/DBD/solicitudes.csv'
DELIMITER ','
CSV HEADER;
