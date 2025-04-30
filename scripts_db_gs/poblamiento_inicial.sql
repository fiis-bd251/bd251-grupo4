--- Eliminación de datos anteriores ---
DO $$ 
DECLARE
    row RECORD;
    seq RECORD;
BEGIN
    -- Truncar todas las tablas en el esquema 'public'
    FOR row IN
        SELECT tablename
        FROM pg_tables
        WHERE schemaname = 'public'
    LOOP
        EXECUTE 'TRUNCATE TABLE ' || quote_ident(row.tablename) || ' CASCADE';
    END LOOP;

    -- Reiniciar las secuencias asociadas
    FOR seq IN
        SELECT c.oid::regclass::text AS sequence_name
        FROM pg_class c
        JOIN pg_namespace n ON n.oid = c.relnamespace
        WHERE c.relkind = 'S' -- 'S' indica que es una secuencia
          AND n.nspname = 'public'
    LOOP
        EXECUTE 'ALTER SEQUENCE ' || quote_ident(seq.sequence_name) || ' RESTART WITH 1';
    END LOOP;
END $$;

-- Poblamiento de Rol (12 filas)
INSERT INTO Rol (id_rol, nombre_rol, descripción) VALUES
  (1,  'ADMIN',         'Administrador del sistema'),
  (2,  'USUARIO',       'Usuario estándar'),
  (3,  'SUPERVISOR',    'Supervisor de ventas'),
  (4,  'GERENTE',       'Gerente de proyectos'),
  (5,  'AUDITOR',       'Auditor interno'),
  (6,  'ANALISTA',      'Analista de datos'),
  (7,  'DESARROLLADOR', 'Desarrollador de software'),
  (8,  'QA',            'Ingeniero de calidad'),
  (9,  'DBA',           'Admin bases de datos'),
  (10, 'MARKETING',     'Especialista en marketing'),
  (11, 'RRHH',          'Recursos Humanos'),
  (12, 'SOPORTE',       'Soporte técnico');

-- Poblamiento de Usuario (12 filas)
INSERT INTO Usuario (id_usuario, contraseña, correo, user_name, id_rol) VALUES
  (1,  'Passw0rd!23',    'jsmith@empresa.com',    'jsmith',    1),
  (2,  'Qwerty2025',      'adoe@empresa.com',      'adoe',      2),
  (3,  'V3ntas$ales',     'bmorales@empresa.com',  'bmorales',  3),
  (4,  'Gerente#01',      'ccastro@empresa.com',   'ccastro',   4),
  (5,  'Audit2025!',      'dluna@empresa.com',     'dluna',     5),
  (6,  'Data@1234',       'efernandez@empresa.com','efernandez',6),
  (7,  'DevOps_789',      'fgarcia@empresa.com',   'fgarcia',   7),
  (8,  'Test!nG456',      'hmartinez@empresa.com', 'hmartinez', 8),
  (9,  'DBAaccess99',     'ijimenez@empresa.com',  'ijimenez',  9),
  (10, 'Market#2025',     'jkhan@empresa.com',     'jkhan',     10),
  (11, 'RRHH@hire1',      'lrodriguez@empresa.com','lrodriguez',11),
  (12, 'Support_321',     'msanchez@empresa.com',  'msanchez',  12);

-- Poblamiento de Version_contrato (12 filas)
INSERT INTO Version_contrato (id_version, version, fecha_version, cambios) VALUES
  (1,  'v1.0',  '2025-01-10', 'Versión inicial del contrato'),
  (2,  'v1.1',  '2025-01-12', 'Ajustes en cláusulas de pago'),
  (3,  'v1.2',  '2025-01-15', 'Actualización de plazos de entrega'),
  (4,  'v1.3',  '2025-01-18', 'Incorporación de penalidades'),
  (5,  'v1.4',  '2025-01-20', 'Revisión de confidencialidad'),
  (6,  'v2.0',  '2025-02-01', 'Revisión mayor con anexos'),
  (7,  'v2.1',  '2025-02-05', 'Modificación de alcance'),
  (8,  'v2.2',  '2025-02-08', 'Actualización de costos'),
  (9,  'v2.3',  '2025-02-11', 'Inclusión de soporte'),
  (10, 'v2.4',  '2025-02-14', 'Ajuste responsabilidades'),
  (11, 'v2.5',  '2025-02-17', 'Corrección de errores'),
  (12, 'v3.0',  '2025-02-20', 'Versión final aprobada');

-- Poblamiento de Comentario corregido (12 filas)
INSERT INTO Comentario (id_comentario,fecha_comentario,texto_comentario,id_origen,tipo_origen,estado,id_usuario,id_comentario_padre) VALUES
  (1,  '2025-02-10', 'El cliente solicita claridad en el cronograma.',               1001, 'Proyecto',          'A',  4, 1),
  (2,  '2025-02-11', 'He subido el documento de requisitos corregido.',             2001, 'Requisitos',        'A',  6, 2),
  (3,  '2025-02-12', 'Revisar la sección de viabilidad técnica antes del envío.',   2001, 'Requisitos',        'R',  3, 3),
  (4,  '2025-02-13', 'Se aprueba la versión v1.2 con los ajustes acordados.',        1,    'Version',           'A',  5, 4),
  (5,  '2025-02-14', 'Definir hitos de entrega para el próximo sprint.',             1001, 'Proyecto',          'A',  2, 5),
  (6,  '2025-02-15', 'Asignado a QA para validación final.',                        3001, 'Orden_compra',      'A',  8, 6),
  (7,  '2025-02-16', 'Presupuesto supera lo acordado, revisar cifras.',              4001, 'Propuesta',         'R', 11, 7),
  (8,  '2025-02-17', 'Ajustaremos el presupuesto según nuevos requisitos.',          4001, 'Propuesta',         'A',  4, 7),
  (9,  '2025-02-18', '¿Quién se encargará del seguimiento de esta tarea?',           1001, 'Proyecto',          'A',  9, 9),
  (10, '2025-02-19', 'Entregable recibido y validado sin observaciones.',            5001, 'Entregable_exp',    'A', 12,10),
  (11, '2025-02-20', 'Comentarios al informe de auditoría, ver sección financiera.',  5001, 'Auditoría',         'A',  5,11),
  (12, '2025-02-21', 'Re: Informe financiero, faltan datos de flujo de caja.',        5001, 'Auditoría',         'R',  6,12);

-- Poblamiento de Documento (12 filas)
INSERT INTO Documento (id_documento, tipo_doc, fecha_generacion) VALUES
  (1,  'Requisito          ', '2025-03-01'),
  (2,  'Contrato           ', '2025-03-02'),
  (3,  'Factura            ', '2025-03-03'),
  (4,  'Acta               ', '2025-03-04'),
  (5,  'Memorando          ', '2025-03-05'),
  (6,  'Especificación     ', '2025-03-06'),
  (7,  'Manual Usuario     ', '2025-03-07'),
  (8,  'Informe Técnico    ', '2025-03-08'),
  (9,  'Plan de Proyecto   ', '2025-03-09'),
  (10, 'Política Calidad   ', '2025-03-10'),
  (11, 'Propuesta Servicio ', '2025-03-11'),
  (12, 'Acta Entrega       ', '2025-03-12');

