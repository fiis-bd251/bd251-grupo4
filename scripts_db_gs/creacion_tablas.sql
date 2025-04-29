CREATE TABLE Rol (
    id_rol INT NOT NULL,
    nombre_rol CHAR(20) NOT NULL,
    descripción VARCHAR(30) NOT NULL,
    PRIMARY KEY (id_rol)
);

CREATE TABLE Usuario (
    id_usuario INT NOT NULL,
    contraseña CHAR(15) NOT NULL,
    correo VARCHAR(40) NOT NULL,
    user_name CHAR(10) NOT NULL,
    id_rol INT NOT NULL,
    PRIMARY KEY (id_usuario),
    FOREIGN KEY (id_rol) REFERENCES Rol (id_rol)
);

CREATE TABLE Version_contrato (
    id_version INT NOT NULL,
    version CHAR(5) NOT NULL,
    fecha_version DATE NOT NULL,
    cambios VARCHAR(100) NOT NULL,
    PRIMARY KEY (id_version)
);

CREATE TABLE Comentario (
    id_comentario INT NOT NULL,
    fecha_comentario DATE NOT NULL,
    texto_comentario TEXT NOT NULL,
    id_origen INT NOT NULL,
    tipo_origen VARCHAR(20) NOT NULL,
    estado CHAR(1) NOT NULL,
    id_usuario INT NOT NULL,
    id_comentario_padre INT NOT NULL,
    PRIMARY KEY (id_comentario),
    FOREIGN KEY (id_usuario) REFERENCES Usuario (id_usuario),
    FOREIGN KEY (id_comentario_padre) REFERENCES Comentario (id_comentario)
);

CREATE TABLE Documento (
    id_documento INT NOT NULL,
    tipo_doc CHAR(20) NOT NULL,
    fecha_generacion DATE NOT NULL,
    PRIMARY KEY (id_documento)
);

CREATE TABLE Estado_oc (
    cod_estado_oc INT NOT NULL,
    nombre_estado_oc CHAR(10) NOT NULL,
    descripción_estado_oc VARCHAR(20) NOT NULL,
    PRIMARY KEY (cod_estado_oc)
);

CREATE TABLE Categoria_servicios (
    cod_categoria VARCHAR(10) NOT NULL,
    nombre_categoria CHAR(15) NOT NULL,
    PRIMARY KEY (cod_categoria)
);

CREATE TABLE Especialidad_equipo (
    cod_especialidad INT NOT NULL,
    nombre_especialidad CHAR(15) NOT NULL,
    PRIMARY KEY (cod_especialidad)
);

CREATE TABLE Satisfacción (
    id_satisfaccion INT NOT NULL,
    nombre_satisfaccion CHAR(20) NOT NULL,
    puntuacion INT NOT NULL,
    PRIMARY KEY (id_satisfaccion)
);

CREATE TABLE Tipo_convocatoria (
    cod_tipo_convocatoria INT NOT NULL,
    tipo_convocatoria CHAR(10) NOT NULL,
    PRIMARY KEY (cod_tipo_convocatoria)
);

CREATE TABLE Validacion_presupuesto (
    id_validacion_presupuesto INT NOT NULL,
    fecha_validacion DATE NOT NULL,
    estado_validacion CHAR(2) NOT NULL,
    id_comentario INT NOT NULL,
    PRIMARY KEY (id_validacion_presupuesto),
    FOREIGN KEY (id_comentario) REFERENCES Comentario (id_comentario)
);

CREATE TABLE Sector_Mercado (
    cod_sector INT NOT NULL,
    nombre_sector CHAR(15) NOT NULL,
    PRIMARY KEY (cod_sector)
);

CREATE TABLE Detalle_presupuesto (
    id_detalle INT NOT NULL,
    concepto VARCHAR(100) NOT NULL,
    costo_total FLOAT NOT NULL,
    mes DATE NOT NULL,
    PRIMARY KEY (id_detalle)
);

CREATE TABLE Recurso_asignado (
    id_recurso INT NOT NULL,
    costo_total FLOAT NOT NULL,
    meses INT NOT NULL,
    tarifa FLOAT NOT NULL,
    rol_tecnico CHAR(2) NOT NULL,
    horas INT NOT NULL,
    PRIMARY KEY (id_recurso)
);

