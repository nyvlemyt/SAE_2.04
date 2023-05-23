alter table etudiant drop constraint if exists fk_e_personne ;
alter table responsable drop constraint if exists fk_r_personne ;
alter table groupe drop constraint if exists fk_g_semestre ;
alter table groupe drop constraint if exists fk_g_personne ;
alter table matiere drop constraint if exists fk_m_semestre ;
alter table matiere drop constraint if exists fk_m_personne ;
alter table matiere drop constraint if exists fk_m_type ;
alter table coeff_competence drop constraint if exists fk_c_competence ;
alter table coeff_competence drop constraint if exists fk_c_semestre ;
alter table controle drop constraint if exists fk_co_semestre ;
alter table notes drop constraint if exists fk_n_personne ;
alter table notes drop constraint if exists fk_n_semestre ;
drop table if exists type ;
drop table if exists personne ;
drop table if exists etudiant ;
drop table if exists responsable ;
drop table if exists groupe ;
drop table if exists semestre ;
drop table if exists matiere ;
drop table if exists competence ;
drop table if exists coeff_competence ;
drop table if exists controle ;
drop table if exists notes ;

create table type
( id_type varchar,
  	primary key(id_type)
  );

create table personne
( id_personne int,
  nom varchar,
  prenom varchar,
  	primary key(id_personne)
  );
  
create table etudiant
( id_personne int,
  	primary key(id_personne)
 );

alter table etudiant
add constraint fk_e_personne 
	foreign key (id_personne) 
	references personne (id_personne);



create table responsable
( id_personne int,
  	primary key(id_personne)

 );

alter table responsable
add constraint fk_r_personne
	foreign key (id_personne) 
	references personne (id_personne);

create table semestre
(	id_semestre varchar,
	primary key(id_semestre)
 );

create table groupe
(	id_groupe int,	
	id_personne int,
	id_semestre varchar,
	nom varchar,
	primary key(id_groupe)
);
 
alter table groupe
add constraint fk_g_personne
	foreign key (id_personne) 
	references etudiant (id_personne);

alter table groupe
add constraint fk_g_semestre 
	foreign key (id_semestre) 
	references semestre (id_semestre);

create table matiere
( 	id_type varchar,
  	id_semestre varchar,
	id_matiere int,
  	id_personne int,
  	nom varchar,
  	primary key(id_matiere,id_semestre,id_type)
  );
 
alter table matiere
add constraint fk_m_semestre
	foreign key (id_semestre) 
	references semestre (id_semestre);

alter table matiere
add constraint fk_m_personne 
	foreign key (id_personne) 
	references responsable (id_personne);

alter table matiere
add constraint fk_m_type 
	foreign key (id_type) 
	references type (id_type);
	
create table competence
( id_competence varchar,
  nom varchar,
  	primary key(id_competence)
  );
  
create table coeff_competence
( 	id_competence varchar,
	id_type varchar,
	id_semestre varchar,
  	id_matiere int,
  	coefficient int,
  	primary key(id_competence,id_matiere,id_semestre,id_type)
  );

alter table coeff_competence
add constraint fk_c_competence
	foreign key (id_competence) 
	references competence (id_competence);

alter table coeff_competence
add constraint fk_c_semestre
	foreign key (id_matiere,id_semestre,id_type) 
	references matiere (id_matiere,id_semestre,id_type);

create table controle
(	id_controle int, 	
	id_type varchar,
	id_semestre varchar,	
	id_matiere int,
  	nom varchar,
  	date_eval varchar,
  	primary key(id_controle,id_matiere,id_semestre,id_type)
  );

alter table controle
add constraint fk_co_semestre 
	foreign key (id_matiere,id_semestre,id_type) 
	references matiere (id_matiere,id_semestre,id_type);
  
create table notes
(	id_personne int, 	
	id_type varchar,
  	id_controle int,	
	id_matiere int,
  	id_semestre varchar,
  	note float,
  	primary key(id_personne,id_controle,id_matiere,id_semestre,id_type)
  );
  
alter table notes
add constraint fk_n_personne
	foreign key (id_personne) 
	references etudiant (id_personne);

alter table notes
add constraint fk_n_semestre
	foreign key (id_controle,id_matiere,id_semestre,id_type) 
	references controle (id_controle,id_matiere,id_semestre,id_type);

\copy personne from personne.txt
\copy etudiant from etudiant.txt
\copy responsable from responsable.txt
\copy semestre from semestre.txt
\copy groupe from groupe.txt
\copy type from type.txt
\copy matiere from matiere.txt
\copy competence from competence.txt
\copy coeff_competence from coeff_competence.txt
\copy controle from controle.txt
\copy notes from notes.txt