-- Poblamiento de Estado_oc (12 filas)
INSERT INTO Estado_oc (cod_estado_oc, nombre_estado_oc, descripción_estado_oc) VALUES
  (1,  'Pendiente',   'Esperando aprobación'),
  (2,  'Aprobado',    'Orden de compra aprobada'),
  (3,  'Rechazado',   'Orden de compra rechazada'),
  (4,  'Enviado',     'Enviado al proveedor'),
  (5,  'Recibido',    'Material recibido'),
  (6,  'Procesado',   'Procesamiento interno'),
  (7,  'Cancelado',   'Orden cancelada'),
  (8,  'Facturado',   'Factura generada'),
  (9,  'Pagado',      'Pago completado'),
  (10, 'Devuelto',    'Material devuelto'),
  (11, 'Archivado',   'Registro archivado'),
  (12, 'Reabierto',   'Orden reabierta');

-- Poblamiento de Categoria_servicios (12 filas)
INSERT INTO Categoria_servicios (cod_categoria, nombre_categoria) VALUES
  ('CAT01', 'Consultoría   '),
  ('CAT02', 'Desarrollo    '),
  ('CAT03', 'Implementación'),
  ('CAT04', 'Soporte       '),
  ('CAT05', 'Mantenimiento '),
  ('CAT06', 'Capacitación  '),
  ('CAT07', 'Auditoría     '),
  ('CAT08', 'Integración   '),
  ('CAT09', 'Migración     '),
  ('CAT10', 'Optimización  '),
  ('CAT11', 'Testing       '),
  ('CAT12', 'Documentación ');

-- Poblamiento de Especialidad_equipo (12 filas)
INSERT INTO Especialidad_equipo (cod_especialidad, nombre_especialidad) VALUES
  (1,  'Hardware      '),
  (2,  'Software      '),
  (3,  'Redes         '),
  (4,  'Seguridad     '),
  (5,  'BaseDatos     '),
  (6,  'Infraestructura'),
  (7,  'DevOps        '),
  (8,  'QA            '),
  (9,  'UI/UX         '),
  (10, 'Movilidad     '),
  (11, 'BI            '),
  (12, 'IoT           ');

-- Poblamiento de Satisfacción (12 filas)
INSERT INTO Satisfacción (id_satisfaccion, nombre_satisfaccion, puntuacion) VALUES
  (1,  'Muy Baja         ',  1),
  (2,  'Baja             ',  2),
  (3,  'Media Baja       ',  3),
  (4,  'Neutral          ',  4),
  (5,  'Media Alta       ',  5),
  (6,  'Alta             ',  6),
  (7,  'Muy Alta         ',  7),
  (8,  'Excelente        ',  8),
  (9,  'Pobre            ',  2),
  (10,'Regular          ',  4),
  (11,'Buena            ',  6),
  (12,'Óptima           ', 10);

-- Poblamiento de Tipo_convocatoria (10 filas)
INSERT INTO Tipo_convocatoria (cod_tipo_convocatoria, tipo_convocatoria) VALUES
  (1, 'Licitacion'),
  (2, 'Concurso'),
  (3, 'Oferta'),
  (4, 'RFP'),
  (5, 'RFQ'),
  (6, 'Subasta'),
  (7, 'Directa'),
  (8, 'Interna'),
  (9, 'Externa'),
  (10,'Mixta');

-- Poblamiento de Validacion_presupuesto (10 filas)
INSERT INTO Validacion_presupuesto (id_validacion_presupuesto, fecha_validacion, estado_validacion, id_comentario) VALUES
  (1, '2025-02-12', 'AP',  3),
  (2, '2025-02-13', 'PD',  4),
  (3, '2025-02-14', 'PD',  5),
  (4, '2025-02-15', 'PD',  6),
  (5, '2025-02-16', 'AP',  7),
  (6, '2025-02-17', 'AP',  8),
  (7, '2025-02-18', 'PD',  9),
  (8, '2025-02-19', 'PD', 10),
  (9, '2025-02-20', 'AP', 11),
  (10,'2025-02-21', 'PD', 12);

-- Poblamiento de Sector_Mercado (10 filas)
INSERT INTO Sector_Mercado (cod_sector, nombre_sector) VALUES
  (1, 'Tecnologia'),
  (2, 'Salud'),
  (3, 'Educacion'),
  (4, 'Finanzas'),
  (5, 'Manufactura'),
  (6, 'Retail'),
  (7, 'Energia'),
  (8, 'Transporte'),
  (9, 'Construccion'),
  (10,'Agropecuario');
  
-- Poblamiento de Detalle_presupuesto (10 filas)
INSERT INTO Detalle_presupuesto (id_detalle, concepto, costo_total, mes) VALUES
  (1,  'Desarrollo software',            15000.00, '2025-03-01'),
  (2,  'Licencias de sistema',           5000.50,  '2025-03-01'),
  (3,  'Consultoria externa',            8000.00,  '2025-03-01'),
  (4,  'Infraestructura cloud',          12000.75, '2025-03-01'),
  (5,  'Capacitacion equipo',            3000.00,  '2025-03-01'),
  (6,  'Mantenimiento hardware',         2500.25,  '2025-03-01'),
  (7,  'Pruebas de calidad',             4000.00,  '2025-03-01'),
  (8,  'Implementacion seguridad',       6000.00,  '2025-03-01'),
  (9,  'Documentacion tecnica',          2000.00,  '2025-03-01'),
  (10, 'Soporte post-produccion',        4500.00,  '2025-03-01');

-- Poblamiento de Recurso_asignado (10 filas)
INSERT INTO Recurso_asignado (id_recurso, costo_total, meses, tarifa, rol_tecnico, horas) VALUES
  (1,  12000.00, 6, 2000.00, 'DT', 160),
  (2,  9000.00,  3, 3000.00, 'QA', 120),
  (3,  8000.00,  4, 2000.00, 'QA', 160),
  (4,  15000.00, 5, 3000.00, 'DA', 200),
  (5,  7000.00,  2, 3500.00, 'QA',  80),
  (6,  10000.00, 4, 2500.00, 'PM', 160),
  (7,  11000.00, 5, 2200.00, 'QA',  200),
  (8,  6000.00,  3, 2000.00, 'QA',  120),
  (9,  13000.00, 6, 2166.67, 'DT', 160),
  (10, 5000.00,  1, 5000.00, 'PM',  40);

-- Poblamiento de Modulo (10 filas)
INSERT INTO Modulo (id_modulo, nombre, descripcion, recursos, dependencias, funciones) VALUES
  (1, 'Autenticacion',        'Gestión de login',              '1,2',    '',                'Valida credenciales y genera token'),
  (2, 'Usuarios',            'CRUD de usuarios',              '2,3',    '1',               'Crear, leer, actualizar y eliminar usuarios'),
  (3, 'Proyectos',           'Administración de proyectos',   '1,6,7',  '2',               'Definir y gestionar proyectos'),
  (4, 'Presupuestos',        'Gestión de presupuestos',       '4,5,8',  '3',               'Calcular y validar presupuestos'),
  (5, 'Reportes',            'Generación de reportes',        '3,6',    '2,4',             'Exportar datos en PDF y Excel'),
  (6, 'Notificaciones',      'Envía alertas y correos',       '8',      '2',               'Enviar emails y notificaciones push'),
  (7, 'Dashboard',           'Vista de KPIs',                 '5,9',    '3,4,5',           'Mostrar métricas y gráficos'),
  (8, 'Configuracion',       'Ajustes del sistema',           '2,6',    '',                'Modificar parámetros de la aplicación'),
  (9, 'Auditoria',           'Registro de acciones',          '3,7',    '2',               'Log de eventos y cambios'),
  (10,'IntegracionAPI',      'Conexión con servicios externos','1,4,9', '1,3',             'Consumir y exponer APIs REST');