CREATE TABLE Modulo (
    id_modulo INT NOT NULL,
    nombre CHAR(50) NOT NULL,
    descripcion VARCHAR(100) NOT NULL,
    recursos VARCHAR(100) NOT NULL,
    dependencias VARCHAR(100) NOT NULL,
    funciones TEXT NOT NULL,
    PRIMARY KEY (id_modulo)
);

CREATE TABLE Hito (
    id_hito INT NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    descripcion VARCHAR(10) NOT NULL,
    fecha DATE NOT NULL,
    orden INT NOT NULL,
    PRIMARY KEY (id_hito)
);

CREATE TABLE Presupuesto_propuesta (
    id_presupuesto INT NOT NULL,
    costo_total FLOAT NOT NULL,
    fecha_elaboracion DATE NOT NULL,
    id_validacion_presupuesto INT NOT NULL,
    id_detalle INT NOT NULL,
    id_recurso INT NOT NULL,
    id_documento INT NOT NULL,
    PRIMARY KEY (id_presupuesto),
    FOREIGN KEY (id_validacion_presupuesto) REFERENCES Validacion_presupuesto (id_validacion_presupuesto),
    FOREIGN KEY (id_detalle) REFERENCES Detalle_presupuesto (id_detalle),
    FOREIGN KEY (id_recurso) REFERENCES Recurso_asignado (id_recurso),
    FOREIGN KEY (id_documento) REFERENCES Documento (id_documento)
);

CREATE TABLE Respuesta_cliente (
    id_respuesta_ INT NOT NULL,
    tipo_respuesta INT NOT NULL,
    comentarios VARCHAR(500) NOT NULL,
    fecha_respuesta DATE NOT NULL,
    PRIMARY KEY (id_respuesta_)
);

CREATE TABLE Alternativas (
    id_alternativa INT NOT NULL,
    tipo_alternativa CHAR(20) NOT NULL,
    descripcion_alternativa VARCHAR(100) NOT NULL,
    costo_estimado_requerimiento FLOAT NOT NULL,
    tiempo_extra_requerido FLOAT NOT NULL,
    fecha_propuesta_a DATE NOT NULL,
    fecha_aprobacion_cliente_a DATE NOT NULL,
    PRIMARY KEY (id_alternativa)
);

CREATE TABLE Opciones_comerciales (
    id_opciones_comerciales INT NOT NULL,
    tipo_opcion CHAR(8) NOT NULL,
    detalle_opcion VARCHAR(20) NOT NULL,
    impacto_plazo VARCHAR(20) NOT NULL,
    nueva_estimacion_costo FLOAT NOT NULL,
    fecha_propuesta_o DATE NOT NULL,
    fecha_aprobacion_cliente_o DATE NOT NULL,
    PRIMARY KEY (id_opciones_comerciales)
);

CREATE TABLE Personal_asignado (
    id_personal_asignado INT NOT NULL,
    nombre_personal CHAR(20) NOT NULL,
    telefono__personal INT NOT NULL,
    disponibilidad_personal VARCHAR(20) NOT NULL,
    fecha_asignacion DATE NOT NULL,
    id_rol INT NOT NULL,
    PRIMARY KEY (id_personal_asignado),
    FOREIGN KEY (id_rol) REFERENCES Rol (id_rol)
);

CREATE TABLE Cátalogo_servicios (
    id_servicio INT NOT NULL,
    nombre CHAR(20) NOT NULL,
    cod_categoria VARCHAR(10) NOT NULL,
    PRIMARY KEY (id_servicio),
    FOREIGN KEY (cod_categoria) REFERENCES Categoria_servicios (cod_categoria)
);

CREATE TABLE Empresa (
    id_empresa INT NOT NULL,
    nombre_empresa CHAR(20) NOT NULL,
    tamaño_empresa INT NOT NULL,
    telefono_empresa INT NOT NULL,
    web_corporativa VARCHAR(20) NOT NULL,
    ranklng INT NOT NULL,
    cod_sector INT NOT NULL,
    PRIMARY KEY (id_empresa),
    FOREIGN KEY (cod_sector) REFERENCES Sector_Mercado (cod_sector)
);

