create schema proyecto_formula1;

use proyecto_formula1;


create table if not exists equipos( 
id_equipo int AUTO_INCREMENT PRIMARY KEY,
nombre_equipo varchar (60) NOT NULL,
pais_equipo varchar (60) NOT NULL, 
año_ingreso date NOT null,
año_retiro date NOT null) ;


create table if not exists pilotos(
id_piloto int auto_increment primary key,
nombre_piloto varchar (45) not null,
apellido_piloto varchar (45) not null,
fecha_nacimiento date not null,
pais_origen varchar (3) not null,
año_ingreso date not null,
año_retiro date,
id_equipoingreso int not null,
año_cambioequipo date,
id_equipocambio int,
id_equipoactual int not null,
foreign key (id_equipoingreso) references equipos (id_equipo),
foreign key (id_equipocambio) references  equipos (id_equipo),
foreign key (id_equipoactual) references equipos (id_equipo)
);


create table if not exists FIA_regulaciones (
id_regulacion int auto_increment primary key,
año date,
area_regulada varchar (50),
especificacion varchar (200)
);


create table if not exists WorldChampionship (
id_WorldChampionship int auto_increment primary key,
año_temporada date not null,
id_pilotoganador int not null,
puntos_totales int,
foreign key (id_pilotoganador) references pilotos(id_piloto)
); 


create table if not exists ConstructorChampionship (
id_ConstructorChampionship int auto_increment primary key,
año_temporada date not null,
id_equipoganador int not null,
puntos_totales int,
foreign key (id_equipoganador) references equipos (id_equipo)
); 


create table if not exists PuntajeWorldChamp_ConstructorChamp (
id_puntaje int auto_increment primary key,
año date,
puntos_puesto1 int not null,
puntos_puesto2 int not null,
puntos_puesto3 int not null,
puntos_puesto4 int not null,
puntos_puesto5 int not null,
puntos_puesto6 int not null,
puntos_puesto7 int not null,
puntos_puesto8 int not null,
puntos_puesto9 int not null,
puntos_puesto10 int not null,
puntos_vueltarapida int,
mejoresresultados_elegibles int not null
);


create table if not exists Circuito (
id_circuito int auto_increment primary key,
nombrecircuito varchar (100),
pais varchar (3),
fecha_inauguracion date,
km_totales int,
km_vuelta int,
km_sector1 int,
km_sector2 int,
km_sector3 int,
curvas_cantidad int,
curvas_aclaracion varchar (200),
rectas_cantidad int,
km_rectalarga int,
fasttime time,
id_pilotoFasttime int,
fastlap time,
id_pilotoFastlap int,
foreign key (id_pilotoFasttime) references pilotos(id_piloto),
foreign key (id_pilotoFastlap) references pilotos(id_piloto)
);


create table if not exists proveedores (
id_proveedor int auto_increment primary key,
nombre_provedor varchar(100) not null,
pais_origen varchar (3) not null,
fecha_ingreso date,
fecha_salida date,
tipo_producto varchar (50) not null,
nombre_producto varchar (100),
especificacion_producto varchar (250)
);


create table if not exists autos (
id_auto int auto_increment primary key,
nombre_auto varchar (50),
id_equipo int not null,
año_temporada date not null,
chasis varchar (160),
id_proveedorchasis int,
motor varchar (180),
id_proveedormotor int,
combustible varchar (100),
id_proveedorcombustible int,
id_proveedorllantas int,
id_ConstructorChamp int,
foreign key (id_equipo) references equipos (id_equipo),
foreign key (id_proveedorchasis) references proveedores (id_proveedor),
foreign key (id_proveedormotor) references proveedores (id_proveedor),
foreign key (id_proveedorcombustible) references proveedores (id_proveedor),
foreign key (id_proveedorllantas) references proveedores (id_proveedor),
foreign key (id_ConstructorChamp) references ConstructorChampionship (id_ConstructorChampionship)
);


create table if not exists equipo_tecnico (
id_equipotecnico int auto_increment primary key,
año date not null,
id_equipo int not null,
teamchief varchar (50) not null,
technicalchief varchar (50) not null,
id_auto int not null,
id_piloto1 int not null,
id_piloto2 int not null,
id_proveedormotor int not null,
id_proveedorllantas int not null,
id_proveedorcombustible int not null,
foreign key (id_equipo) references equipos (id_equipo),
foreign key (id_auto) references autos (id_auto),
foreign key (id_piloto1) references pilotos(id_piloto),
foreign key (id_piloto2) references pilotos(id_piloto),
foreign key (id_proveedormotor) references proveedores (id_proveedor),
foreign key (id_proveedorllantas) references proveedores (id_proveedor),
foreign key (id_proveedorcombustible) references proveedores (id_proveedor)
);