-- Poblamiento de Hito (10 filas)
INSERT INTO Hito (id_hito, nombre, descripcion, fecha, orden) VALUES
  (1,  'Inicio',      'Inicial',   '2025-03-01', 1),
  (2,  'Análisis',    'Analisis',  '2025-03-10', 2),
  (3,  'Diseño',      'Diseño',    '2025-03-20', 3),
  (4,  'Desarrollo',  'Desarrollo','2025-04-01', 4),
  (5,  'Pruebas',     'Pruebas',   '2025-04-15', 5),
  (6,  'Revisión',    'Revision',  '2025-04-25', 6),
  (7,  'Implement.',  'Implement', '2025-05-05', 7),
  (8,  'Despliegue',  'Despliegue','2025-05-15', 8),
  (9,  'Cierre',      'Cierre',    '2025-05-20', 9),
  (10, 'Evaluación',  'Eval',      '2025-05-30', 10);

-- Poblamiento de Presupuesto_propuesta (10 filas)
INSERT INTO Presupuesto_propuesta
  (id_presupuesto, costo_total, fecha_elaboracion, id_validacion_presupuesto, id_detalle, id_recurso, id_documento) VALUES
  (1,  42000.00, '2025-03-15', 1, 1, 1, 1),
  (2,  38000.50, '2025-03-16', 2, 2, 2, 2),
  (3,  25000.00, '2025-03-17', 3, 3, 3, 3),
  (4,  48000.75, '2025-03-18', 4, 4, 4, 4),
  (5,  18000.00, '2025-03-19', 5, 5, 5, 5),
  (6,  30000.25, '2025-03-20', 6, 6, 6, 6),
  (7,  33000.00, '2025-03-21', 7, 7, 7, 7),
  (8,  15000.00, '2025-03-22', 8, 8, 8, 8),
  (9,  56000.00, '2025-03-23', 9, 9, 9, 9),
  (10, 21000.00, '2025-03-24', 10, 10, 10, 10);

-- Poblamiento de Respuesta_cliente (10 filas)
INSERT INTO Respuesta_cliente (id_respuesta_, tipo_respuesta, comentarios, fecha_respuesta) VALUES
  (1,  'A', 'Aceptamos la propuesta sin modificaciones.',           '2025-03-25'),
  (2,  'R', 'Requerimos un ajuste en los plazos de entrega.',      '2025-03-26'),
  (3,  'R', '¿Podrían detallar el desglose de costos adicional?',   '2025-03-27'),
  (4,  'A', 'Confirmamos inicio de proyecto según lo acordado.',   '2025-03-28'),
  (5,  'R', 'No aprobamos la alternativa técnica presentada.',      '2025-03-29'),
  (6,  'A', 'Solicitamos reunion para revisar opciones comerciales.','2025-03-30'),
  (7,  'A', 'Aprobamos la opción de descuento por pronto pago.',    '2025-03-31'),
  (8,  'R', 'Rechazamos la propuesta de recursos adicional.',       '2025-04-01'),
  (9,  'A', '¿Cuál es el impacto en costos si extendemos el plazo?','2025-04-02'),
  (10, 'R', 'Aceptamos la versión final del contrato.',             '2025-04-03');

-- Poblamiento de Alternativas (10 filas)
INSERT INTO Alternativas (
  id_alternativa, tipo_alternativa, descripcion_alternativa,
  costo_estimado_requerimiento, tiempo_extra_requerido,
  fecha_propuesta_a, fecha_aprobacion_cliente_a
) VALUES
  (1,  'Técnica',    'Uso de arquitectura microservicios',        12000.00, 2.5, '2025-03-20', '2025-03-22'),
  (2,  'Económica',  'Reducción de alcance para disminuir costo',  8000.00, 1.0, '2025-03-21', '2025-03-23'),
  (3,  'Tiempo',     'Ampliación de cronograma en 2 semanas',      5000.00, 2.0, '2025-03-22', '2025-03-24'),
  (4,  'Recursos',   'Asignar equipo adicional de QA',             7000.00, 1.5, '2025-03-23', '2025-03-25'),
  (5,  'Alcance',    'Eliminar módulo de reportes avanzados',      6000.00, 1.0, '2025-03-24', '2025-03-26'),
  (6,  'Seguridad',  'Implementar cifrado de datos en tránsito',  9000.00, 1.2, '2025-03-25', '2025-03-27'),
  (7,  'Infraestr',  'Migración a nube privada',                 15000.00,3.0, '2025-03-26', '2025-03-28'),
  (8,  'Soporte',    'Contrato de soporte extendido 24/7',        4000.00, 0.5, '2025-03-27', '2025-03-29'),
  (9,  'Capacitación','Training para el equipo interno',           3000.00, 0.8, '2025-03-28', '2025-03-30'),
  (10, 'Optimización','Tuning de base de datos para rendimiento',  8500.00, 1.5, '2025-03-29', '2025-03-31');

-- Poblamiento de Opciones_comerciales (10 filas)
-- Opciones_comerciales corregido para CHAR(8) y VARCHAR(20)
INSERT INTO Opciones_comerciales (id_opciones_comerciales, tipo_opcion, detalle_opcion,impacto_plazo, nueva_estimacion_costo,fecha_propuesta_o, fecha_aprobacion_cliente_o) VALUES
  (1, 'DESCUENT', '5% pronto pago',       'SinCambio',  95000.00, '2025-03-20', '2025-03-22'),
  (2, 'BUNDLE',   'Soporte extra',        '1semana',    98000.00, '2025-03-21', '2025-03-23'),
  (3, 'FINANCI',  'Pago 3 cuotas',        'SinCambio', 100000.00, '2025-03-22', '2025-03-24'),
  (4, 'ADDON',    'Módulo analítica',     '2semanas',  105000.00, '2025-03-23', '2025-03-25'),
  (5, 'TRIAL',    '1 mes gratis',         'SinCambio',  90000.00, '2025-03-24', '2025-03-26'),
  (6, 'UPGRADE',  'Versión pro',          '1semana',   110000.00, '2025-03-25', '2025-03-27'),
  (7, 'PROMO',    '10% descuento',        'SinCambio',  90000.00, '2025-03-26', '2025-03-28'),
  (8, 'LEASE',    'Arrendam. equipo',     '2semanas',  120000.00, '2025-03-27', '2025-03-29'),
  (9, 'SERVICE',  'Mantenimiento',        'SinCambio',  95000.00, '2025-03-28', '2025-03-30'),
  (10,'PARTNER',  'Socio tecnológico',     'SinCambio', 130000.00, '2025-03-29', '2025-03-31');


-- Poblamiento de Personal_asignado (10 filas)
INSERT INTO Personal_asignado (
  id_personal_asignado, nombre_personal, telefono__personal,
  disponibilidad_personal, fecha_asignacion, id_rol
) VALUES
  (1,  'Juan Pérez',    987654321, 'Tiempo Completo', '2025-02-01', 7),
  (2,  'María López',   912345678, 'Medio Tiempo',    '2025-02-05', 8),
  (3,  'Carlos Ruiz',   999888777, 'Tiempo Completo', '2025-02-10', 3),
  (4,  'Ana Gómez',     976543210, 'Contrato',        '2025-02-15', 4),
  (5,  'Luis Fernández',965432100, 'Tiempo Completo', '2025-02-20', 6),
  (6,  'Sofía Castillo',954321098, 'Medio Tiempo',    '2025-02-25', 2),
  (7,  'Miguel Torres', 943210987, 'Tiempo Completo', '2025-03-01', 1),
  (8,  'Elena Rivas',   932109876, 'Contrato',        '2025-03-05', 5),
  (9,  'David Medina',  921098765, 'Medio Tiempo',    '2025-03-10', 9),
  (10, 'Laura Reyes',   910987654, 'Tiempo Completo', '2025-03-15', 11);