CREATE TABLE Solicitud_web (
    id_solicitud_web INT NOT NULL,
    nombre_solicitante CHAR(20) NOT NULL,
    apellido_solicitante CHAR(20) NOT NULL,
    telefono_solicitante INT NOT NULL,
    correo_solicitante VARCHAR(20) NOT NULL,
    fecha_envio DATE NOT NULL,
    estado_solicitud VARCHAR NOT NULL,
    id_empresa INT NOT NULL,
    PRIMARY KEY (id_solicitud_web),
    FOREIGN KEY (id_empresa) REFERENCES Empresa (id_empresa)
);

CREATE TABLE Asignación_recurso (
    id_asignacion_r INT NOT NULL,
    descripcion VARCHAR(100) NOT NULL,
    fecha_asignacion DATE NOT NULL,
    duracion FLOAT NOT NULL,
    id_personal_asignado INT NOT NULL,
    PRIMARY KEY (id_asignacion_r),
    FOREIGN KEY (id_personal_asignado) REFERENCES Personal_asignado (id_personal_asignado)
);

CREATE TABLE Cliente (
    id_cliente INT NOT NULL,
    direccion VARCHAR(20) NOT NULL,
    nombre CHAR(10) NOT NULL,
    cant_contratos INT NOT NULL,
    num_ruc INT NOT NULL,
    fecha_primera_compra DATE NOT NULL,
    id_usuario INT NOT NULL,
    id_satisfaccion INT NOT NULL,
    id_empresa INT NOT NULL,
    id_respuesta_ INT NOT NULL,
    PRIMARY KEY (id_cliente),
    FOREIGN KEY (id_usuario) REFERENCES Usuario (id_usuario),
    FOREIGN KEY (id_satisfaccion) REFERENCES Satisfacción (id_satisfaccion),
    FOREIGN KEY (id_empresa) REFERENCES Empresa (id_empresa),
    FOREIGN KEY (id_respuesta_) REFERENCES Respuesta_cliente (id_respuesta_)
);

CREATE TABLE Requisitos (
    id_requisitos INT NOT NULL,
    descripcion_r VARCHAR(20) NOT NULL,
    prioridad_requisito INT NOT NULL,
    fecha_registro DATE NOT NULL,
    estado_r CHAR(8) NOT NULL,
    historial_cambios VARCHAR(20) NOT NULL,
    fecha_actualizacion DATE NOT NULL,
    id_cliente INT NOT NULL,
    PRIMARY KEY (id_requisitos),
    FOREIGN KEY (id_cliente) REFERENCES Cliente (id_cliente)
);

CREATE TABLE Revisión_de_requisitos (
    id_revision_r INT NOT NULL,
    fecha_revision_requisitos DATE NOT NULL,
    medio_de_aclaracion VARCHAR(15) NOT NULL,
    nombre_revisor CHAR(8) NOT NULL,
    estado_requisitos CHAR(8) NOT NULL,
    feedback_cliente VARCHAR(200) NOT NULL,
    propuesta_modificada_ VARCHAR(100) NOT NULL,
    id_requisitos INT NOT NULL,
    PRIMARY KEY (id_revision_r),
    FOREIGN KEY (id_requisitos) REFERENCES Requisitos (id_requisitos)
);

CREATE TABLE Trazabilidad (
    id_trazabilidad INT NOT NULL,
    tipo_evento INT NOT NULL,
    fecha_evento DATE NOT NULL,
    descripción_evento VARCHAR(200) NOT NULL,
    id_requisitos INT NOT NULL,
    id_usuario INT NOT NULL,
    PRIMARY KEY (id_trazabilidad),
    FOREIGN KEY (id_requisitos) REFERENCES Requisitos (id_requisitos),
    FOREIGN KEY (id_usuario) REFERENCES Usuario (id_usuario)
);

