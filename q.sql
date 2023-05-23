/*CREATE VIEW Moyennes_matiere
AS
SELECT e.id_personne, p.nom as nom_etudiant, p.prenom, m.nom as nom_matiere, avg(note) as moyenne
FROM etudiant e, matiere m, controle c, notes n, personne p
WHERE m.id_matiere=c.id_matiere AND p.id_personne=e.id_personne AND c.id_controle=n.id_controle AND n.id_personne=e.id_personne and m.id_matiere=n.id_matiere and e.id_personne=1
GROUP BY e.id_personne, p.nom, p.prenom, m.nom;*/

Create view moyennes_semestre1
as
select e.id_personne, p.nom as nom_etudiant, p.prenom, s.id_semestre, ROUND(CAST(avg(note) AS numeric), 2) as moyenne
FROM etudiant e, matiere m, controle c, notes n, personne p, semestre s
WHERE m.id_matiere=c.id_matiere AND p.id_personne=e.id_personne AND c.id_controle=n.id_controle AND n.id_personne=e.id_personne and m.id_matiere=n.id_matiere and s.id_semestre=m.id_semestre and m.id_semestre=n.id_semestre and n.id_semestre=c.id_semestre and s.id_semestre='S1'
group by e.id_personne, p.nom, p.prenom, s.id_semestre
/*
Create view moyennes_semestre2
as
select e.id_personne, p.nom as nom_etudiant, p.prenom, s.id_semestre, ROUND(CAST(avg(note) AS numeric), 2) as moyenne
FROM etudiant e, matiere m, controle c, notes n, personne p, semestre s
WHERE m.id_matiere=c.id_matiere AND p.id_personne=e.id_personne AND c.id_controle=n.id_controle AND n.id_personne=e.id_personne and m.id_matiere=n.id_matiere and s.id_semestre=m.id_semestre and m.id_semestre=n.id_semestre and n.id_semestre=c.id_semestre and s.id_semestre='S2'
group by e.id_personne, p.nom, p.prenom, s.id_semestre

CREATE VIEW Moyennes_groupe
AS
SELECT g.nom as nom_groupe,e.id_personne, p.nom as nom_etudiant, p.prenom, s.id_semestre, ROUND(CAST(avg(note) AS numeric), 2) as moyenne
FROM etudiant e, matiere m, controle c, notes n, personne p, groupe g, semestre s
WHERE m.id_matiere=c.id_matiere AND p.id_personne=e.id_personne AND c.id_controle=n.id_controle AND n.id_personne=e.id_personne and m.id_matiere=n.id_matiere and g.id_personne=e.id_personne and s.id_semestre=m.id_semestre and m.id_semestre=n.id_semestre and n.id_semestre=c.id_semestre and g.nom='Whaitiri'
GROUP BY nom_groupe, e.id_personne, p.nom, p.prenom, s.id_semestre;

CREATE FUNCTION Histogram(out NoteFloor int, out NoteRange varchar, out "[Note Count]" int)
RETURNS SETOF RECORD
AS
$$
BEGIN
    RETURN QUERY
    WITH NoteRanges AS (
        SELECT FLOOR(n.note/5.00)*5 AS NoteFloor,
            FLOOR(n.note/5.00)*5 + 4 AS NoteCeiling
        FROM etudiant e
        INNER JOIN personne p ON p.id_personne = e.id_personne
        INNER JOIN notes n ON n.id_personne = e.id_personne
        INNER JOIN controle c ON c.id_controle = n.id_controle
        INNER JOIN matiere m ON m.id_matiere = n.id_matiere
        GROUP BY e.id_personne, p.nom, p.prenom, m.nom, n.note
    )
    SELECT NoteFloor,
        CONCAT(NoteFloor, ' to ', NoteCeiling) AS NoteRange,
        COUNT(*) AS "[Note Count]"
    FROM NoteRanges
    GROUP BY NoteFloor, NoteCeiling
    ORDER BY NoteFloor;
END;
$$
LANGUAGE plpgsql;*/