-- Poblamiento de Catálogo_servicios (10 filas)
INSERT INTO Cátalogo_servicios (id_servicio, nombre, cod_categoria) VALUES
  (1,  'Consultoría TI     ', 'CAT01'),
  (2,  'Desarrollo Web     ', 'CAT02'),
  (3,  'Migración Datos    ', 'CAT09'),
  (4,  'Soporte Nube       ', 'CAT04'),
  (5,  'Mantenimiento SW   ', 'CAT05'),
  (6,  'Capacitación UX    ', 'CAT06'),
  (7,  'Auditoría Seguridad','CAT07'),
  (8,  'Integración API    ', 'CAT08'),
  (9,  'Optimización SQL   ', 'CAT10'),
  (10, 'Testing Automatizado','CAT11');

-- Poblamiento de Empresa (10 filas)
INSERT INTO Empresa (id_empresa, nombre_empresa, tamano_empresa, telefono_empresa, web_corporativa, ranklng, cod_sector) VALUES
  (1,  'TechSol Ltd.       ', 150,  987654321, 'techsol.com',    5, 1),
  (2,  'SaludPlus S.A.     ',  80,  912345678, 'saludplus.pe',   4, 2),
  (3,  'EducaGlobal        ', 200,  976543210, 'educaglobal.edu',3, 3),
  (4,  'FinanCorp          ', 120,  965432100, 'financorp.com',  2, 4),
  (5,  'ManuFacto          ', 300,  954321098, 'manufacto.org',  6, 5),
  (6,  'RetailMart         ', 250,  943210987, 'retailmart.pe',  3, 6),
  (7,  'EnergiaVerde       ', 180,  932109876, 'enverde.com',    7, 7),
  (8,  'TransLogistics     ', 220,  921098765, 'translog.pe',    8, 8),
  (9,  'Constructiva       ',  90,  910987654, 'constructiva.com',9, 9),
  (10, 'AgroInnovacion     ', 140,  901234567, 'agroinnov.pe',   1, 10);

-- Poblamiento de Solicitud_web (10 filas) con estados válidos
INSERT INTO Solicitud_web (
  id_solicitud_web, nombre_solicitante, apellido_solicitante,
  telefono_solicitante, correo_solicitante, fecha_envio,
  estado_solicitud, id_empresa
) VALUES
  (1,  'Carlos',   'Ramirez',  987650001, 'carlossol.com',   '2025-04-01', 'pendiente', 1),
  (2,  'Ana',      'Vargas',   987650002, 'anludplus.pe',     '2025-04-02', 'contestada',  2),
  (3,  'Luis',     'Torres',   987650003, 'luisaglobal.edu', '2025-04-03', 'pendiente', 3),
  (4,  'Sofía',    'Gonzales', 987650004, 'sofiancorp.com',  '2025-04-04', 'revisada', 4),
  (5,  'Miguel',   'Herrera',  987650005, 'miguenufacto.org', '2025-04-05', 'pendiente', 5),
  (6,  'Elena',    'Flores',   987650006, 'elenailmart.pe',  '2025-04-06', 'contestada',  6),
  (7,  'David',    'Martínez', 987650007, 'david@rde.com',    '2025-04-07', 'pendiente', 7),
  (8,  'Laura',    'Reyes',    987650008, 'lauraslog.pe',    '2025-04-08', 'contestada',  8),
  (9,  'Jorge',    'Salinas',  987650009, 'jorgstructiva.com','2025-04-09', 'revisada', 9),
  (10, 'María',    'Paredes',  987650010, 'marioinnov.pe',   '2025-04-10', 'pendiente', 10);

-- Poblamiento de Asignación_recurso (10 filas)
INSERT INTO Asignación_recurso (
  id_asignacion_r, descripcion, fecha_asignacion,
  duracion, id_personal_asignado
) VALUES
  (1,  'Implementación módulo Auth', '2025-04-01', 15.5, 1),
  (2,  'Desarrollo API usuario',     '2025-04-02', 10.0, 2),
  (3,  'Pruebas módulo Proyectos',   '2025-04-03',  8.0, 3),
  (4,  'Configuración servidor',      '2025-04-04', 12.0, 4),
  (5,  'Capacitación equipo QA',     '2025-04-05',  5.0, 5),
  (6,  'Migración base de datos',    '2025-04-06', 20.0, 6),
  (7,  'Despliegue en producción',   '2025-04-07',  6.0, 7),
  (8,  'Análisis de seguridad',      '2025-04-08',  9.0, 8),
  (9,  'Optimización consultas',     '2025-04-09', 11.0, 9),
  (10, 'Documentación técnica',      '2025-04-10',  7.0, 10);

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

-- Poblamiento de Requisitos (10 filas)
INSERT INTO Requisitos (
  id_requisitos, descripcion_r, prioridad_requisito,
  fecha_registro, estado_r, historial_cambios, fecha_actualizacion, id_cliente
) VALUES
  (1,  'Login seguro',         1, '2025-03-01', 'PENDITE', 'v1.0→v1.1', '2025-03-02', 1),
  (2,  'Reporte ventas',       2, '2025-03-03', 'EN PROGR',   'v1.1→v1.2', '2025-03-04', 2),
  (3,  'API clientes',         1, '2025-03-05', 'COMPLETO',   'v1.0→v1.1', '2025-03-06', 3),
  (4,  'Dashboard KPIs',       3, '2025-03-07', 'PENENTE',  'v1.2→v1.3', '2025-03-08', 4),
  (5,  'Notificaciones email', 2, '2025-03-09', 'EN PROGR',   'v1.1→v1.2', '2025-03-10', 5),
  (6,  'Backup BD',            1, '2025-03-11', 'COMPLETO',   'v1.0→v1.1', '2025-03-12', 6),
  (7,  'Integración pago',     2, '2025-03-13', 'PENDITE',  'v1.2→v1.3', '2025-03-14', 7),
  (8,  'Módulo usuarios',      1, '2025-03-15', 'EN PROGR',   'v1.1→v1.2', '2025-03-16', 8),
  (9,  'Seguridad API',        1, '2025-03-17', 'PEIENTE',  'v1.0→v1.1', '2025-03-18', 9),
  (10, 'Soporte móvil',        3, '2025-03-19', 'EN PROGR',   'v1.2→v1.3', '2025-03-20',10);

-- Poblamiento de Revisión_de_requisitos (10 filas)
INSERT INTO Revisión_de_requisitos (
  id_revision_r, fecha_revision_requisitos, medio_de_aclaracion,
  nombre_revisor, estado_requisitos, feedback_cliente,
  propuesta_modificada_, id_requisitos
) VALUES
  (1,  '2025-03-05', 'Email',    'rev001', 'APROBADO', 'Ok para seguir',        'Ninguna',      1),
  (2,  '2025-03-07', 'Reunión',  'rev002', 'RECHAZO','Falta detalle',         'Agregar campos',2),
  (3,  '2025-03-09', 'Chat',     'rev003', 'APROBADO', 'Correcto',              'Ninguna',      3),
  (4,  '2025-03-11', 'Email',    'rev004', 'EN PROGR', 'Revisar diseño',        'Actualizar UI',4),
  (5,  '2025-03-13', 'Reunión',  'rev005', 'APROBADO', 'Bien definido',         'Ninguna',      5),
  (6,  '2025-03-15', 'Chat',     'rev006', 'COMPLETO', 'Listo para producción', 'Ninguna',      6),
  (7,  '2025-03-17', 'Email',    'rev007', 'RECHADO','No cumple SLA',         'Ajustar tiempos',7),
  (8,  '2025-03-19', 'Reunión',  'rev008', 'EN PROGR', 'Falta prueba',          'Agregar tests',8),
  (9,  '2025-03-21', 'Chat',     'rev009', 'APROBADO', 'Ok seguridad',          'Ninguna',      9),
  (10, '2025-03-23', 'Email',    'rev010', 'EN PROGR', 'Revisar documentación', 'Completar doc',10);

