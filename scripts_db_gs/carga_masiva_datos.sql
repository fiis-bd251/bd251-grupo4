-- Poblamiento de la tabla Solicitud
COPY solicitud (
  id_solicitud,
  descripción_solicitud,
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

-- Poblamiento masivo de la tabla Equipo_técnico
COPY equipo_técnico (
  id_equipo,
  nombre_equipo_tecnico,
  capacidad,
  cod_especialidad,
  id_propuesta,
  id_validacion_detalles
)
FROM 'C:\\Users\\usuario\\Desktop\\UNI-FIIS\\2025-I\\DBD\\equipo_tecnico.csv'
WITH (
  FORMAT csv,
  HEADER true,
  DELIMITER ','
);

-- Poblamiento masivo de la tabla Propuesta
COPY propuesta (
  id_propuesta,
  titulo_propuesta,
  descripcion_propuesta,
  fecha_propuesta,
  estado_prouesta,
  etapa_propuesta,
  id_detalle_tecnico,
  id_presupuesto,
  id_respuesta_,
  id_requisitos
)
FROM 'C:\\Users\\usuario\\Desktop\\UNI-FIIS\\2025-I\\DBD\\propuesta.csv'
WITH (
  FORMAT csv,
  HEADER true,
  DELIMITER ','
);

-- Poblamiento masivo de la tabla Empresa 
COPY empresa (
  id_empresa,
  nombre_empresa,
  tamano_empresa, 
  telefono_empresa,
  web_corporativa,
  ranklng,
  cod_sector
)
FROM 'C:\\Users\\usuario\\Desktop\\UNI-FIIS\\2025-I\\DBD\\empresa.csv'
WITH (
  FORMAT csv,
  HEADER true,
  DELIMITER ','
);

-- Poblamiento masivo de la tabla Requisitos
COPY requisitos (
  id_requisitos,
  descripcion_r,
  prioridad_requisito,
  fecha_registro,
  estado_r,
  historial_cambios,
  fecha_actualizacion,
  id_cliente
)
FROM 'C:\\Users\\usuario\\Desktop\\UNI-FIIS\\2025-I\\DBD\\requisitos.csv'
WITH (
  FORMAT csv,
  HEADER true,
  DELIMITER ','
);

-- Poblamiento masivo de la tabla Respuesta_cliente
COPY respuesta_cliente (
  id_respuesta_,
  tipo_respuesta,
  comentarios,
  fecha_respuesta
)
FROM 'C:\\Users\\usuario\\Desktop\\UNI-FIIS\\2025-I\\DBD\\respuesta_cliente.csv'
WITH (
  FORMAT csv,
  HEADER true,
  DELIMITER ','
);

