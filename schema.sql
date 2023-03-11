CREATE TABLE `kpac` (
                        `id` bigint NOT NULL AUTO_INCREMENT,
                        `title` varchar(250) DEFAULT NULL,
                        `description` varchar(2000) DEFAULT NULL,
                        `creation_date` date DEFAULT NULL,
                        PRIMARY KEY (`id`)
)

CREATE TABLE `kpac_set` (
                            `id` bigint NOT NULL AUTO_INCREMENT,
                            `title` varchar(250) DEFAULT NULL,
                            PRIMARY KEY (`id`)
)

CREATE TABLE `kpac_kpac_set` (
                                 `kpac_id` bigint NOT NULL,
                                 `kpac_set_id` bigint NOT NULL,
                                 PRIMARY KEY (`kpac_id`,`kpac_set_id`),
                                 KEY `kpac_set_id` (`kpac_set_id`),
                                 CONSTRAINT `kpac_kpac_set_ibfk_1` FOREIGN KEY (`kpac_id`) REFERENCES `kpac` (`id`),
                                 CONSTRAINT `kpac_kpac_set_ibfk_2` FOREIGN KEY (`kpac_set_id`) REFERENCES `kpac_set` (`id`)
)