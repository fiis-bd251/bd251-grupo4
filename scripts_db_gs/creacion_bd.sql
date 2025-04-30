-- Eliminar la base de datos si ya existe
 DROP DATABASE IF EXISTS gestion_sistemas;
 
 -- Crear la base de datos con configuración regional adecuada
 CREATE DATABASE gestion_sistemas
 WITH
     OWNER = postgres ENCODING = 'UTF8' LC_COLLATE = 'es_PE.UTF-8' LC_CTYPE = 'es_PE.UTF-8' LOCALE_PROVIDER = 'libc' CONNECTION
 LIMIT = -1 IS_TEMPLATE = false TEMPLATE template0;