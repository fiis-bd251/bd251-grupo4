CREATE TABLE Rol
(
  id_rol INT NOT NULL,
  nombre_rol VARCHAR NOT NULL,
  descripción VARCHAR NOT NULL,
  PRIMARY KEY (id_rol)
);

CREATE TABLE Versión_contrato
(
  id_version INT NOT NULL,
  version VARCHAR NOT NULL,
  fecha_version INT NOT NULL,
  cambios VARCHAR NOT NULL,
  PRIMARY KEY (id_version)
);

CREATE TABLE Estado_oc
(
  cod_estado_oc INT NOT NULL,
  nombre_estado_oc VARCHAR NOT NULL,
  descripción_estado_oc VARCHAR NOT NULL,
  PRIMARY KEY (cod_estado_oc)
);

CREATE TABLE Categoria_servicios
(
  cod_categoria VARCHAR NOT NULL,
  nombre_categoria VARCHAR NOT NULL,
  PRIMARY KEY (cod_categoria)
);

CREATE TABLE Especialidad_equipo
(
  cod_especialidad INT NOT NULL,
  nombre_especialidad VARCHAR NOT NULL,
  PRIMARY KEY (cod_especialidad)
);

CREATE TABLE Satisfacción
(
  id_satisfaccion INT NOT NULL,
  nombre_satisfaccion VARCHAR NOT NULL,
  puntuacion INT NOT NULL,
  PRIMARY KEY (id_satisfaccion)
);

CREATE TABLE Tipo_convocatoria
(
  cod_tipo_convocatoria INT NOT NULL,
  tipo_convocatoria VARCHAR NOT NULL,
  PRIMARY KEY (cod_tipo_convocatoria)
);

CREATE TABLE Sector_Mercado
(
  cod_sector INT NOT NULL,
  nombre_sector VARCHAR NOT NULL,
  PRIMARY KEY (cod_sector)
);

CREATE TABLE Cátalogo_servicios
(
  id_servicio INT NOT NULL,
  nombre VARCHAR NOT NULL,
  cod_categoria VARCHAR NOT NULL,
  PRIMARY KEY (id_servicio),
  FOREIGN KEY (cod_categoria) REFERENCES Categoria_servicios(cod_categoria)
);

CREATE TABLE Usuario
(
  id_usuario INT NOT NULL,
  contraseña VARCHAR NOT NULL,
  correo VARCHAR NOT NULL,
  user_name VARCHAR NOT NULL,
  id_rol INT NOT NULL,
  PRIMARY KEY (id_usuario),
  FOREIGN KEY (id_rol) REFERENCES Rol(id_rol)
);

CREATE TABLE Comentarios
(
  id_comentario INT NOT NULL,
  fecha_comentario DATE NOT NULL,
  texto_comentario VARCHAR NOT NULL,
  id_origen INT NOT NULL,
  tipo_origen INT NOT NULL,
  id_usuario INT NOT NULL,
  PRIMARY KEY (id_comentario),
  FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario)
);

CREATE TABLE Empresa
(
  id_empresa INT NOT NULL,
  nombre_empresa VARCHAR NOT NULL,
  tamaño_empresa INT NOT NULL,
  locales_empresa INT NOT NULL,
  telefono_empresa INT NOT NULL,
  web_corporativa VARCHAR NOT NULL,
  ranklng INT NOT NULL,
  cod_sector INT NOT NULL,
  PRIMARY KEY (id_empresa),
  FOREIGN KEY (cod_sector) REFERENCES Sector_Mercado(cod_sector)
);

CREATE TABLE Equipo_técnico
(
  id_equipo VARCHAR NOT NULL,
  nombre_equipo_tecnico INT NOT NULL,
  capacidad INT NOT NULL,
  cod_especialidad INT NOT NULL,
  PRIMARY KEY (id_equipo),
  FOREIGN KEY (cod_especialidad) REFERENCES Especialidad_equipo(cod_especialidad)
);

CREATE TABLE Ejecutivo_Comercial
(
  id_ejecutivo_comercial INT NOT NULL,
  nombre_ejecutivo VARCHAR NOT NULL,
  telefono_ejecutivo INT NOT NULL,
  correo_ejecutivo VARCHAR NOT NULL,
  id_usuario INT NOT NULL,
  PRIMARY KEY (id_ejecutivo_comercial),
  FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario)
);

