-- Paso 1: Eliminar la tabla si ya existe
DROP TABLE IF EXISTS Contrato CASCADE;

-- Paso 2: Crear tabla principal particionada por RANGO de fecha_contrato
CREATE TABLE Contrato (
    cod_contrato INT NOT NULL,
    nombre_contrato CHAR(20) NOT NULL,
    monto FLOAT NOT NULL,
    contenido TEXT NOT NULL,
    condiciones_contrato TEXT NOT NULL,
    id_contrato INT NOT NULL,
    fecha_contrato DATE NOT NULL,
    id_version INT NOT NULL,
    id_solicitud VARCHAR(50) NOT NULL,
    -- Clave primaria compuesta requerida para tablas particionadas por fecha
    PRIMARY KEY (id_contrato, fecha_contrato),
    FOREIGN KEY (id_version) REFERENCES Version_contrato (id_version),
    FOREIGN KEY (id_solicitud) REFERENCES Solicitud (id_solicitud)
) PARTITION BY RANGE (fecha_contrato);

-- Paso 3: Crear partición para el año 2025
CREATE TABLE Contrato_2025 PARTITION OF Contrato
FOR VALUES FROM ('2025-01-01') TO ('2026-01-01');

-- Paso 4: Poblar la tabla con 8 contratos
INSERT INTO Contrato (
  cod_contrato, nombre_contrato, monto, contenido, condiciones_contrato,
  id_contrato, fecha_contrato, id_version, id_solicitud
) VALUES
(1001, 'Contrato Agro', 50000.00,
 'Contrato de desarrollo web con panel administrativo. Se detalla arquitectura de tres capas y entregables en fases.',
 'Penalidad del 1% por cada día de retraso en entregas. Garantía de 6 meses incluida.',
 1, '2025-04-16', 1, 'SOL001'),

(1002, 'Contrato La plata', 75000.00,
 'Contrato para implementación de ERP con módulos de contabilidad y logística. Incluye capacitación al personal.',
 'Se requiere cumplir con el cronograma. La capacitación debe cubrir al 100% del personal.',
 2, '2025-04-17', 2, 'SOL002'),

(1003, 'Contrato Arequipa', 60000.00,
 'Contrato de soporte técnico remoto y monitoreo 24/7 para infraestructura en la nube.',
 'Tiempo de respuesta máximo: 6 horas. Penalidades aplicables por interrupciones superiores a 1 hora.',
 3, '2025-04-18', 3, 'SOL003'),

(1004, 'Contrato Paso firme', 82000.00,
 'Contrato para la implementación de una solución BI con dashboards en tiempo real y alertas automáticas.',
 'El proveedor debe entregar acceso a reportes interactivos y documentación técnica completa.',
 4, '2025-04-19', 4, 'SOL004'),

(1005, 'Contrato Plata', 45000.00,
 'Contrato de licenciamiento anual para plataforma de gestión de proyectos con integración a Microsoft Teams.',
 'La renovación es automática salvo aviso previo. Soporte incluido por 12 meses.',
 5, '2025-04-20', 5, 'SOL005'),

(1006, 'Contrato Free man', 90000.00,
 'Contrato de consultoría en ciberseguridad con evaluaciones periódicas de vulnerabilidades.',
 'Debe entregarse un informe técnico mensual. Penalidad del 3% si no se cumple el calendario.',
 6, '2025-04-21', 6, 'SOL006'),

(1007, 'Contrato Gman', 68000.00,
 'Desarrollo de app móvil con funcionalidades offline, sincronización de datos y escaneo de QR.',
 'Entrega en tres sprints. Cada módulo debe ser validado por el cliente antes del despliegue.',
 7, '2025-04-22', 7, 'SOL007'),

(1008, 'Contrato Holijo', 72000.00,
 'Desarrollo de chatbot con integración a WhatsApp y motor de IA entrenado en preguntas frecuentes.',
 'La solución debe ser escalable. Se evaluará la precisión de respuestas con métricas mensuales.',
 8, '2025-04-23', 8, 'SOL008');

-- (Opcional) Consulta que activará solo la partición 2025
-- SELECT * FROM Contrato WHERE fecha_contrato BETWEEN '2025-04-01' AND '2025-04-30';