-- Poblamiento de Trazabilidad (10 filas)
INSERT INTO Trazabilidad (id_trazabilidad, tipo_evento, fecha_evento,descripción_evento, id_requisitos, id_usuario) VALUES
  (1, 101, '2025-03-02', 'Req creado',                1, 1),
  (2, 102, '2025-03-04', 'Revisión inicial',          2, 2),
  (3, 103, '2025-03-06', 'Aprobación técnica',        3, 3),
  (4, 104, '2025-03-08', 'Feedback cliente',          4, 4),
  (5, 105, '2025-03-10', 'Modificación req',          5, 5),
  (6, 106, '2025-03-12', 'Pruebas unitarias',         6, 6),
  (7, 107, '2025-03-14', 'Ajuste seguridad',          7, 7),
  (8, 108, '2025-03-16', 'Revisión final',            8, 8),
  (9, 109, '2025-03-18', 'Documentación generada',     9, 9),
  (10,110, '2025-03-20', 'Cierre requisito',          10,10);

  -- Poblamiento de Viabilidad_tecnica_requisitos (8 filas)
INSERT INTO Viabilidad_tecnica_requisitos (id_viabilidad_r, notas, fecha_evaluacion, resultado_viabilidad,id_requisitos, id_personal_asignado, id_alternativa, id_documento) VALUES
  (1, 'Arquitectura SÓlida',       '2025-04-01', 'Viable',      1, 1, 1, 1),
  (2, 'Falta detalle DB',         '2025-04-02', 'No viable',   2, 2, 2, 2),
  (3, 'Performance OK',           '2025-04-03', 'Viable',      3, 3, 3, 3),
  (4, 'Requiere pruebas extra',   '2025-04-04', 'Pendiente',   4, 4, 4, 4),
  (5, 'Seguridad adecuada',       '2025-04-05', 'Viable',      5, 5, 5, 5),
  (6, 'Integración fallida',      '2025-04-06', 'No viable',   6, 6, 6, 6),
  (7, 'Dependencias ok',          '2025-04-07', 'Viable',      7, 7, 7, 7),
  (8, 'Revisar escalabilidad',    '2025-04-08', 'Pendiente',   8, 8, 8, 8);

-- Poblamiento de Evaluacion_financiera_requisitos (8 filas)
INSERT INTO Evaluacion_financiera_requisitos (id_evaluacion_f, ajuste_presupuestal_necesario, costo_estimado_total,fecha_evaluacion_f, monto_ajustado, id_requisitos,id_opciones_comerciales, id_documento) VALUES
  (1, 'Ninguno',      15000.00, '2025-04-01', 15000.00, 1, 1, 1),
  (2, 'Reducir 5%',   12000.00, '2025-04-02', 11400.00, 2, 2, 2),
  (3, 'Ajuste 10%',   20000.00, '2025-04-03', 18000.00, 3, 3, 3),
  (4, 'Ninguno',      8000.00,  '2025-04-04', 8000.00,  4, 4, 4),
  (5, 'Incremento 5%',11000.00, '2025-04-05', 11550.00, 5, 5, 5),
  (6, 'Reducir 8%',   9000.00,  '2025-04-06', 8280.00,  6, 6, 6),
  (7, 'Ninguno',      13000.00, '2025-04-07', 13000.00, 7, 7, 7),
  (8, 'Ajuste 12%',   5000.00,  '2025-04-08', 5600.00,  8, 8, 8);

-- Poblamiento de Notificación (8 filas)
INSERT INTO Notificación (id_notificacion, mensaje, fecha_envio, estado_notificacion,id_cliente, id_requisitos) VALUES
  (1, 'Revisión completada',       '2025-04-02', 'ENVIADA',   1, 1),
  (2, 'Falta aprobación cliente',  '2025-04-03', 'PENDIENTE', 2, 2),
  (3, 'Aprobado técnicamente',     '2025-04-04', 'ENVIADA',   3, 3),
  (4, 'Requiere ajuste presupuesto','2025-04-05', 'ENVIADA',   4, 4),
  (5, 'Cliente notificó cambios',  '2025-04-06', 'PENDIENTE', 5, 5),
  (6, 'Validación financiera ok',  '2025-04-07', 'ENVIADA',   6, 6),
  (7, 'Esperando documento',       '2025-04-08', 'PENDIENTE', 7, 7),
  (8, 'Auditoría programada',      '2025-04-09', 'ENVIADA',   8, 8);

-- Poblamiento de Auditoría (8 filas)
INSERT INTO Auditoría (id_auditoria, fecha_aud, id_cliente, id_requisitos) VALUES
  (1, '2025-04-03', 1, 1),
  (2, '2025-04-04', 2, 2),
  (3, '2025-04-05', 3, 3),
  (4, '2025-04-06', 4, 4),
  (5, '2025-04-07', 5, 5),
  (6, '2025-04-08', 6, 6),
  (7, '2025-04-09', 7, 7),
  (8, '2025-04-10', 8, 8);

-- Poblamiento de Validacion_detalles_tecnicos (8 filas)
INSERT INTO Validacion_detalles_tecnicos (id_validacion_detalles, estado_validacion, fecha_validacion, id_comentario) VALUES
  (1, 'AP', '2025-04-02', 1),
  (2, 'PD', '2025-04-03', 2),
  (3, 'PD', '2025-04-04', 3),
  (4, 'AP', '2025-04-05', 4),
  (5, 'PD', '2025-04-06', 5),
  (6, 'PD', '2025-04-07', 6),
  (7, 'PD', '2025-04-08', 7),
  (8, 'AP', '2025-04-09', 8);

-- Poblamiento de Solicitud (8 filas)
INSERT INTO Solicitud (id_solicitud, descripción_solicitud, fecha_solicitud, fecha_firma, id_cliente) VALUES
  ('SOL001', 'Servicio de consultoría TI', '2025-04-11', '2025-04-15', 1),
  ('SOL002', 'Desarrollo de portal web',   '2025-04-12', '2025-04-16', 2),
  ('SOL003', 'Migración de base de datos', '2025-04-13', '2025-04-17', 3),
  ('SOL004', 'Implementación de API',      '2025-04-14', '2025-04-18', 4),
  ('SOL005', 'Capacitación de usuarios',   '2025-04-15', '2025-04-19', 5),
  ('SOL006', 'Auditoría de seguridad',     '2025-04-16', '2025-04-20', 6),
  ('SOL007', 'Optimización de consultas',  '2025-04-17', '2025-04-21', 7),
  ('SOL008', 'Despliegue en producción',   '2025-04-18', '2025-04-22', 8);

-- Poblamiento de Contrato (8 filas)
INSERT INTO Contrato (cod_contrato, nombre_contrato, monto, contenido,condiciones_contrato, id_contrato, fecha_contrato,id_version, id_solicitud) VALUES
  (1001, 'Contrato A', 50000.00, 'Contenido A', 'Condiciones A', 1, '2025-04-16', 1, 'SOL001'),
  (1002, 'Contrato B', 75000.00, 'Contenido B', 'Condiciones B', 2, '2025-04-17', 2, 'SOL002'),
  (1003, 'Contrato C', 60000.00, 'Contenido C', 'Condiciones C', 3, '2025-04-18', 3, 'SOL003'),
  (1004, 'Contrato D', 82000.00, 'Contenido D', 'Condiciones D', 4, '2025-04-19', 4, 'SOL004'),
  (1005, 'Contrato E', 45000.00, 'Contenido E', 'Condiciones E', 5, '2025-04-20', 5, 'SOL005'),
  (1006, 'Contrato F', 90000.00, 'Contenido F', 'Condiciones F', 6, '2025-04-21', 6, 'SOL006'),
  (1007, 'Contrato G', 68000.00, 'Contenido G', 'Condiciones G', 7, '2025-04-22', 7, 'SOL007'),
  (1008, 'Contrato H', 72000.00, 'Contenido H', 'Condiciones H', 8, '2025-04-23', 8, 'SOL008');