CREATE TABLE Gerente_Comercial
(
  id_gerente_comercial INT NOT NULL,
  nombre_gerente VARCHAR NOT NULL,
  telefono_gerente INT NOT NULL,
  correo_gerente VARCHAR NOT NULL,
  id_usuario INT NOT NULL,
  PRIMARY KEY (id_gerente_comercial),
  FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario)
);

CREATE TABLE Solicitud_web
(
  id_solicitud_web INT NOT NULL,
  nombre_solicitante VARCHAR NOT NULL,
  apellido_solicitante VARCHAR NOT NULL,
  telefono_solicitante INT NOT NULL,
  correo_solicitante VARCHAR NOT NULL,
  fecha_envio DATE NOT NULL,
  id_empresa INT NOT NULL,
  FOREIGN KEY (id_empresa) REFERENCES Empresa(id_empresa)
);

CREATE TABLE Cliente
(
  id_cliente INT NOT NULL,
  direccion VARCHAR NOT NULL,
  nombre VARCHAR NOT NULL,
  cant_contratos INT NOT NULL,
  num_ruc INT NOT NULL,
  fecha_primera_compra DATE NOT NULL,
  id_usuario INT NOT NULL,
  id_satisfaccion INT NOT NULL,
  id_empresa INT NOT NULL,
  PRIMARY KEY (id_cliente),
  FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario),
  FOREIGN KEY (id_satisfaccion) REFERENCES Satisfacción(id_satisfaccion),
  FOREIGN KEY (id_empresa) REFERENCES Empresa(id_empresa)
);

CREATE TABLE Dolor
(
  id_dolor INT NOT NULL,
  nombre_dolor VARCHAR NOT NULL,
  industria VARCHAR NOT NULL,
  id_cliente INT NOT NULL,
  id_ejecutivo_comercial INT NOT NULL,
  PRIMARY KEY (id_dolor),
  FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente),
  FOREIGN KEY (id_ejecutivo_comercial) REFERENCES Ejecutivo_Comercial(id_ejecutivo_comercial)
);

CREATE TABLE Convocatoria
(
  id_convocatoria INT NOT NULL,
  fecha_publicacon DATE NOT NULL,
  fecha_limite DATE NOT NULL,
  es_formal  NOT NULL,
  id_dolor INT NOT NULL,
  cod_tipo_convocatoria INT NOT NULL,
  PRIMARY KEY (id_convocatoria),
  FOREIGN KEY (id_dolor) REFERENCES Dolor(id_dolor),
  FOREIGN KEY (cod_tipo_convocatoria) REFERENCES Tipo_convocatoria(cod_tipo_convocatoria)
);

CREATE TABLE Viabilidad_tecnica
(
  id_viabilidad_tecnica INT NOT NULL,
  hay_experiencia  NOT NULL,
  es_viable  NOT NULL,
  comentario VARCHAR NOT NULL,
  id_dolor INT NOT NULL,
  PRIMARY KEY (id_viabilidad_tecnica),
  FOREIGN KEY (id_dolor) REFERENCES Dolor(id_dolor)
);

CREATE TABLE Partner
(
  id_partner INT NOT NULL,
  nombre_contacto VARCHAR NOT NULL,
  telefono_contacto INT NOT NULL,
  correo_contacto VARCHAR NOT NULL,
  especialidad_partner VARCHAR NOT NULL,
  id_dolor INT NOT NULL,
  PRIMARY KEY (id_partner),
  FOREIGN KEY (id_dolor) REFERENCES Dolor(id_dolor)
);

CREATE TABLE Dolor_equipo_tecnico
(
  fecha_asignacion DATE NOT NULL,
  id_dolor INT NOT NULL,
  id_equipo VARCHAR NOT NULL,
  PRIMARY KEY (id_dolor, id_equipo),
  FOREIGN KEY (id_dolor) REFERENCES Dolor(id_dolor),
  FOREIGN KEY (id_equipo) REFERENCES Equipo_técnico(id_equipo)
);

