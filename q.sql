CREATE VIEW Moyennes_matiere
AS
SELECT e.id_personne, p.nom as nom_etudiant, p.prenom, m.nom as nom_matiere, avg(note) as moyenne
FROM etudiant e, matiere m, controle c, notes n, personne p
WHERE m.id_matiere=c.id_matiere AND p.id_personne=e.id_personne AND c.id_controle=n.id_controle AND n.id_personne=e.id_personne and m.id_matiere=n.id_matiere
GROUP BY e.id_personne, p.nom, p.prenom, m.nom;
/*
Create view moyennes_semestre1
as
select e.id_personne, p.nom as nom_etudiant, p.prenom, s.id_semestre, ROUND(CAST(avg(note) AS numeric), 2) as moyenne
FROM etudiant e, matiere m, controle c, notes n, personne p, semestre s
WHERE m.id_matiere=c.id_matiere AND p.id_personne=e.id_personne AND c.id_controle=n.id_controle AND n.id_personne=e.id_personne and m.id_matiere=n.id_matiere and s.id_semestre=m.id_semestre and m.id_semestre=n.id_semestre and n.id_semestre=c.id_semestre and s.id_semestre='S1'
group by e.id_personne, p.nom, p.prenom, s.id_semestre

Create view moyennes_semestre2
as
select e.id_personne, p.nom as nom_etudiant, p.prenom, s.id_semestre, ROUND(CAST(avg(note) AS numeric), 2) as moyenne
FROM etudiant e, matiere m, controle c, notes n, personne p, semestre s
WHERE m.id_matiere=c.id_matiere AND p.id_personne=e.id_personne AND c.id_controle=n.id_controle AND n.id_personne=e.id_personne and m.id_matiere=n.id_matiere and s.id_semestre=m.id_semestre and m.id_semestre=n.id_semestre and n.id_semestre=c.id_semestre and s.id_semestre='S2'
group by e.id_personne, p.nom, p.prenom, s.id_semestre
*/
CREATE VIEW Moyennes_groupe
AS
SELECT g.nom as nom_groupe,e.id_personne, p.nom as nom_etudiant, p.prenom, s.id_semestre, ROUND(CAST(avg(note) AS numeric), 2) as moyenne
FROM etudiant e, matiere m, controle c, notes n, personne p, groupe g, semestre s
WHERE m.id_matiere=c.id_matiere AND p.id_personne=e.id_personne AND c.id_controle=n.id_controle AND n.id_personne=e.id_personne and m.id_matiere=n.id_matiere and g.id_personne=e.id_personne and s.id_semestre=m.id_semestre and m.id_semestre=n.id_semestre and n.id_semestre=c.id_semestre
GROUP BY nom_groupe, e.id_personne, p.nom, p.prenom, s.id_semestre;

/*
CREATE OR REPLACE function VoirMoyenne(id_etudiant INT, semestres VARCHAR)
RETURNS VOID AS $$
DECLARE
  moyenne NUMERIC;
BEGIN
  -- Sélectionner les informations de l'étudiant
  SELECT ROUND(CAST(avg(note) AS numeric), 2) INTO moyenne
  FROM etudiant e
  INNER JOIN personne p ON p.id_personne = e.id_personne
  INNER JOIN notes n ON n.id_personne = e.id_personne
  INNER JOIN controle c ON c.id_controle = n.id_controle
  INNER JOIN matiere m ON m.id_matiere = n.id_matiere
  INNER JOIN semestre s ON s.id_semestre = m.id_semestre
  WHERE e.id_personne = id_etudiant AND s.id_semestre = semestres;
 
 -- Afficher le numéro de l'étudiant 
  RAISE NOTICE 'Pour l''étudiant numéro: %', id_etudiant;
 
 -- Afficher la moyenne de l'étudiant
  RAISE NOTICE 'La moyenne de l''étudiant est : %', moyenne;
END;
$$ LANGUAGE plpgsql;

CREATE FUNCTION AjouterNote( p_id_etudiant int, p_id_type varchar, p_id_controle int,p_id_matiere INT,p_id_semestre varchar, p_note DECIMAL(4, 2), p_id_responsable INT
)
RETURNS VOID
AS $$
BEGIN
    IF NOT EXISTS (
        SELECT 1
        FROM matiere m, controle c
        WHERE m.id_matiere = p_id_matiere
          AND m.id_personne = p_id_responsable
    ) THEN
        RAISE EXCEPTION 'Le professeur n''est pas le référent de cette matière.';
    END IF;
    IF NOT EXISTS (
        SELECT 1
        FROM controle c
        WHERE c.id_controle= p_id_controle
    ) THEN
        RAISE EXCEPTION 'Le controle n''existe pas';
    END IF;
    
    INSERT INTO notes (id_personne, id_type, id_controle, id_matiere,id_semestre, note)
    VALUES (p_id_etudiant, p_id_type, p_id_controle, p_id_matiere, p_id_semestre, p_note );
END;
$$ LANGUAGE plpgsql;

CREATE FUNCTION Ajoutercontrole( p_id_responsable INT,p_id_controle int, p_id_type varchar,p_id_semestre varchar,p_id_matiere INT, p_nom varchar,p_date varchar
)

RETURNS VOID
AS $$
BEGIN
    IF EXISTS (
        SELECT 1
        FROM controle c
        WHERE c.id_controle= p_id_controle
    ) THEN
        RAISE EXCEPTION 'Le controle existe.';
    END IF;
    IF not EXISTS (
        SELECT 1
        FROM matiere m, controle c
        WHERE m.id_matiere = p_id_matiere
          AND m.id_personne = p_id_responsable
    ) THEN
        RAISE EXCEPTION 'Le professeur n''est pas le référent de cette matière.';
    END IF;
    
    INSERT INTO controle (id_controle, id_type, id_semestre, id_matiere, nom, date_eval)
    VALUES (p_id_controle, p_id_type, p_id_semestre,p_id_matiere, p_nom,p_date);
END;
$$ LANGUAGE plpgsql;*/