-- Poblamiento de proyecto (8 filas) con estados válidos
INSERT INTO proyecto (
  cod_proyecto, 
  nombre_proyecto, 
  descripción_proyecto,
  presupuesto, 
  estado_proyecto, 
  fecha_inicio, 
  fecha_fin,
  id_solicitud, 
  cod_sector
) VALUES
  (1, 'Proyecto A', 'Portal interno',     50000.00, 'Planificado', '2025-04-16', '2025-06-16', 'SOL001', 1),
  (2, 'Proyecto B', 'e-Commerce',         75000.00, 'En Ejecución', '2025-04-17', '2025-07-17', 'SOL002', 2),
  (3, 'Proyecto C', 'Data Warehouse',     60000.00, 'Planificado', '2025-04-18', '2025-08-18', 'SOL003', 3),
  (4, 'Proyecto D', 'API REST',           82000.00, 'Suspendido', '2025-04-19', '2025-09-19', 'SOL004', 4),
  (5, 'Proyecto E', 'Training App',       45000.00, 'En Ejecución', '2025-04-20', '2025-05-20', 'SOL005', 5),
  (6, 'Proyecto F', 'Security Audit',     90000.00, 'Planificado', '2025-04-21', '2025-07-21', 'SOL006', 6),
  (7, 'Proyecto G', 'SQL Tuning',         68000.00, 'En Ejecución', '2025-04-22', '2025-06-22', 'SOL007', 7),
  (8, 'Proyecto H', 'Prod Deployment',    72000.00, 'Suspendido', '2025-04-23', '2025-05-23', 'SOL008', 8);

-- Poblamiento de Proyecto_servicio (8 filas)
INSERT INTO Proyecto_servicio (id_servicio, cod_proyecto) VALUES
  (1, 1),
  (2, 2),
  (3, 3),
  (4, 4),
  (5, 5),
  (6, 6),
  (7, 7),
  (8, 8);

-- Poblamiento de Termino (8 filas)
INSERT INTO Termino (id_termino, descripcion_term, estado_term, id_contrato) VALUES
  (1, 'Entrega inicial', 'ACTIVO', 1),
  (2, 'Revisión técnica', 'ACTIVO', 2),
  (3, 'Validación QA',    'ACTIVO', 3),
  (4, 'Firma final',      'ACTIVO', 4),
  (5, 'Soporte 6m',       'ACTIVO', 5),
  (6, 'Mantenimiento',    'ACTIVO', 6),
  (7, 'Auditoría',        'ACTIVO', 7),
  (8, 'Cierre',           'ACTIVO', 8);

-- Poblamiento de Detalles_tecnicos (8 filas)
INSERT INTO Detalles_tecnicos (id_detalle_tecnico, arquitectura, metodologia,integraciones, id_modulo, id_hito,id_validacion_detalles, id_documento) VALUES
  (1, 'Microservicios', 'AG', 'Auth,Users',    1, 1, 1, 1),
  (2, 'Monolito',      'CA', 'DB,API',        2, 2, 2, 2),
  (3, 'Layered',       'HI', 'Reporting',     3, 3, 3, 3),
  (4, 'Serverless',    'HI', 'Notifications', 4, 4, 4, 4),
  (5, 'Hexagonal',     'CA', 'Dashboard',     5, 5, 5, 5),
  (6, 'CQRS',          'AG', 'Audit,Logs',    6, 6, 6, 6),
  (7, 'Event-driven',  'CA', 'Queue,Cache',   7, 7, 7, 7),
  (8, 'MVC',           'AG', 'UI,API',        8, 8, 8, 8);

-- Poblamiento de Propuesta (8 filas)
INSERT INTO Propuesta (
  id_propuesta, titulo_propuesta, descripcion_propuesta,fecha_propuesta, estado_prouesta, etapa_propuesta ,id_detalle_tecnico, id_presupuesto, id_respuesta_, id_requisitos) VALUES
  (1, 'Prop A', 'Descripción A', '2025-04-12', 'BT', 'I', 1, 1, 1, 1),
  (2, 'Prop B', 'Descripción B', '2025-04-13', 'TA', 'T', 2, 2, 2, 2),
  (3, 'Prop C', 'Descripción C', '2025-04-14', 'PA', 'C', 3, 3, 3, 3),
  (4, 'Prop D', 'Descripción D', '2025-04-15', 'PR', 'L', 4, 4, 4, 4),
  (5, 'Prop E', 'Descripción E', '2025-04-16', 'AC', 'F', 5, 5, 5, 5),
  (6, 'Prop F', 'Descripción F', '2025-04-17', 'RC', 'I', 6, 6, 6, 6),
  (7, 'Prop G', 'Descripción G', '2025-04-18', 'AR', 'T', 7, 7, 7, 7),
  (8, 'Prop H', 'Descripción H', '2025-04-19', 'AR', 'C', 8, 8, 8, 8);

-- Poblamiento de Gerente_Comercial (8 filas)
INSERT INTO Gerente_Comercial (id_gerente_comercial, nombre_gerente, telefono_gerente, correo_gerente, id_usuario, id_validacion_presupuesto) VALUES
  (1, 'Juan Martínez',  999111000, 'jmartinez@resa.com',   2, 1),
  (2, 'Ana Ramírez',    999222000, 'aramirez@presa.com',     4, 2),
  (3, 'Carlos Ruiz',    999333000, 'cruiz@empsa.com',        6, 3),
  (4, 'Sofía Díaz',     999444000, 'sdiaz@emsa.com',        8, 4),
  (5, 'Luis Torres',    999555000, 'ltorres@eresa.com',      10,5),
  (6, 'Marta León',     999666000, 'mleon@emsa.com',        12,6),
  (7, 'Diego Pérez',    999777000, 'dperez@eresa.com',       1, 7),
  (8, 'Laura Soto',     999888000, 'lsoto@eesa.com',        3, 8);

-- Poblamiento de Ejecutivo_Comercial (8 filas)
INSERT INTO Ejecutivo_Comercial ( id_ejecutivo_comercial, nombre_ejecutivo, telefono_ejecutivo, correo_ejecutivo, id_usuario, id_termino) VALUES
  (1, 'Eva Gómez',  988111000, 'egomez@emesa.com',  2, 1),
  (2, 'Pedro Huam', 988222000, 'phuam@emsa.com',   3, 2),
  (3, 'Laura Cea',  988333000, 'lcea@empa.com',    4, 3),
  (4, 'Mario Vel',  988444000, 'mvel@empsa.com',    5, 4),
  (5, 'Lucía Qui',  988555000, 'lqui@empa.com',    6, 5),
  (6, 'Iván Cruz',  988666000, 'icruz@eesa.com',   7, 6),
  (7, 'Elena Rey',  988777000, 'erey@emsa.com',    8, 7),
  (8, 'Óscar Gil',  988888000, 'ogil@emesa.com',    9, 8);