CREATE TABLE Viabilidad_tecnica_requisitos (
    id_viabilidad_r INT NOT NULL,
    notas VARCHAR(80) NOT NULL,
    fecha_evaluacion DATE NOT NULL,
    resultado_viabilidad VARCHAR(15) NOT NULL,
    id_requisitos INT NOT NULL,
    id_personal_asignado INT NOT NULL,
    id_alternativa INT NOT NULL,
    id_documento INT NOT NULL,
    PRIMARY KEY (id_viabilidad_r),
    FOREIGN KEY (id_requisitos) REFERENCES Requisitos (id_requisitos),
    FOREIGN KEY (id_personal_asignado) REFERENCES Personal_asignado (id_personal_asignado),
    FOREIGN KEY (id_alternativa) REFERENCES Alternativas (id_alternativa),
    FOREIGN KEY (id_documento) REFERENCES Documento (id_documento)
);

CREATE TABLE Evaluacion_financiera_requisitos (
    id_evaluacion_f INT NOT NULL,
    ajuste_presupuestal_necesario VARCHAR(20) NOT NULL,
    costo_estimado_total FLOAT NOT NULL,
    fecha_evaluacion_f DATE NOT NULL,
    monto_ajustado FLOAT NOT NULL,
    id_requisitos INT NOT NULL,
    id_opciones_comerciales INT NOT NULL,
    id_documento INT NOT NULL,
    PRIMARY KEY (id_evaluacion_f),
    FOREIGN KEY (id_requisitos) REFERENCES Requisitos (id_requisitos),
    FOREIGN KEY (id_opciones_comerciales) REFERENCES Opciones_comerciales (id_opciones_comerciales),
    FOREIGN KEY (id_documento) REFERENCES Documento (id_documento)
);

CREATE TABLE Notificación (
    id_notificacion INT NOT NULL,
    mensaje TEXT NOT NULL,
    fecha_envio DATE NOT NULL,
    estado_notificacion CHAR(15) NOT NULL,
    id_cliente INT NOT NULL,
    id_requisitos INT NOT NULL,
    PRIMARY KEY (id_notificacion),
    FOREIGN KEY (id_cliente) REFERENCES Cliente (id_cliente),
    FOREIGN KEY (id_requisitos) REFERENCES Requisitos (id_requisitos)
);

CREATE TABLE Auditoría (
    id_auditoria INT NOT NULL,
    fecha_aud DATE NOT NULL,
    id_cliente INT NOT NULL,
    id_requisitos INT NOT NULL,
    PRIMARY KEY (id_auditoria),
    FOREIGN KEY (id_cliente) REFERENCES Cliente (id_cliente),
    FOREIGN KEY (id_requisitos) REFERENCES Requisitos (id_requisitos)
);

CREATE TABLE Validacion_detalles_tecnicos (
    id_validacion_detalles INT NOT NULL,
    estado_validacion CHAR(2) NOT NULL,
    fecha_validacion DATE NOT NULL,
    id_comentario INT NOT NULL,
    PRIMARY KEY (id_validacion_detalles),
    FOREIGN KEY (id_comentario) REFERENCES Comentario (id_comentario)
);

CREATE TABLE Detalles_tecnicos (
    id_detalle_tecnico INT NOT NULL,
    arquitectura VARCHAR(50) NOT NULL,
    metodologia CHAR(2) NOT NULL,
    integraciones VARCHAR(100) NOT NULL,
    id_modulo INT NOT NULL,
    id_hito INT NOT NULL,
    id_validacion_detalles INT NOT NULL,
    id_documento INT NOT NULL,
    PRIMARY KEY (id_detalle_tecnico),
    FOREIGN KEY (id_modulo) REFERENCES Modulo (id_modulo),
    FOREIGN KEY (id_hito) REFERENCES Hito (id_hito),
    FOREIGN KEY (id_validacion_detalles) REFERENCES Validacion_detalles_tecnicos (id_validacion_detalles),
    FOREIGN KEY (id_documento) REFERENCES Documento (id_documento)
);

