CREATE DATABASE IF NOT EXISTS vulnerable;
USE vulnerable;

CREATE TABLE picture (
    id INT AUTO_INCREMENT PRIMARY KEY,
    path VARCHAR(255) NOT NULL,
    example INT NOT NULL
);

CREATE TABLE IF NOT EXISTS users (
  id INT AUTO_INCREMENT PRIMARY KEY,
  username VARCHAR(50) NOT NULL,
  email VARCHAR(255) NOT NULL,
  password VARCHAR(255) NOT NULL,
  first_name VARCHAR(100),
  last_name VARCHAR(100),
  headline VARCHAR(255),
  location VARCHAR(255),
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  last_seen TIMESTAMP NULL,
  INDEX (username),
  UNIQUE (email)
);

CREATE TABLE IF NOT EXISTS companies (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  industry VARCHAR(100),
  headquarters VARCHAR(255),
  founded_year SMALLINT,
  website VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS experiences (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  company_id INT NULL,
  title VARCHAR(255) NOT NULL,
  start_date DATE,
  end_date DATE,
  location VARCHAR(255),
  description TEXT,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  FOREIGN KEY (company_id) REFERENCES companies(id) ON DELETE SET NULL
);

CREATE TABLE IF NOT EXISTS skills (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE IF NOT EXISTS user_skills (
  user_id INT NOT NULL,
  skill_id INT NOT NULL,
  endorsed_count INT DEFAULT 0,
  PRIMARY KEY (user_id, skill_id),
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  FOREIGN KEY (skill_id) REFERENCES skills(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS connections (
  user_id INT NOT NULL,
  connection_id INT NOT NULL,
  connected_since DATE,
  status ENUM('pending','connected','blocked') DEFAULT 'connected',
  PRIMARY KEY (user_id, connection_id),
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  FOREIGN KEY (connection_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS posts (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  content TEXT,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  likes INT DEFAULT 0,
  comments INT DEFAULT 0,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS education (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  school VARCHAR(255),
  degree VARCHAR(255),
  field_of_study VARCHAR(255),
  start_year SMALLINT,
  end_year SMALLINT,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS endorsements (
  id INT AUTO_INCREMENT PRIMARY KEY,
  skill_id INT NOT NULL,
  from_user_id INT NOT NULL,
  to_user_id INT NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (skill_id) REFERENCES skills(id) ON DELETE CASCADE,
  FOREIGN KEY (from_user_id) REFERENCES users(id) ON DELETE CASCADE,
  FOREIGN KEY (to_user_id) REFERENCES users(id) ON DELETE CASCADE
);

INSERT INTO users (username,email,password,first_name,last_name,headline,location,last_seen) VALUES
('jdupont','j.dupont@example.com', CONCAT('sha256$', SHA2('Password123!',256)), 'Jean','Dupont','Data Analyst | Passionné de données','Paris, France','2025-10-18 09:12:00'),
('mrobert','mathilde.robert@example.com', CONCAT('sha256$', SHA2('M0tDePasse!',256)), 'Mathilde','Robert','Fullstack Developer','Lyon, France','2025-10-17 18:30:00'),
('alee','alex.lee@example.com', CONCAT('sha256$', SHA2('alexStrongP4ss',256)), 'Alex','Lee','Product Manager','London, UK','2025-10-15 12:05:00'),
('schen','sophie.chen@example.com', CONCAT('sha256$', SHA2('Sophie!2024',256)), 'Sophie','Chen','UX Designer','Berlin, Germany','2025-10-18 08:20:00'),
('mgarcia','m.garcia@example.com', CONCAT('sha256$', SHA2('Garci@987',256)), 'Miguel','Garcia','DevOps Engineer','Madrid, Spain','2025-10-16 21:03:00'),
('cleroy','camille.leroy@example.com', CONCAT('sha256$', SHA2('CamillePass!',256)), 'Camille','Leroy','HR Specialist','Nice, France','2025-10-10 14:00:00'),
('rbrown','rachel.brown@example.com', CONCAT('sha256$', SHA2('Rb!2025',256)), 'Rachel','Brown','Marketing Lead','Dublin, Ireland','2025-10-12 11:47:00'),
('tnguyen','thanh.nguyen@example.com', CONCAT('sha256$', SHA2('TnSecure1',256)), 'Thanh','Nguyen','Machine Learning Engineer','Paris, France','2025-10-18 07:55:00'),
('pmoreau','paul.moreau@example.com', CONCAT('sha256$', SHA2('PaulPwd#1',256)), 'Paul','Moreau','QA Engineer','Clermont-Ferrand, France','2025-10-14 16:20:00'),
('iyan','ivan.yan@example.com', CONCAT('sha256$', SHA2('Ivan!Yan2023',256)), 'Ivan','Yan','Cybersecurity Analyst','Brussels, Belgium','2025-10-11 09:00:00'),
('knguyen','kim.nguyen@example.com', CONCAT('sha256$', SHA2('KimPass$$',256)), 'Kim','Nguyen','Business Analyst','Hanoi, Vietnam','2025-10-09 12:00:00'),
('lmartin','laura.martin@example.com', CONCAT('sha256$', SHA2('LmSecret2',256)), 'Laura','Martin','Content Strategist','Bordeaux, France','2025-10-08 20:30:00'),
('odupre','olivier.dupre@example.com', CONCAT('sha256$', SHA2('Oliv!er42',256)), 'Olivier','Dupre','CTO','Paris, France','2025-10-18 10:05:00'),
('sivanov','svetlana.ivanov@example.com', CONCAT('sha256$', SHA2('Sv3tlana*',256)), 'Svetlana','Ivanov','Data Scientist','Moscow, Russia','2025-10-01 08:10:00'),
('jbouton','julien.bouton@example.com', CONCAT('sha256$', SHA2('JulienB2022',256)), 'Julien','Bouton','Mobile Developer','Toulouse, France','2025-09-30 17:47:00'),
('ehassan','emily.hassan@example.com', CONCAT('sha256$', SHA2('Eh@ssan!9',256)), 'Emily','Hassan','Sales Manager','Cairo, Egypt','2025-10-05 13:15:00'),
('rpatel','raj.patel@example.com', CONCAT('sha256$', SHA2('RajPatel_pw',256)), 'Raj','Patel','Cloud Architect','Bengaluru, India','2025-10-03 10:10:00'),
('gmoretti','giulia.moretti@example.com', CONCAT('sha256$', SHA2('Giulia!88',256)), 'Giulia','Moretti','Graphic Designer','Milan, Italy','2025-10-02 22:00:00'),
('sakamoto','sora.sakamoto@example.com', CONCAT('sha256$', SHA2('SoraSecure',256)), 'Sora','Sakamoto','Researcher','Tokyo, Japan','2025-10-04 09:10:00'),
('bnguyen','ben.nguyen@example.com', CONCAT('sha256$', SHA2('BenN#2025',256)), 'Ben','Nguyen','Intern Data','Lille, France','2025-10-17 07:00:00');

INSERT INTO companies (name, industry, headquarters, founded_year, website) VALUES
('DataSense','Information Technology','Paris, France',2016,'https://www.datasense.example'),
('WebForge','Software','Berlin, Germany',2012,'https://www.webforge.example'),
('CloudPeak','Cloud Services','Dublin, Ireland',2014,'https://www.cloudpeak.example'),
('DesignLab','Design','Milan, Italy',2010,'https://www.designlab.example'),
('SecureNet','Cybersecurity','Brussels, Belgium',2018,'https://www.securenet.example'),
('MarketWave','Marketing','London, UK',2009,'https://www.marketwave.example'),
('AutoDrive','Automotive','Stuttgart, Germany',2005,'https://www.autodrive.example'),
('FinTechia','Finance','Madrid, Spain',2017,'https://www.fintechia.example'),
('GreenEnergy','Energy','Oslo, Norway',2011,'https://www.greenenergy.example'),
('EduCore','Education','Lyon, France',2000,'https://www.educore.example');

INSERT INTO experiences (user_id, company_id, title, start_date, end_date, location, description) VALUES
(1,1,'Data Analyst', '2022-06-01', NULL, 'Paris, France', 'Analyse de données clients, dashboard Power BI'),
(2,2,'Fullstack Developer', '2020-04-01', NULL, 'Lyon, France', 'Node.js / React / API design'),
(3,3,'Product Manager', '2019-09-01', NULL, 'London, UK', 'Roadmap produit et gestion des équipes'),
(4,4,'UX Designer', '2021-02-01', NULL, 'Berlin, Germany', 'Design d\'interfaces et tests utilisateurs'),
(5,5,'DevOps Engineer', '2018-11-01', NULL, 'Madrid, Spain', 'CI/CD, Kubernetes'),
(13,1,'CTO', '2023-01-01', NULL, 'Paris, France', 'Lead technique, architecture'),
(8,1,'ML Engineer', '2021-05-01', NULL, 'Paris, France', 'Modèles ML pour recommandation');

INSERT IGNORE INTO skills (name) VALUES
('Python'),('SQL'),('Data Analysis'),('Machine Learning'),('Docker'),('Kubernetes'),
('JavaScript'),('React'),('Node.js'),('UX Design'),('Graphic Design'),('Cloud Architecture'),
('DevOps'),('Project Management'),('Leadership'),('Communication'),('Sales'),('Marketing'),
('Cybersecurity'),('Power BI');

INSERT INTO user_skills (user_id, skill_id, endorsed_count) VALUES
(1,2,5), 
(1,3,8), 
(1,20,3), 
(8,4,7), 
(5,5,6),
(5,6,4),
(2,7,3),
(2,8,2),
(4,10,5),
(19,11,2),
(13,12,10),
(3,14,4);

INSERT INTO connections (user_id,connection_id,connected_since,status) VALUES
(1,2,'2024-01-10','connected'),
(2,1,'2024-01-10','connected'),
(1,8,'2024-06-05','connected'),
(8,1,'2024-06-05','connected'),
(3,13,'2023-09-01','connected'),
(13,3,'2023-09-01','connected'),
(4,2,'2022-11-20','connected'),
(2,4,'2022-11-20','connected'),
(5,1,'2024-03-15','connected'),
(1,5,'2024-03-15','connected'),
(6,7,'2024-05-01','connected'),
(7,6,'2024-05-01','connected'),
(9,1,'2024-08-01','pending'),
(10,1,'2024-08-02','pending');

INSERT INTO posts (user_id,content,created_at,likes,comments) VALUES
(1,'Heureux de partager mon nouveau dashboard Power BI sur les ventes Q3. Feedback bienvenue !','2025-09-20 10:15:00',34,5),
(2,'Déploiement en production réussi 🚀 #webdev','2025-08-01 14:00:00',56,12),
(3,'Nous recherchons un Product Designer pour rejoindre notre équipe. DM pour plus d\'infos.','2025-07-12 09:00:00',12,4),
(13,'Annonce: hiring engineers — poste remote possible.','2025-09-01 08:00:00',102,23),
(8,'Publication d\'un article sur l\'explainability des modèles ML.','2025-06-15 11:30:00',45,7);

INSERT INTO education (user_id,school,degree,field_of_study,start_year,end_year) VALUES
(1,'Université Clermont Auvergne','BUT / Licence','Science des données',2022,2025),
(2,'École 42','Diplôme','Informatique',2018,2021),
(3,'Imperial College London','MSc','Management',2016,2018),
(4,'Université de Berlin','Bachelor','Design',2017,2020),
(8,'Université Paris-Saclay','Master','Machine Learning',2019,2021);

INSERT INTO endorsements (skill_id, from_user_id, to_user_id) VALUES
(3,2,1), 
(2,1,8), 
(4,1,8),
(5,5,8),
(12,13,3);

UPDATE user_skills us
JOIN (
  SELECT to_user_id AS uid, skill_id, COUNT(*) AS cnt
  FROM endorsements
  GROUP BY to_user_id, skill_id
) e ON us.user_id = e.uid AND us.skill_id = e.skill_id
SET us.endorsed_count = us.endorsed_count + e.cnt;

CREATE INDEX idx_users_location ON users(location);
CREATE INDEX idx_experiences_user ON experiences(user_id);
CREATE INDEX idx_posts_user ON posts(user_id);

CREATE TABLE IF NOT EXISTS users_backup AS SELECT * FROM users;


