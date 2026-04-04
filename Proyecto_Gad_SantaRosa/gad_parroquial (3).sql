-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3306
-- Tiempo de generación: 04-04-2026 a las 19:02:24
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `gad_parroquial`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ciudadano`
--

CREATE TABLE `ciudadano` (
  `cedula_ciudadano` varchar(10) NOT NULL COMMENT 'Llave Primaria. Cédula de identidad (10 dígitos). Es el identificador único de cada habitante.',
  `nombre` varchar(100) DEFAULT NULL COMMENT 'Nombres y apellidos completos del solicitante para registros oficiales.',
  `contacto` varchar(20) DEFAULT NULL COMMENT 'Número de teléfono (celular o fijo) para notificar el avance del trámite.',
  `direccion` varchar(150) DEFAULT NULL COMMENT 'Domicilio actual del ciudadano dentro de la parroquia.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `ciudadano`
--

INSERT INTO `ciudadano` (`cedula_ciudadano`, `nombre`, `contacto`, `direccion`) VALUES
('1500725906', 'Fernanda Torres', '0981621464', 'La planada'),
('1501038465', 'Esteban Rodriguez', '0982521271', 'El Chaco - Santa Rosa'),
('1550561867', 'Liam Rodriguez', '0123456789', NULL),
('1760161867', 'Keiko Yanacallo', '0959114687', 'El chaco Santa Rosa-Tres Cruces');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empleado`
--