CREATE TABLE Propuesta (
    id_propuesta INT NOT NULL,
    titulo_propuesta VARCHAR(50) NOT NULL,
    descripcion_propuesta VARCHAR(100) NOT NULL,
    fecha_propuesta DATE NOT NULL,
    estado_prouesta CHAR(2) NOT NULL,
    satisface_requisitos CHAR(2) NOT NULL,
    id_detalle_tecnico INT NOT NULL,
    id_presupuesto INT NOT NULL,
    id_respuesta_ INT NOT NULL,
    id_requisitos INT NOT NULL,
    PRIMARY KEY (id_propuesta),
    FOREIGN KEY (id_detalle_tecnico) REFERENCES Detalles_tecnicos (id_detalle_tecnico),
    FOREIGN KEY (id_presupuesto) REFERENCES Presupuesto_propuesta (id_presupuesto),
    FOREIGN KEY (id_respuesta_) REFERENCES Respuesta_cliente (id_respuesta_),
    FOREIGN KEY (id_requisitos) REFERENCES Requisitos (id_requisitos)
);

CREATE TABLE Solicitud (
    id_solicitud VARCHAR(20) NOT NULL,
    descripción_solicitud VARCHAR(100) NOT NULL,
    fecha_solicitud DATE NOT NULL,
    fecha_firma DATE NOT NULL,
    id_cliente INT NOT NULL,
    PRIMARY KEY (id_solicitud),
    FOREIGN KEY (id_cliente) REFERENCES Cliente (id_cliente)
);

CREATE TABLE Contrato (
    cod_contrato INT NOT NULL,
    nombre_contrato CHAR(20) NOT NULL,
    monto FLOAT NOT NULL,
    contenido TEXT NOT NULL,
    condiciones_contrato TEXT NOT NULL,
    id_contrato INT NOT NULL,
    fecha_contrato DATE NOT NULL,
    id_version INT NOT NULL,
    id_solicitud VARCHAR(20) NOT NULL,
    PRIMARY KEY (id_contrato),
    FOREIGN KEY (id_version) REFERENCES Version_contrato (id_version),
    FOREIGN KEY (id_solicitud) REFERENCES Solicitud (id_solicitud)
);

CREATE TABLE proyecto (
    cod_proyecto INT NOT NULL,
    nombre_proyecto CHAR(20) NOT NULL,
    descripción_proyecto VARCHAR(50) NOT NULL,
    presupuesto FLOAT NOT NULL,
    estado_proyecto INT NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NOT NULL,
    id_solicitud VARCHAR(20) NOT NULL,
    cod_sector INT NOT NULL,
    PRIMARY KEY (cod_proyecto),
    FOREIGN KEY (id_solicitud) REFERENCES Solicitud (id_solicitud),
    FOREIGN KEY (cod_sector) REFERENCES Sector_Mercado (cod_sector)
);

CREATE TABLE Proyecto_servicio (
    id_servicio INT NOT NULL,
    cod_proyecto INT NOT NULL,
    FOREIGN KEY (id_servicio) REFERENCES Cátalogo_servicios (id_servicio),
    FOREIGN KEY (cod_proyecto) REFERENCES proyecto (cod_proyecto)
);

CREATE TABLE Termino (
    id_termino INT NOT NULL,
    descripcion_term TEXT NOT NULL,
    estado_term CHAR(8) NOT NULL,
    id_contrato INT NOT NULL,
    PRIMARY KEY (id_termino),
    FOREIGN KEY (id_contrato) REFERENCES Contrato (id_contrato)
);

CREATE TABLE Gerente_Comercial (
    id_gerente_comercial INT NOT NULL,
    nombre_gerente CHAR(20) NOT NULL,
    telefono_gerente INT NOT NULL,
    correo_gerente VARCHAR(20) NOT NULL,
    id_usuario INT NOT NULL,
    id_validacion_presupuesto INT NOT NULL,
    PRIMARY KEY (id_gerente_comercial),
    FOREIGN KEY (id_usuario) REFERENCES Usuario (id_usuario),
    FOREIGN KEY (id_validacion_presupuesto) REFERENCES Validacion_presupuesto (id_validacion_presupuesto)
);

