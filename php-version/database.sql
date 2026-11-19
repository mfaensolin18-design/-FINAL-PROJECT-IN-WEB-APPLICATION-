-- Run in phpMyAdmin (Import tab) or: mysql -u root < database.sql
CREATE DATABASE IF NOT EXISTS clinic_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE clinic_db;
DROP TABLE IF EXISTS visit_notes, appointments, users, patients, doctors;
CREATE TABLE doctors(
  id INT AUTO_INCREMENT PRIMARY KEY, name VARCHAR(100) NOT NULL, specialty VARCHAR(100) NOT NULL,
  working_days VARCHAR(20) NOT NULL COMMENT 'weekday numbers, 0=Sun, e.g. 1,2,3,4,5');
CREATE TABLE patients(
  id INT AUTO_INCREMENT PRIMARY KEY, name VARCHAR(100) NOT NULL, age TINYINT UNSIGNED NOT NULL DEFAULT 0,
  phone VARCHAR(30) NOT NULL DEFAULT '', created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP);
CREATE TABLE users(
  id INT AUTO_INCREMENT PRIMARY KEY, username VARCHAR(50) NOT NULL UNIQUE, password_hash VARCHAR(255) NOT NULL,
  role ENUM('staff','doctor') NOT NULL, name VARCHAR(100) NOT NULL, doctor_id INT NULL,
  FOREIGN KEY(doctor_id) REFERENCES doctors(id));
CREATE TABLE appointments(
  id INT AUTO_INCREMENT PRIMARY KEY, patient_id INT NOT NULL, doctor_id INT NOT NULL,
  appt_date DATE NOT NULL, appt_time TIME NOT NULL, reason VARCHAR(255) NOT NULL DEFAULT '',
  status ENUM('Scheduled','Completed','Cancelled') NOT NULL DEFAULT 'Scheduled',
  active TINYINT GENERATED ALWAYS AS (IF(status='Cancelled',NULL,1)) STORED,
  UNIQUE KEY no_double_booking(doctor_id,appt_date,appt_time,active),
  FOREIGN KEY(patient_id) REFERENCES patients(id), FOREIGN KEY(doctor_id) REFERENCES doctors(id));
CREATE TABLE visit_notes(
  id INT AUTO_INCREMENT PRIMARY KEY, patient_id INT NOT NULL, doctor_id INT NOT NULL,
  note_date DATE NOT NULL, note TEXT NOT NULL,
  FOREIGN KEY(patient_id) REFERENCES patients(id), FOREIGN KEY(doctor_id) REFERENCES doctors(id));
INSERT INTO doctors(name,specialty,working_days) VALUES
 ('Dr. Maria Santos','Family Medicine','1,2,3,4,5'),('Dr. Jose Reyes','Pediatrics','1,3,5'),('Dr. Ana Cruz','Internal Medicine','2,4,6');
INSERT INTO patients(name,age,phone) VALUES
 ('Liza Mendoza',34,'0917 555 0101'),('Carlo Dela Peña',7,'0918 555 0188'),('Rodel Bautista',58,'0920 555 0144');
INSERT INTO visit_notes(patient_id,doctor_id,note_date,note) VALUES
 (1,1,CURDATE()-INTERVAL 20 DAY,'Seasonal flu. Advised rest and fluids.'),(3,3,CURDATE()-INTERVAL 45 DAY,'Blood pressure 150/95. Follow-up in 4 weeks.');
INSERT INTO appointments(patient_id,doctor_id,appt_date,appt_time,reason) VALUES
 (1,1,CURDATE(),'09:00','Follow-up check'),(2,2,CURDATE(),'10:30','Vaccination'),(3,3,CURDATE()+INTERVAL 2 DAY,'14:00','Blood pressure review');
-- Users are created by install.php so passwords are hashed with PHP.
