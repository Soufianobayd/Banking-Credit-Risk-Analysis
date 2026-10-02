CREATE DATABASE banking_analysis;
USE banking_analysis;
CREATE TABLE bank_clients (
    id INT PRIMARY KEY,
    edad INT,
    genero VARCHAR(10),
    nivel_educativo VARCHAR(50),
    region VARCHAR(50),
    ingreso_mensual DECIMAL(10,2),
    saldo_cuenta DECIMAL(10,2),
    score_crediticio INT,
    dias_mora_12m INT,
    monto_prestamo_solicitado DECIMAL(10,2)
);
SELECT DATABASE();
SELECT *
FROM bank_clients;
SELECT COUNT(*) AS total_clients
FROM bank_clients;
SELECT *
FROM bank_clients
LIMIT 5;
SELECT id, COUNT(*) AS nombre
FROM bank_clients
GROUP BY id
HAVING COUNT(*) > 1;
SELECT COUNT(*) AS total_clients
FROM bank_clients;
SELECT MIN(id) AS min_id,
       MAX(id) AS max_id,
       COUNT(DISTINCT id) AS unique_ids
FROM bank_clients;
SELECT COUNT(*) AS total_rows,
       COUNT(region) AS region_non_null,
       COUNT(ingreso_mensual) AS income_non_null,
       COUNT(score_crediticio) AS score_non_null
FROM bank_clients;

SELECT
    COUNT(*) AS total_clients,
    ROUND(AVG(edad), 2) AS age_moyen,
    ROUND(AVG(ingreso_mensual), 2) AS revenu_moyen,
    ROUND(AVG(saldo_cuenta), 2) AS solde_moyen,
    ROUND(AVG(score_crediticio), 2) AS score_credit_moyen,
    ROUND(AVG(dias_mora_12m), 2) AS retard_moyen,
    ROUND(AVG(monto_prestamo_solicitado), 2) AS pret_moyen
FROM bank_clients;

SELECT
    genero,
    COUNT(*) AS nombre_clients
FROM bank_clients
GROUP BY genero
ORDER BY nombre_clients DESC;

SELECT
    region,
    COUNT(*) AS nombre_clients
FROM bank_clients
GROUP BY region
ORDER BY nombre_clients DESC;

SELECT
    nivel_educativo,
    COUNT(*) AS nombre_clients
FROM bank_clients
GROUP BY nivel_educativo
ORDER BY nombre_clients DESC;
# Vérifier les régions manquantes
SELECT
    COUNT(*) AS regions_vides
FROM bank_clients
WHERE region IS NULL OR TRIM(region) = '';

# Credit Score
SELECT
    MIN(score_crediticio) AS score_min,
    MAX(score_crediticio) AS score_max,
    ROUND(AVG(score_crediticio), 2) AS score_moyen,
    MIN(dias_mora_12m) AS retard_min,
    MAX(dias_mora_12m) AS retard_max,
    ROUND(AVG(dias_mora_12m), 2) AS retard_moyen
FROM bank_clients;
# catégorie de risque
SELECT
    CASE
        WHEN score_crediticio < 500 THEN 'Risque élevé'
        WHEN score_crediticio < 650 THEN 'Risque moyen'
        ELSE 'Risque faible'
    END AS categorie_risque,
    COUNT(*) AS nombre_clients
FROM bank_clients
GROUP BY categorie_risque
ORDER BY nombre_clients DESC;

# la relation avec retards de paiement et niveau de risque
SELECT
    CASE
        WHEN score_crediticio < 500 THEN 'Risque élevé'
        WHEN score_crediticio < 650 THEN 'Risque moyen'
        ELSE 'Risque faible'
    END AS categorie_risque,
    COUNT(*) AS nombre_clients,
    ROUND(AVG(dias_mora_12m), 2) AS retard_moyen,
    ROUND(AVG(monto_prestamo_solicitado), 2) AS pret_moyen
FROM bank_clients
GROUP BY categorie_risque
ORDER BY retard_moyen DESC;