-- Poblamiento de Contacto (8 filas)
INSERT INTO Contacto (
  id_contacto, nombre_contacto, email_contacto, telefono_contacto, cargo_contacto, origen, id_empresa, id_ejecutivo_comercial) VALUES
  (1, 'Ana Peña',    'apena@techsol.com',   977111000, 'Manager',  'Prospecto', 1, 1),
  (2, 'Luis Soto',   'lsoto@saludplus.pe',  977222000, 'Director', 'Cliente',   2, 2),
  (3, 'Marta Ruiz',  'mruiz@educa.edu',     977333000, 'Coordin',  'Prospecto', 3, 3),
  (4, 'Diego Ponce', 'dponce@financorp.com',977444000, 'Gerente',  'Cliente',   4, 4),
  (5, 'Sofía León',  'sleon@manufacto.org', 977555000, 'Supervisor','Prospecto',5, 5),
  (6, 'Carlos Rey',  'crey@retailmart.pe',  977666000, 'Ejecutiv', 'Cliente',   6, 6),
  (7, 'Elena Cruz',  'ecruz@enverde.com',   977777000, 'Analista', 'Prospecto',7, 7),
  (8, 'David Martín','dmartin@translog.pe',  977888000, 'Asistente','Cliente',   8, 8);

-- Poblamiento de Visita (8 filas)
INSERT INTO Visita (id_visita, fecha_hora_visita, notas_visita, lugar_visita, estado_visita, id_empresa, id_ejecutivo_comercial) VALUES
  (1, '2025-04-10', 'Primera reunión',    'Oficina Central',    'Programada', 1, 1),
  (2, '2025-04-11', 'Demo solución',      'Sucursal Norte',     'Completada', 2, 2),
  (3, '2025-04-12', 'Recoger requisitos',  'Cliente Oficina',    'Programada', 3, 3),
  (4, '2025-04-13', 'Verificar contratos', 'Oficina Legal',      'Cancelada',  4, 4),
  (5, '2025-04-14', 'Revisión técnica',    'Data Center',        'Completada', 5, 5),
  (6, '2025-04-15', 'Capacitación',        'Sala de Formación',  'Programada', 6, 6),
  (7, '2025-04-16', 'Auditoría seguridad', 'Oficina Seguridad',  'Completada', 7, 7),
  (8, '2025-04-17', 'Cierre proyecto',     'Sucursal Sur',       'Programada', 8, 8);

-- Poblamiento de Agenda_ec (8 filas)
INSERT INTO Agenda_ec (agenda_ec, fecha_dispo, inicio_dispo, final_dispo, estado_agenda, id_ejecutivo_comercial) VALUES
  ('AGENDA001','2025-04-20','09:00:00','10:00:00','Disponible', 1),
  ('AGENDA002','2025-04-20','10:30:00','11:30:00','Reservada',  2),
  ('AGENDA003','2025-04-21','09:00:00','10:00:00','Disponible', 3),
  ('AGENDA004','2025-04-21','10:30:00','11:30:00','Reservada',  4),
  ('AGENDA005','2025-04-22','09:00:00','10:00:00','Disponible', 5),
  ('AGENDA006','2025-04-22','10:30:00','11:30:00','Reservada',  6),
  ('AGENDA007','2025-04-23','09:00:00','10:00:00','Disponible', 7),
  ('AGENDA008','2025-04-23','10:30:00','11:30:00','Reservada',  8);

-- Poblamiento de Dolor (8 filas)
INSERT INTO Dolor (id_dolor, nombre_dolor, industria, id_cliente, id_ejecutivo_comercial, id_visita) VALUES
  (1, 'Performance',   'Tecnología', 1, 1, 1),
  (2, 'Seguridad',     'Salud',      2, 2, 2),
  (3, 'Usabilidad',    'Educación',  3, 3, 3),
  (4, 'Escalabilidad', 'Finanzas',   4, 4, 4),
  (5, 'Integración',   'Manufactura',5, 5, 5),
  (6, 'Costo',         'Retail',     6, 6, 6),
  (7, 'Conectividad',  'Energía',    7, 7, 7),
  (8, 'Disponibilidad','Transporte', 8, 8, 8);

-- Poblamiento de Convocatoria (5 filas)
INSERT INTO Convocatoria (id_convocatoria, fecha_publicacon, fecha_limite, es_formal, id_dolor, cod_tipo_convocatoria) VALUES
  (1, '2025-04-01', '2025-04-10', true, 1, 1),
  (2, '2025-04-02', '2025-04-12', false, 2, 2),
  (3, '2025-04-03', '2025-04-15', true, 3, 3),
  (4, '2025-04-04', '2025-04-18', false, 4, 4),
  (5, '2025-04-05', '2025-04-20', true, 5, 5);

-- Poblamiento de Viabilidad_tecnica (5 filas)
INSERT INTO Viabilidad_tecnica (id_viabilidad_tecnica, hay_experiencia, es_viable, comentario, id_dolor) VALUES
  (1, true,  true,  'Experiencia previa suficiente', 1),
  (2, false, false, 'Falta conocimiento en la tecnología', 2),
  (3, true,  true,  'Equipo preparado y capacitado', 3),
  (4, true,  false, 'Dependencias no cubiertas', 4),
  (5, false, true,  'Viable con formación adicional', 5);

-- Poblamiento de Equipo_técnico (5 filas)
INSERT INTO Equipo_técnico (id_equipo, nombre_equipo_tecnico, capacidad, cod_especialidad, id_propuesta, id_validacion_detalles) VALUES
  ('EQ001', 'Equipo Alpha       ', 5, 1, 1, 1),
  ('EQ002', 'Equipo Beta        ', 3, 2, 2, 2),
  ('EQ003', 'Equipo Gamma       ', 4, 3, 3, 3),
  ('EQ004', 'Equipo Delta       ', 2, 4, 4, 4),
  ('EQ005', 'Equipo Epsilon     ', 6, 5, 5, 5);

-- Poblamiento de Partner (5 filas)
INSERT INTO Partner (id_partner, nombre_contacto, telefono_contacto, correo_contacto, especialidad_partner, id_dolor) VALUES
  (1, 'Ana Torres         ', 91234001, 'atorresartner.com', 'TI',    1),
  (2, 'Luis Mendoza       ', 91234002, 'lmendo@partner.com','Seguridad', 2),
  (3, 'Marta Ruiz         ', 91234003, 'mruiz@paer.com',   'Redes', 3),
  (4, 'Diego Fernández    ', 91234004, 'dfernandepartner.com','DB',   4),
  (5, 'Sofía Castillo     ', 9120005, 'scastillotner.com','UX',   5);

-- Poblamiento de Decisor (5 filas)
INSERT INTO Decisor (id_decisor, nombre_decisor, cargo_decisor, telefono_decisor, correo_decisor, RUC_decisor, direccion_decisor, id_dolor) VALUES
  (1, 'Juan Pérez     ', 'CEO           ', 9876501, 'jperezlient.com', 203456789, 'Av. Principal 123   ', 1),
  (2, 'Ana Gómez      ', 'CFO           ', 9876002, 'agomez@clie.com', 2023567890, 'Calle Secundaria 45 ', 2),
  (3, 'Luis Torres    ', 'CTO           ', 987650003, 'ltorres@clnt.com',2034578901, 'Jr. Tercero 67      ', 3),
  (4, 'Marta León     ', 'COO           ', 987650004, 'mleon@clie.com', 204569012, 'Av. Cuarto 89       ', 4),
  (5, 'Diego Ramírez  ', 'CMO           ', 98765005, 'dramirez@ient.com',205890123,'Calle Quinto 10     ', 5);


  -- Poblamiento de Orden_Compra (5 filas)
