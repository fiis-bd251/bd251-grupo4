-- Crear un índice invertido (GIN) sobre la combinación de los campos "contenido" y "condiciones_contrato"
-- Esto permite realizar búsquedas de texto completo de forma eficiente
-- Se usa el diccionario lingüístico en español para considerar palabras base (stemming) y eliminar palabras vacías
CREATE INDEX idx_busqueda_contrato
ON Contrato
USING GIN (to_tsvector('spanish', contenido || ' ' || condiciones_contrato));

-- Realiza una búsqueda de contratos que contengan la palabra "penalidad"
-- Se convierte el texto completo de los campos a formato tsvector (vector de términos)
-- Se compara con una consulta de texto plano ("penalidad") usando plainto_tsquery
-- Devuelve solo los contratos donde aparezca esa palabra en el contenido o condiciones
SELECT nombre_contrato
FROM Contrato
WHERE to_tsvector('spanish', contenido || ' ' || condiciones_contrato)
      @@ plainto_tsquery('spanish', 'penalidad');