create table if not exists incidentes_banderas (
id_indicidente int auto_increment primary key,
id_circuito int not null,
sector int,
tiempo_carrera time,
incidente varchar (100) not null,
id_equipoimplicado1 int not null,
id_pilotoimplicado1 int,
id_pilotoimplicado2 int,
id_equipoimplicado2 int not null,
id_pilotoimplicado3 int,
id_equipoimplicado3 int not null,
bandera varchar (50) not null,
safetycar bool not null,
safetycar_vueltaentra int not null,
safectycar_vueltasale int not null,
suspecioncarrera bool not null,
foreign key (id_circuito) references Circuito (id_circuito),
foreign key (id_equipoimplicado1) references equipos (id_equipo),
foreign key (id_equipoimplicado2) references equipos (id_equipo),
foreign key (id_equipoimplicado3) references equipos (id_equipo),
foreign key (id_pilotoimplicado1) references pilotos(id_piloto),
foreign key (id_pilotoimplicado2) references pilotos(id_piloto),
foreign key (id_pilotoimplicado3) references pilotos(id_piloto)
);


create table if not exists GrandPrix (
id_GrandPrix int auto_increment primary key,
id_WorldChampionship int,
año_temporada date not null,
id_circuito int not null,
pais varchar (3) not null,
fehca date not null,
hora_iniciocarrera time,
hora_fincarrera time,
id_incidentes int not null,
fastlap_tiempo time,
id_pilotofastlap int,
fasttime time not null,
foreign key (id_WorldChampionship) references WorldChampionship (id_WorldChampionship),
foreign key (id_circuito) references Circuito (id_circuito), 
foreign key (id_incidentes) references incidentes_banderas (id_indicidente),
foreign key (id_pilotofastlap) references pilotos(id_piloto)
); 


create table if not exists posiciones_carrera (
id_posiciones int auto_increment primary key,
id_WordChampionship int,
id_GrandPrix int not null,
id_circuito int not null,
id_PilotoPuesto1 int,
id_PilotoPuesto2 int,
id_PilotoPuesto3 int,
id_PilotoPuesto4 int,
id_PilotoPuesto5 int,
id_PilotoPuesto6 int,
id_PilotoPuesto7 int,
id_PilotoPuesto8 int,
id_PilotoPuesto9 int,
id_PilotoPuesto10 int,
idPilotoFastLap int,
foreign key (id_WordChampionship) references  WorldChampionship (id_WorldChampionship),
foreign key (id_GrandPrix) references GrandPrix (id_GrandPrix),
foreign key (id_circuito) references Circuito (id_circuito),
foreign key (id_PilotoPuesto1) references pilotos(id_piloto),
foreign key (id_PilotoPuesto2) references pilotos(id_piloto),
foreign key (id_PilotoPuesto3) references pilotos(id_piloto),
foreign key (id_PilotoPuesto4) references pilotos(id_piloto),
foreign key (id_PilotoPuesto5) references pilotos(id_piloto),
foreign key (id_PilotoPuesto6) references pilotos(id_piloto),
foreign key (id_PilotoPuesto7) references pilotos(id_piloto),
foreign key (id_PilotoPuesto8) references pilotos(id_piloto),
foreign key (id_PilotoPuesto9) references pilotos(id_piloto),
foreign key (id_PilotoPuesto10) references pilotos(id_piloto),
foreign key (idPilotoFastLap) references pilotos(id_piloto)
);

create table if not exists penalizacion (
id_penalizacion int auto_increment primary key,
id_GrandPrix int not null,
id_incidente int not null,
vuleta int,
especificacion varchar (150) not null,
id_piloto int not null,
desicion varchar (150) not null,
tiempo_penalizacion int not null,
altera_posicionfinal bool not null,
foreign key (id_GrandPrix) references GrandPrix (id_GrandPrix)
);
 
create table if not exists condicion_climatica (
id_clima int auto_increment primary key,
id_GrandPrix int not null,
caracteristica varchar (50) not null,
temperatura_maxima_cel int not null,
temperatura_minima_cel int not null,
sensacion_termica_cel int not null,
humedad int not null,
presion_atmosferica_hPa int not null,
viento_km_s int not null,
viento_dirección varchar (3) not null,
precipitaciones bool not null,
precipitaciones_mm int not null,
visibilidad_mts int not null,
foreign key (id_GrandPrix) references GrandPrix (id_GrandPrix)
);
 
 
alter table FIA_regulaciones
 add vigencia bool not null;
 
 alter table FIA_regulaciones
 add año_baja date not null;
 
 
 alter table GrandPrix 
 add condicion_climatica int not null;
 
 alter table GrandPrix
 add foreign key (condicion_climatica) references condicion_climatica (id_clima);