# Revenu et montant du prêt
SELECT
    MIN(ingreso_mensual) AS revenu_min,
    MAX(ingreso_mensual) AS revenu_max,
    ROUND(AVG(ingreso_mensual), 2) AS revenu_moyen
FROM bank_clients;
# catégorie de revenue
SELECT
    CASE
        WHEN ingreso_mensual < 1500 THEN 'Revenu faible'
        WHEN ingreso_mensual < 3000 THEN 'Revenu moyen'
        ELSE 'Revenu élevé'
    END AS categorie_revenu,
    COUNT(*) AS nombre_clients,
    ROUND(AVG(ingreso_mensual), 2) AS revenu_moyen,
    ROUND(AVG(monto_prestamo_solicitado), 2) AS pret_moyen
FROM bank_clients
GROUP BY categorie_revenu
ORDER BY pret_moyen DESC;

# Niveau de risque selon le revenu
SELECT
    CASE
        WHEN ingreso_mensual < 1500 THEN 'Revenu faible'
        WHEN ingreso_mensual < 3000 THEN 'Revenu moyen'
        ELSE 'Revenu élevé'
    END AS categorie_revenu,

    CASE
        WHEN score_crediticio < 500 THEN 'Risque élevé'
        WHEN score_crediticio < 650 THEN 'Risque moyen'
        ELSE 'Risque faible'
    END AS categorie_risque,

    COUNT(*) AS nombre_clients

FROM bank_clients

GROUP BY categorie_revenu, categorie_risque

ORDER BY categorie_revenu, nombre_clients DESC;

SELECT
    CASE
        WHEN ingreso_mensual < 1500 THEN 'Revenu faible'
        WHEN ingreso_mensual < 3000 THEN 'Revenu moyen'
        ELSE 'Revenu élevé'
    END AS categorie_revenu,

    CASE
        WHEN score_crediticio < 500 THEN 'Risque élevé'
        WHEN score_crediticio < 650 THEN 'Risque moyen'
        ELSE 'Risque faible'
    END AS categorie_risque,

    COUNT(*) AS nombre_clients,

    ROUND(
        COUNT(*) * 100.0 /
        SUM(COUNT(*)) OVER (
            PARTITION BY
            CASE
                WHEN ingreso_mensual < 1500 THEN 'Revenu faible'
                WHEN ingreso_mensual < 3000 THEN 'Revenu moyen'
                ELSE 'Revenu élevé'
            END
        ),
        2
    ) AS pourcentage_dans_revenu

FROM bank_clients

GROUP BY categorie_revenu, categorie_risque

ORDER BY categorie_revenu, pourcentage_dans_revenu DESC;

SELECT
    COUNT(*) AS nombre_clients,
    ROUND(AVG(edad), 2) AS age_moyen,
    ROUND(AVG(ingreso_mensual), 2) AS revenu_moyen,
    ROUND(AVG(saldo_cuenta), 2) AS solde_moyen,
    ROUND(AVG(dias_mora_12m), 2) AS retard_moyen,
    ROUND(AVG(monto_prestamo_solicitado), 2) AS pret_moyen
FROM bank_clients
WHERE score_crediticio < 500;

# Relation entre le score de crédit et les jours de retard
SELECT
    CASE
        WHEN score_crediticio < 500 THEN 'Risque élevé'
        WHEN score_crediticio < 650 THEN 'Risque moyen'
        ELSE 'Risque faible'
    END AS categorie_risque,

    COUNT(*) AS nombre_clients,

    ROUND(AVG(score_crediticio), 2) AS score_moyen,

    ROUND(AVG(dias_mora_12m), 2) AS retard_moyen,

    MIN(dias_mora_12m) AS retard_min,

    MAX(dias_mora_12m) AS retard_max

FROM bank_clients

GROUP BY categorie_risque

ORDER BY score_moyen;

# Analyse directe entre score et retard
SELECT
    score_crediticio,
    ROUND(AVG(dias_mora_12m), 2) AS retard_moyen,
    COUNT(*) AS nombre_clients
FROM bank_clients
GROUP BY score_crediticio
ORDER BY score_crediticio;