CREATE TABLE Ejecutivo_Comercial (
    id_ejecutivo_comercial INT NOT NULL,
    nombre_ejecutivo CHAR(15) NOT NULL,
    telefono_ejecutivo INT NOT NULL,
    correo_ejecutivo VARCHAR(20) NOT NULL,
    id_usuario INT NOT NULL,
    id_termino INT NOT NULL,
    PRIMARY KEY (id_ejecutivo_comercial),
    FOREIGN KEY (id_usuario) REFERENCES Usuario (id_usuario),
    FOREIGN KEY (id_termino) REFERENCES Termino (id_termino)
);

CREATE TABLE Contacto (
    id_contacto INT NOT NULL,
    nombre_contacto CHAR(15) NOT NULL,
    email_contacto VARCHAR(20) NOT NULL,
    telefono_contacto INT NOT NULL,
    cargo_contacto CHAR(10) NOT NULL,
    origen CHAR(10) NOT NULL,
    id_empresa INT NOT NULL,
    id_ejecutivo_comercial INT NOT NULL,
    PRIMARY KEY (id_contacto),
    FOREIGN KEY (id_empresa) REFERENCES Empresa (id_empresa),
    FOREIGN KEY (id_ejecutivo_comercial) REFERENCES Ejecutivo_Comercial (id_ejecutivo_comercial)
);

CREATE TABLE Visita (
    id_visita INT NOT NULL,
    fecha_hora_visita DATE NOT NULL,
    notas_visita VARCHAR(20) NOT NULL,
    lugar_visita VARCHAR(20) NOT NULL,
    estado_visita CHAR(10) NOT NULL,
    id_empresa INT NOT NULL,
    id_ejecutivo_comercial INT NOT NULL,
    PRIMARY KEY (id_visita),
    FOREIGN KEY (id_empresa) REFERENCES Empresa (id_empresa),
    FOREIGN KEY (id_ejecutivo_comercial) REFERENCES Ejecutivo_Comercial (id_ejecutivo_comercial)
);

CREATE TABLE Agenda_ec (
    agenda_ec CHAR(10) NOT NULL,
    fecha_dispo DATE NOT NULL,
    inicio_dispo TIME NOT NULL,
    final_dispo TIME NOT NULL,
    estado_agenda CHAR(10) NOT NULL,
    id_ejecutivo_comercial INT NOT NULL,
    PRIMARY KEY (agenda_ec),
    FOREIGN KEY (id_ejecutivo_comercial) REFERENCES Ejecutivo_Comercial (id_ejecutivo_comercial)
);

CREATE TABLE Dolor (
    id_dolor INT NOT NULL,
    nombre_dolor CHAR(15) NOT NULL,
    industria VARCHAR(15) NOT NULL,
    id_cliente INT NOT NULL,
    id_ejecutivo_comercial INT NOT NULL,
    id_visita INT NOT NULL,
    PRIMARY KEY (id_dolor),
    FOREIGN KEY (id_cliente) REFERENCES Cliente (id_cliente),
    FOREIGN KEY (id_ejecutivo_comercial) REFERENCES Ejecutivo_Comercial (id_ejecutivo_comercial),
    FOREIGN KEY (id_visita) REFERENCES Visita (id_visita)
);

CREATE TABLE Convocatoria (
    id_convocatoria INT NOT NULL,
    fecha_publicacon DATE NOT NULL,
    fecha_limite DATE NOT NULL,
    es_formal BOOLEAN NOT NULL,
    id_dolor INT NOT NULL,
    cod_tipo_convocatoria INT NOT NULL,
    PRIMARY KEY (id_convocatoria),
    FOREIGN KEY (id_dolor) REFERENCES Dolor (id_dolor),
    FOREIGN KEY (cod_tipo_convocatoria) REFERENCES Tipo_convocatoria (cod_tipo_convocatoria)
);

CREATE TABLE Viabilidad_tecnica (
    id_viabilidad_tecnica INT NOT NULL,
    hay_experiencia BOOLEAN NOT NULL,
    es_viable BOOLEAN NOT NULL,
    comentario VARCHAR(500) NOT NULL,
    id_dolor INT NOT NULL,
    PRIMARY KEY (id_viabilidad_tecnica),
    FOREIGN KEY (id_dolor) REFERENCES Dolor (id_dolor)
);

