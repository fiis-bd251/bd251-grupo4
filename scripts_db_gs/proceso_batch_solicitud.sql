-- Agrega una nueva columna llamada "estado_batch" a la tabla Solicitud.
-- Esta columna servirá para registrar estados generados automáticamente por procesos batch.
ALTER TABLE Solicitud ADD COLUMN estado_batch VARCHAR(20);

-- Proceso batch: actualiza en bloque todas las solicitudes que fueron registradas hace más de 60 días.
-- El objetivo es marcarlas como "cerrada_automatica" si aún no tienen atención explícita (según la lógica del sistema).
-- Esta lógica puede ejecutarse periódicamente para mantener actualizada la tabla.
UPDATE Solicitud
SET estado_batch = 'cerrada_automatica'
WHERE fecha_solicitud < CURRENT_DATE - INTERVAL '60 days';
