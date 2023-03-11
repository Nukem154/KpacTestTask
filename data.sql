INSERT INTO kpac_set (title)
VALUES ('Set 1'), ('Set 2'), ('Set 3');

INSERT INTO kpac (title, description, creation_date)
VALUES ('KPAC 1', 'Description for KPAC 1', '2022-01-01'),
       ('KPAC 2', 'Description for KPAC 2', '2022-01-02'),
       ('KPAC 3', 'Description for KPAC 3', '2022-01-03'),
       ('KPAC 4', 'Description for KPAC 4', '2022-01-04'),
       ('KPAC 5', 'Description for KPAC 5', '2022-01-05');


INSERT INTO kpac_kpac_set (kpac_id, kpac_set_id)
VALUES (1, 1), (2, 1), (3, 1),
       (2, 2), (3, 2), (4, 2),
       (3, 3), (4, 3), (5, 3);