CREATE TABLE Equipo_técnico (
    id_equipo VARCHAR(20) NOT NULL,
    nombre_equipo_tecnico CHAR(20) NOT NULL,
    capacidad INT NOT NULL,
    cod_especialidad INT NOT NULL,
    id_propuesta INT NOT NULL,
    id_validacion_detalles INT NOT NULL,
    PRIMARY KEY (id_equipo),
    FOREIGN KEY (cod_especialidad) REFERENCES Especialidad_equipo (cod_especialidad),
    FOREIGN KEY (id_propuesta) REFERENCES Propuesta (id_propuesta),
    FOREIGN KEY (id_validacion_detalles) REFERENCES Validacion_detalles_tecnicos (id_validacion_detalles)
);

CREATE TABLE Partner (
    id_partner INT NOT NULL,
    nombre_contacto CHAR(25) NOT NULL,
    telefono_contacto INT NOT NULL,
    correo_contacto VARCHAR(20) NOT NULL,
    especialidad_partner VARCHAR(15) NOT NULL,
    id_dolor INT NOT NULL,
    PRIMARY KEY (id_partner),
    FOREIGN KEY (id_dolor) REFERENCES Dolor (id_dolor)
);

CREATE TABLE Decisor (
    id_decisor INT NOT NULL,
    nombre_decisor CHAR(15) NOT NULL,
    cargo_decisor CHAR(15) NOT NULL,
    telefono_decisor INT NOT NULL,
    correo_decisor VARCHAR(20) NOT NULL,
    RUC_decisor INT NOT NULL,
    direccion_decisor VARCHAR(20) NOT NULL,
    id_dolor INT NOT NULL,
    PRIMARY KEY (id_decisor),
    FOREIGN KEY (id_dolor) REFERENCES Dolor (id_dolor)
);

CREATE TABLE Orden_Compra (
    id_oc INT NOT NULL,
    fecha_oc DATE NOT NULL,
    precio_total FLOAT NOT NULL,
    fecha_entrega DATE NOT NULL,
    id_solicitud VARCHAR(20) NOT NULL,
    id_servicio INT NOT NULL,
    cod_estado_oc INT NOT NULL,
    id_equipo VARCHAR(20) NOT NULL,
    PRIMARY KEY (id_oc),
    FOREIGN KEY (id_solicitud) REFERENCES Solicitud (id_solicitud),
    FOREIGN KEY (id_servicio) REFERENCES Cátalogo_servicios (id_servicio),
    FOREIGN KEY (cod_estado_oc) REFERENCES Estado_oc (cod_estado_oc),
    FOREIGN KEY (id_equipo) REFERENCES Equipo_técnico (id_equipo)
);

CREATE TABLE Detalle_OC (
    items INT NOT NULL,
    precio_unitario FLOAT NOT NULL,
    id_detalle_oc INT NOT NULL,
    subtotal FLOAT NOT NULL,
    direccion_entrega VARCHAR(25) NOT NULL,
    id_oc INT NOT NULL,
    PRIMARY KEY (id_detalle_oc),
    FOREIGN KEY (id_oc) REFERENCES Orden_Compra (id_oc)
);

CREATE TABLE Dolor_equipo_tecnico (
    fecha_asignacion DATE NOT NULL,
    id_dolor INT NOT NULL,
    id_equipo VARCHAR(20) NOT NULL,
    PRIMARY KEY (id_dolor, id_equipo),
    FOREIGN KEY (id_dolor) REFERENCES Dolor (id_dolor),
    FOREIGN KEY (id_equipo) REFERENCES Equipo_técnico (id_equipo)
);

CREATE TABLE Encargo_comercial (
    id_encargo INT NOT NULL,
    nombre_encargo CHAR(10) NOT NULL,
    fecha_asignacion DATE NOT NULL,
    estado_encargo CHAR(10) NOT NULL,
    fecha_termino DATE NOT NULL,
    id_responsable INT NOT NULL,
    id_asignador INT NOT NULL,
    PRIMARY KEY (id_encargo),
    FOREIGN KEY (id_responsable) REFERENCES Ejecutivo_Comercial (id_ejecutivo_comercial),
    FOREIGN KEY (id_asignador) REFERENCES Gerente_Comercial (id_gerente_comercial)
);