CREATE TABLE `empleado` (
  `cedula_empleado` varchar(10) NOT NULL COMMENT 'Llave Primaria. Identificación del funcionario del GAD responsable de la gestión.',
  `nombre` varchar(100) DEFAULT NULL COMMENT 'Nombre completo del servidor público encargado del área administrativa.',
  `cargo` varchar(50) DEFAULT NULL COMMENT 'Puesto administrativo (Secretaria).',
  `contacto` varchar(20) DEFAULT NULL COMMENT 'Teléfono de oficina o extensión para comunicación interna.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `empleado`
--

INSERT INTO `empleado` (`cedula_empleado`, `nombre`, `cargo`, `contacto`) VALUES
('1500973589', 'Yessenia Torres', 'Secretaria', '0996872593'),
('1505047643', 'Liam Nacimba', 'Tesorero', '0982521374');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pago`
--

CREATE TABLE `pago` (
  `id_pago` int(11) NOT NULL COMMENT 'Llave Primaria. Número de comprobante de ingreso emitido por tesorería.',
  `monto` decimal(10,2) DEFAULT NULL COMMENT 'Valor económico del trámite en dólares americanos.',
  `fecha_pago` date DEFAULT NULL COMMENT 'Fecha en la que se realizó la recaudación del valor adeudado.',
  `id_tramite` int(11) DEFAULT NULL COMMENT 'Llave Foránea (Única). Enlace al trámite específico; un trámite solo genera un pago.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tramite`
--

CREATE TABLE `tramite` (
  `id_tramite` int(11) NOT NULL COMMENT 'Llave Primaria. Número de expediente generado automáticamente por el sistema.',
  `tipo_tramite` varchar(100) DEFAULT NULL COMMENT 'Descripción del servicio (ej. Certificado de residencia, Uso de suelo).',
  `fecha_solicitud` date DEFAULT NULL COMMENT 'Fecha exacta en la que el ciudadano ingresó la documentación.',
  `estado` varchar(20) DEFAULT NULL COMMENT 'Situación actual del proceso: ''Pendiente'', ''En proceso'' o ''Finalizado''.',
  `cedula_ciudadano` varchar(10) DEFAULT NULL COMMENT 'Llave Foránea. Vincula el trámite con el ciudadano que lo solicita.',
  `cedula_empleado` varchar(10) DEFAULT NULL COMMENT 'Llave Foránea. Identifica al empleado responsable de dar trámite a la solicitud.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tramite`
--

INSERT INTO `tramite` (`id_tramite`, `tipo_tramite`, `fecha_solicitud`, `estado`, `cedula_ciudadano`, `cedula_empleado`) VALUES
(1, 'Certificado de Residencia', '2026-03-26', 'Pendiente', '1501038465', '1500973589'),
(2, 'Certificado de Residencia', '2026-03-26', 'Pendiente', '1501038465', '1500973589'),
(3, 'Alquiler de la maquinaria pesada', '2026-03-27', 'Pendiente', '1760161867', '1500973589');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id_usuario` int(11) NOT NULL,
  `nombre` varchar(100) DEFAULT NULL,
  `mail` varchar(100) DEFAULT NULL,
  `password` varchar(250) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id_usuario`, `nombre`, `mail`, `password`) VALUES
(6, 'yessenia Rodriguez', 'tefatorres24@gmail.com', 'scrypt:32768:8:1$HwcuJrBBWkxJLSI0$020f153a2db00b40f841680905454f2f1b26a17bb8f1cfb8e0e06e1bcc1d769e8de51c71328844493a8120e4d0527f026d465a2477d825f301ee262179055512');

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vista_asignacion_empleados`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vista_asignacion_empleados` (
`empleado` varchar(100)
,`cargo` varchar(50)
,`id_tramite` int(11)
,`tipo_tramite` varchar(100)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vista_detalle_tramite_ciudadano`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vista_detalle_tramite_ciudadano` (
`id_tramite` int(11)
,`ciudadano` varchar(100)
,`tipo_tramite` varchar(100)
,`estado` varchar(20)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vista_detalle_tramite_completo`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vista_detalle_tramite_completo` (
`id_tramite` int(11)
,`nombre_ciudadano` varchar(100)
,`tipo_tramite` varchar(100)
,`estado` varchar(20)
,`fecha_solicitud` date
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vista_directorio_ciudadanos`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vista_directorio_ciudadanos` (
`nombre` varchar(100)
,`contacto` varchar(20)
,`direccion` varchar(150)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vista_ingresos_diarios`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vista_ingresos_diarios` (
`fecha_pago` date
,`total_dia` decimal(32,2)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vista_pagos_detallados`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vista_pagos_detallados` (
`id_pago` int(11)
,`pagado_por` varchar(100)
,`monto` decimal(10,2)
,`fecha_pago` date
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vista_promedio_tasas`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vista_promedio_tasas` (
`promedio_pago_administrativo` decimal(14,6)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vista_recaudacion_total`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vista_recaudacion_total` (
`ingreso_total_historico` decimal(32,2)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vista_resumen_estados`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vista_resumen_estados` (
`estado` varchar(20)
,`total_tramites` bigint(21)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vista_tramites_pagados`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vista_tramites_pagados` (
`id_tramite` int(11)
,`tipo_tramite` varchar(100)
,`monto` decimal(10,2)
,`fecha_pago` date
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vista_tramites_pendientes`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vista_tramites_pendientes` (
`id_tramite` int(11)
,`tipo_tramite` varchar(100)
,`fecha_solicitud` date
,`cedula_ciudadano` varchar(10)
);

-- --------------------------------------------------------

--
-- Estructura para la vista `vista_asignacion_empleados`
--
DROP TABLE IF EXISTS `vista_asignacion_empleados`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vista_asignacion_empleados`  AS SELECT `e`.`nombre` AS `empleado`, `e`.`cargo` AS `cargo`, `t`.`id_tramite` AS `id_tramite`, `t`.`tipo_tramite` AS `tipo_tramite` FROM (`empleado` `e` join `tramite` `t` on(`e`.`cedula_empleado` = `t`.`cedula_empleado`)) ;

-- --------------------------------------------------------

--
-- Estructura para la vista `vista_detalle_tramite_ciudadano`
--
DROP TABLE IF EXISTS `vista_detalle_tramite_ciudadano`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vista_detalle_tramite_ciudadano`  AS SELECT `t`.`id_tramite` AS `id_tramite`, `c`.`nombre` AS `ciudadano`, `t`.`tipo_tramite` AS `tipo_tramite`, `t`.`estado` AS `estado` FROM (`tramite` `t` join `ciudadano` `c` on(`t`.`cedula_ciudadano` = `c`.`cedula_ciudadano`)) ;

-- --------------------------------------------------------

--
-- Estructura para la vista `vista_detalle_tramite_completo`
--
DROP TABLE IF EXISTS `vista_detalle_tramite_completo`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vista_detalle_tramite_completo`  AS SELECT `t`.`id_tramite` AS `id_tramite`, `c`.`nombre` AS `nombre_ciudadano`, `t`.`tipo_tramite` AS `tipo_tramite`, `t`.`estado` AS `estado`, `t`.`fecha_solicitud` AS `fecha_solicitud` FROM (`tramite` `t` join `ciudadano` `c` on(`t`.`cedula_ciudadano` = `c`.`cedula_ciudadano`)) ;

-- --------------------------------------------------------

--
-- Estructura para la vista `vista_directorio_ciudadanos`
--
DROP TABLE IF EXISTS `vista_directorio_ciudadanos`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vista_directorio_ciudadanos`  AS SELECT `ciudadano`.`nombre` AS `nombre`, `ciudadano`.`contacto` AS `contacto`, `ciudadano`.`direccion` AS `direccion` FROM `ciudadano` ;

-- --------------------------------------------------------

--
-- Estructura para la vista `vista_ingresos_diarios`
--
DROP TABLE IF EXISTS `vista_ingresos_diarios`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vista_ingresos_diarios`  AS SELECT `pago`.`fecha_pago` AS `fecha_pago`, sum(`pago`.`monto`) AS `total_dia` FROM `pago` GROUP BY `pago`.`fecha_pago` ;

-- --------------------------------------------------------

--
-- Estructura para la vista `vista_pagos_detallados`
--
DROP TABLE IF EXISTS `vista_pagos_detallados`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vista_pagos_detallados`  AS SELECT `p`.`id_pago` AS `id_pago`, `c`.`nombre` AS `pagado_por`, `p`.`monto` AS `monto`, `p`.`fecha_pago` AS `fecha_pago` FROM ((`pago` `p` join `tramite` `t` on(`p`.`id_tramite` = `t`.`id_tramite`)) join `ciudadano` `c` on(`t`.`cedula_ciudadano` = `c`.`cedula_ciudadano`)) ;

-- --------------------------------------------------------

--
-- Estructura para la vista `vista_promedio_tasas`
--
DROP TABLE IF EXISTS `vista_promedio_tasas`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vista_promedio_tasas`  AS SELECT avg(`pago`.`monto`) AS `promedio_pago_administrativo` FROM `pago` ;

-- --------------------------------------------------------

--
-- Estructura para la vista `vista_recaudacion_total`
--
DROP TABLE IF EXISTS `vista_recaudacion_total`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vista_recaudacion_total`  AS SELECT sum(`pago`.`monto`) AS `ingreso_total_historico` FROM `pago` ;

-- --------------------------------------------------------

--
-- Estructura para la vista `vista_resumen_estados`
--
DROP TABLE IF EXISTS `vista_resumen_estados`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vista_resumen_estados`  AS SELECT `tramite`.`estado` AS `estado`, count(0) AS `total_tramites` FROM `tramite` GROUP BY `tramite`.`estado` ;

-- --------------------------------------------------------

--
-- Estructura para la vista `vista_tramites_pagados`
--
DROP TABLE IF EXISTS `vista_tramites_pagados`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vista_tramites_pagados`  AS SELECT `t`.`id_tramite` AS `id_tramite`, `t`.`tipo_tramite` AS `tipo_tramite`, `p`.`monto` AS `monto`, `p`.`fecha_pago` AS `fecha_pago` FROM (`tramite` `t` join `pago` `p` on(`t`.`id_tramite` = `p`.`id_tramite`)) ;

-- --------------------------------------------------------

--
-- Estructura para la vista `vista_tramites_pendientes`
--
DROP TABLE IF EXISTS `vista_tramites_pendientes`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vista_tramites_pendientes`  AS SELECT `tramite`.`id_tramite` AS `id_tramite`, `tramite`.`tipo_tramite` AS `tipo_tramite`, `tramite`.`fecha_solicitud` AS `fecha_solicitud`, `tramite`.`cedula_ciudadano` AS `cedula_ciudadano` FROM `tramite` WHERE `tramite`.`estado` = 'Pendiente' ;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `ciudadano`
--
ALTER TABLE `ciudadano`
  ADD PRIMARY KEY (`cedula_ciudadano`);

--
-- Indices de la tabla `empleado`
--
ALTER TABLE `empleado`
  ADD PRIMARY KEY (`cedula_empleado`);

--
-- Indices de la tabla `pago`
--
ALTER TABLE `pago`
  ADD PRIMARY KEY (`id_pago`),
  ADD UNIQUE KEY `id_tramite` (`id_tramite`);

--
-- Indices de la tabla `tramite`
--
ALTER TABLE `tramite`
  ADD PRIMARY KEY (`id_tramite`),
  ADD KEY `cedula_ciudadano` (`cedula_ciudadano`),
  ADD KEY `cedula_empleado` (`cedula_empleado`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id_usuario`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `pago`
--
ALTER TABLE `pago`
  MODIFY `id_pago` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Llave Primaria. Número de comprobante de ingreso emitido por tesorería.';

--
-- AUTO_INCREMENT de la tabla `tramite`
--
ALTER TABLE `tramite`
  MODIFY `id_tramite` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Llave Primaria. Número de expediente generado automáticamente por el sistema.', AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id_usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `pago`
--
ALTER TABLE `pago`
  ADD CONSTRAINT `pago_ibfk_1` FOREIGN KEY (`id_tramite`) REFERENCES `tramite` (`id_tramite`);

--
-- Filtros para la tabla `tramite`
--
ALTER TABLE `tramite`
  ADD CONSTRAINT `tramite_ibfk_1` FOREIGN KEY (`cedula_ciudadano`) REFERENCES `ciudadano` (`cedula_ciudadano`),
  ADD CONSTRAINT `tramite_ibfk_2` FOREIGN KEY (`cedula_empleado`) REFERENCES `empleado` (`cedula_empleado`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