CREATE TABLE Encargo_comercial
(
  id_encargo INT NOT NULL,
  nombre_encargo VARCHAR NOT NULL,
  comentario_encargo VARCHAR NOT NULL,
  fecha_asignacion DATE NOT NULL,
  estado_encargo VARCHAR NOT NULL,
  id_responsable INT NOT NULL,
  id_asignador INT NOT NULL,
  PRIMARY KEY (id_encargo),
  FOREIGN KEY (id_responsable) REFERENCES Ejecutivo_Comercial(id_ejecutivo_comercial),
  FOREIGN KEY (id_asignador) REFERENCES Gerente_Comercial(id_gerente_comercial)
);

CREATE TABLE Visita
(
  id_visita INT NOT NULL,
  fecha_hora_visita DATE NOT NULL,
  notas_visita VARCHAR NOT NULL,
  lugar_visita VARCHAR NOT NULL,
  estado_visita VARCHAR NOT NULL,
  id_empresa INT NOT NULL,
  id_ejecutivo_comercial INT NOT NULL,
  id_dolor INT NOT NULL,
  FOREIGN KEY (id_empresa) REFERENCES Empresa(id_empresa),
  FOREIGN KEY (id_ejecutivo_comercial) REFERENCES Ejecutivo_Comercial(id_ejecutivo_comercial),
  FOREIGN KEY (id_dolor) REFERENCES Dolor(id_dolor)
);

CREATE TABLE Entregable_experiencia
(
  id_entregable INT NOT NULL,
  nombre_archivo VARCHAR NOT NULL,
  ruta_archivo VARCHAR NOT NULL,
  fecha_entrega DATE NOT NULL,
  descripcion_entregable VARCHAR NOT NULL,
  id_encargo INT NOT NULL,
  PRIMARY KEY (id_entregable),
  FOREIGN KEY (id_encargo) REFERENCES Encargo_comercial(id_encargo)
);

CREATE TABLE Comentario_encargo
(
  id_comentario_enc INT NOT NULL,
  fecha DATE NOT NULL,
  contenido VARCHAR NOT NULL,
  id_encargo INT NOT NULL,
  FOREIGN KEY (id_encargo) REFERENCES Encargo_comercial(id_encargo)
);

CREATE TABLE Conversación_preventa
(
  tipo_conversacion VARCHAR NOT NULL,
  Asunto VARCHAR NOT NULL,
  fecha_inicio INT NOT NULL,
  id_conversacion_pre INT NOT NULL,
  id_ejecutivo_comercial INT NOT NULL,
  id_entregable INT NOT NULL,
  PRIMARY KEY (id_conversacion_pre),
  FOREIGN KEY (id_ejecutivo_comercial) REFERENCES Ejecutivo_Comercial(id_ejecutivo_comercial),
  FOREIGN KEY (id_entregable) REFERENCES Entregable_experiencia(id_entregable)
);

CREATE TABLE Mensaje
(
  mensaje_id INT NOT NULL,
  contenido_mensaje VARCHAR NOT NULL,
  fecha_hora_envio DATE NOT NULL,
  id_conversacion_pre INT NOT NULL,
  PRIMARY KEY (mensaje_id),
  FOREIGN KEY (id_conversacion_pre) REFERENCES Conversación_preventa(id_conversacion_pre)
);

CREATE TABLE Solicitud
(
  id_solicitud VARCHAR NOT NULL,
  descripción_solicitud VARCHAR NOT NULL,
  fecha_solicitud DATE NOT NULL,
  fecha_firma DATE NOT NULL,
  id_cliente INT NOT NULL,
  PRIMARY KEY (id_solicitud),
  FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente)
);

CREATE TABLE Contrato
(
  cod_contrato INT NOT NULL,
  nombre_contrato VARCHAR NOT NULL,
  monto INT NOT NULL,
  contenido VARCHAR NOT NULL,
  condiciones_contrato VARCHAR NOT NULL,
  id_contrato INT NOT NULL,
  fecha_contrato DATE NOT NULL,
  id_version INT NOT NULL,
  id_solicitud VARCHAR NOT NULL,
  PRIMARY KEY (id_contrato),
  FOREIGN KEY (id_version) REFERENCES Versión_contrato(id_version),
  FOREIGN KEY (id_solicitud) REFERENCES Solicitud(id_solicitud)
);