CREATE TABLE Encargo_proyecto (
    id_encargo INT NOT NULL,
    cod_proyecto INT NOT NULL,
    FOREIGN KEY (id_encargo) REFERENCES Encargo_comercial (id_encargo),
    FOREIGN KEY (cod_proyecto) REFERENCES proyecto (cod_proyecto)
);

CREATE TABLE Entregable_experiencia (
    id_entregable INT NOT NULL,
    nombre_archivo CHAR(20) NOT NULL,
    ruta_archivo VARCHAR(20) NOT NULL,
    fecha_entrega DATE NOT NULL,
    descripcion_entregable VARCHAR(50) NOT NULL,
    id_encargo INT NOT NULL,
    PRIMARY KEY (id_entregable),
    FOREIGN KEY (id_encargo) REFERENCES Encargo_comercial (id_encargo)
);

CREATE TABLE Comentario_encargo (
    id_comentario_enc INT NOT NULL,
    fecha DATE NOT NULL,
    contenido VARCHAR(200) NOT NULL,
    id_encargo INT NOT NULL,
    PRIMARY KEY (id_comentario_enc),
    FOREIGN KEY (id_encargo) REFERENCES Encargo_comercial (id_encargo)
);

CREATE TABLE Conversación_preventa (
    tipo_conversacion CHAR(15) NOT NULL,
    Asunto VARCHAR(40) NOT NULL,
    fecha_inicio DATE NOT NULL,
    id_conversacion_pre INT NOT NULL,
    id_ejecutivo_comercial INT NOT NULL,
    id_entregable INT NOT NULL,
    id_contacto INT NOT NULL,
    PRIMARY KEY (id_conversacion_pre),
    FOREIGN KEY (id_ejecutivo_comercial) REFERENCES Ejecutivo_Comercial (id_ejecutivo_comercial),
    FOREIGN KEY (id_entregable) REFERENCES Entregable_experiencia (id_entregable),
    FOREIGN KEY (id_contacto) REFERENCES Contacto (id_contacto)
);

CREATE TABLE Mensaje (
    id_mensaje INT NOT NULL,
    contenido_mensaje VARCHAR(200) NOT NULL,
    fecha_hora_envio DATE NOT NULL,
    id_conversacion_pre INT NOT NULL,
    PRIMARY KEY (id_mensaje),
    FOREIGN KEY (id_conversacion_pre) REFERENCES Conversación_preventa (id_conversacion_pre)
);

CREATE TABLE Reunion (
    id_reunion INT NOT NULL,
    hora_inicio TIME NOT NULL,
    hora_final TIME NOT NULL,
    fecha_re DATE NOT NULL,
    resumen_re VARCHAR(100) NOT NULL,
    modalidad_re CHAR(1) NOT NULL,
    lugar_re CHAR(100) NOT NULL,
    estado_re CHAR(2) NOT NULL,
    id_ejecutivo_comercial INT NOT NULL,
    id_cliente INT NOT NULL,
    id_propuesta INT NOT NULL,
    PRIMARY KEY (id_reunion),
    FOREIGN KEY (id_ejecutivo_comercial) REFERENCES Ejecutivo_Comercial (id_ejecutivo_comercial),
    FOREIGN KEY (id_cliente) REFERENCES Cliente (id_cliente),
    FOREIGN KEY (id_propuesta) REFERENCES Propuesta (id_propuesta)
);

CREATE TABLE Ajuste (
    id_ajuste VARCHAR(15) NOT NULL,
    tipo_ajuste CHAR(10) NOT NULL,
    descripcion_ajsute VARCHAR(200) NOT NULL,
    estado_ajuste CHAR(8) NOT NULL,
    id_termino INT NOT NULL,
    id_propuesta INT NOT NULL,
    PRIMARY KEY (id_ajuste),
    FOREIGN KEY (id_termino) REFERENCES Termino (id_termino),
    FOREIGN KEY (id_propuesta) REFERENCES Propuesta (id_propuesta)
);