INSERT INTO Orden_Compra (id_oc, fecha_oc, precio_total, fecha_entrega, id_solicitud, id_servicio, cod_estado_oc, id_equipo) VALUES
  (1, '2025-04-11', 12000.00, '2025-05-01', 'SOL001', 1, 1, 'EQ001'),
  (2, '2025-04-12', 15000.50, '2025-05-05', 'SOL002', 2, 2, 'EQ002'),
  (3, '2025-04-13',  8000.75, '2025-05-10', 'SOL003', 3, 3, 'EQ003'),
  (4, '2025-04-14', 20000.00, '2025-05-15', 'SOL004', 4, 4, 'EQ004'),
  (5, '2025-04-15',  9500.00, '2025-05-20', 'SOL005', 5, 5, 'EQ005');

-- Poblamiento de Detalle_OC (5 filas)
INSERT INTO Detalle_OC (items, precio_unitario, id_detalle_oc, subtotal, direccion_entrega, id_oc) VALUES
  (2, 6000.00, 1, 12000.00, 'Av. Lima 123', 1),
  (3, 5000.00, 2, 15000.00, 'Calle Roja 45',2),
  (1, 8000.75, 3,  8000.75, 'Jr. Paz 789', 3),
  (4, 5000.00, 4, 20000.00, 'Av. Grau 56', 4),
  (5, 1900.00, 5,  9500.00, 'Calle Sol 12',5);

-- Poblamiento de Dolor_equipo_tecnico (5 filas)
INSERT INTO Dolor_equipo_tecnico (fecha_asignacion, id_dolor, id_equipo) VALUES
  ('2025-04-11', 1, 'EQ001'),
  ('2025-04-12', 2, 'EQ002'),
  ('2025-04-13', 3, 'EQ003'),
  ('2025-04-14', 4, 'EQ004'),
  ('2025-04-15', 5, 'EQ005');

-- Poblamiento de Encargo_comercial (5 filas) con estados válidos
INSERT INTO Encargo_comercial (
  id_encargo, 
  nombre_encargo, 
  fecha_asignacion, 
  estado_encargo, 
  fecha_termino, 
  id_responsable, 
  id_asignador
) VALUES
  (1, 'EncargoA', '2025-04-11', 'pendiente', '2025-04-20', 1, 1),
  (2, 'EncargoB', '2025-04-12', 'completado', '2025-04-22', 2, 2),
  (3, 'EncargoC', '2025-04-13', 'pendiente', '2025-04-25', 3, 3),
  (4, 'EncargoD', '2025-04-14', 'completado', '2025-04-28', 4, 4),
  (5, 'EncargoE', '2025-04-15', 'pendiente', '2025-05-01', 5, 5);

-- Poblamiento de Encargo_proyecto (5 filas)
INSERT INTO Encargo_proyecto (id_encargo, cod_proyecto) VALUES
  (1, 1),
  (2, 2),
  (3, 3),
  (4, 4),
  (5, 5);
-- Poblamiento de Entregable_experiencia (5 filas)
INSERT INTO Entregable_experiencia (id_entregable, nombre_archivo, ruta_archivo, fecha_entrega,descripcion_entregable, id_encargo) VALUES
  (1, 'reporte1.pdf'   , '/entregables/1', '2025-04-20', 'Informe inicial de proyecto', 1),
  (2, 'diseño_v1.png'  , '/entregables/2', '2025-04-22', 'Mockups de pantalla principal', 2),
  (3, 'api_doc.docx'   , '/entregables/3', '2025-04-24', 'Documento de especificación API', 3),
  (4, 'test_plan.xlsx' , '/entregables/4', '2025-04-26', 'Plan de pruebas funcionales', 4),
  (5, 'manual_usuario.pdf','/entregables/5', '2025-04-28', 'Manual de usuario final', 5);

-- Poblamiento de Comentario_encargo (5 filas)
INSERT INTO Comentario_encargo (id_comentario_enc, fecha, contenido, id_encargo) VALUES
  (1, '2025-04-21', 'Revisar formato del informe inicial.',        1),
  (2, '2025-04-23', 'Ajustar colores de los mockups.',            2),
  (3, '2025-04-25', 'Agregar ejemplos de llamada a la API.',      3),
  (4, '2025-04-27', 'Incluir casos de prueba adicionales.',       4),
  (5, '2025-04-29', 'Verificar redacción del manual de usuario.', 5);

-- Poblamiento de Conversación_preventa (5 filas)
INSERT INTO Conversación_preventa (tipo_conversacion, Asunto, fecha_inicio,id_conversacion_pre, id_ejecutivo_comercial, id_entregable, id_contacto) VALUES
  ('Email'         , 'Solicitud demo TI'        , '2025-04-21', 1, 1, 1, 1),
  ('Llamada'       , 'Requisitos portal web'    , '2025-04-22', 2, 2, 2, 2),
  ('Reunión'       , 'Especificación API'        , '2025-04-23', 3, 3, 3, 3),
  ('Chat'          , 'Plan de pruebas'           , '2025-04-24', 4, 4, 4, 4),
  ('Video'         , 'Manual de usuario'         , '2025-04-25', 5, 5, 5, 5);

-- Poblamiento de Mensaje (5 filas)
INSERT INTO Mensaje (
  id_mensaje, contenido_mensaje, fecha_hora_envio, id_conversacion_pre) VALUES
  (1, '¿Podemos agendar la demo para el lunes?','2025-04-21', 1),
  (2, 'Envío los mockups para su revisión.'  ,'2025-04-22', 2),
  (3, 'Adjunto el borrador de la API.'       ,'2025-04-23', 3),
  (4, 'Plan de pruebas listo, revisa por favor.','2025-04-24',4),
  (5, 'Manual en versión preliminar.'        ,'2025-04-25', 5);

-- Poblamiento de Reunion (5 filas)
INSERT INTO Reunion (id_reunion, hora_inicio, hora_final, fecha_re,resumen_re, modalidad_re, lugar_re, estado_re,id_ejecutivo_comercial, id_cliente, id_propuesta) VALUES
  (1, '09:00:00', '10:00:00', '2025-04-26', 'Kickoff proyecto A', 'P', 'Sala 1' , 'RE', 1, 1, 1),
  (2, '11:00:00', '12:00:00', '2025-04-27', 'Revisión mockups'  , 'V', 'Sala 2' , 'RE', 2, 2, 2),
  (3, '14:00:00', '15:00:00', '2025-04-28', 'API spec meeting'   , 'P', 'Sala 3' , 'PR', 3, 3, 3),
  (4, '16:00:00', '17:00:00', '2025-04-29', 'Pruebas funcionales', 'V', 'Lab 1'  , 'CA', 4, 4, 4),
  (5, '10:00:00', '11:00:00', '2025-04-30', 'Manual review'      , 'P', 'Lab 2'  , 'RE', 5, 5, 5);

-- Poblamiento de Ajuste (5 filas)
INSERT INTO Ajuste (id_ajuste, tipo_ajuste, descripcion_ajsute,estado_ajuste, id_termino, id_propuesta) VALUES
  ('AJST001', 'TIPO1'   , 'Modificar alcance módulo A'      , 'PEND', 1, 1),
  ('AJST002', 'TIPO2'   , 'Reducir costo de licencias'       , 'OK'  , 2, 2),
  ('AJST003', 'TIPO3'   , 'Extender plazo de entrega'        , 'PD'  , 3, 3),
  ('AJST004', 'TIPO1'   , 'Agregar soporte 24/7'             , 'OK'  , 4, 4),
  ('AJST005', 'TIPO2'   , 'Actualizar documentación técnica' , 'PEND', 5, 5);