CREATE TABLE proyecto
(
  cod_proyecto INT NOT NULL,
  nombre_proyecto INT NOT NULL,
  descripción_proyecto VARCHAR NOT NULL,
  presupuesto FLOAT NOT NULL,
  estado_proyecto INT NOT NULL,
  fecha_inicio DATE NOT NULL,
  fecha_fin DATE NOT NULL,
  id_solicitud VARCHAR NOT NULL,
  cod_sector INT NOT NULL,
  PRIMARY KEY (cod_proyecto),
  FOREIGN KEY (id_solicitud) REFERENCES Solicitud(id_solicitud),
  FOREIGN KEY (cod_sector) REFERENCES Sector_Mercado(cod_sector)
);

CREATE TABLE Decisor
(
  id_decisor INT NOT NULL,
  nombre_decisor VARCHAR NOT NULL,
  cargo_decisor VARCHAR NOT NULL,
  telefono_decisor INT NOT NULL,
  correo_decisor VARCHAR NOT NULL,
  RUC_decisor INT NOT NULL,
  direccion_decisor VARCHAR NOT NULL,
  id_dolor INT NOT NULL,
  PRIMARY KEY (id_decisor),
  FOREIGN KEY (id_dolor) REFERENCES Dolor(id_dolor)
);

CREATE TABLE Encargo_proyecto
(
  id_encargo INT NOT NULL,
  cod_proyecto INT NOT NULL,
  FOREIGN KEY (id_encargo) REFERENCES Encargo_comercial(id_encargo),
  FOREIGN KEY (cod_proyecto) REFERENCES proyecto(cod_proyecto)
);

CREATE TABLE Contacto
(
  id_contacto INT NOT NULL,
  nombre_contacto VARCHAR NOT NULL,
  email_contacto VARCHAR NOT NULL,
  telefono_contacto VARCHAR NOT NULL,
  cargo_contacto VARCHAR NOT NULL,
  origen VARCHAR NOT NULL,
  id_empresa INT NOT NULL,
  id_ejecutivo_comercial INT NOT NULL,
  id_conversacion_pre INT NOT NULL,
  FOREIGN KEY (id_empresa) REFERENCES Empresa(id_empresa),
  FOREIGN KEY (id_ejecutivo_comercial) REFERENCES Ejecutivo_Comercial(id_ejecutivo_comercial),
  FOREIGN KEY (id_conversacion_pre) REFERENCES Conversación_preventa(id_conversacion_pre)
);

CREATE TABLE Proyecto_servicio
(
  id_servicio INT NOT NULL,
  cod_proyecto INT NOT NULL,
  FOREIGN KEY (id_servicio) REFERENCES Cátalogo_servicios(id_servicio),
  FOREIGN KEY (cod_proyecto) REFERENCES proyecto(cod_proyecto)
);

CREATE TABLE Orden_Compra
(
  id_oc INT NOT NULL,
  fecha_oc INT NOT NULL,
  precio_total INT NOT NULL,
  fecha_entrega INT NOT NULL,
  id_solicitud VARCHAR NOT NULL,
  id_servicio INT NOT NULL,
  cod_estado_oc INT NOT NULL,
  id_equipo VARCHAR NOT NULL,
  PRIMARY KEY (id_oc),
  FOREIGN KEY (id_solicitud) REFERENCES Solicitud(id_solicitud),
  FOREIGN KEY (id_servicio) REFERENCES Cátalogo_servicios(id_servicio),
  FOREIGN KEY (cod_estado_oc) REFERENCES Estado_oc(cod_estado_oc),
  FOREIGN KEY (id_equipo) REFERENCES Equipo_técnico(id_equipo)
);

CREATE TABLE Detalle_OC
(
  items INT NOT NULL,
  precio_unitario FLOAT NOT NULL,
  id_detalle_oc INT NOT NULL,
  subtotal FLOAT NOT NULL,
  direccion_entrega VARCHAR NOT NULL,
  id_oc INT NOT NULL,
  PRIMARY KEY (id_detalle_oc),
  FOREIGN KEY (id_oc) REFERENCES Orden_Compra(id_oc)
);