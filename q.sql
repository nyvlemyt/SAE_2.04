CREATE VIEW Moyennes_matiere
AS
SELECT p.nom, p.prenom, m.id_matiere, avg(note) as moyenne
FROM etudiant e, matiere m, controle c, notes n, personne p
WHERE m.id_matiere=c.id_matiere AND p.id_personne=e.id_personne AND c.id_controle=n.id_controle AND n.id_personne=e.id_personne
GROUP BY p.nom, p.prenom, m.id_matiere;
