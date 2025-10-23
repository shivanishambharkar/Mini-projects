-- create database
CREATE DATABASE student_performance;
USE student_performance;
-- create table
CREATE TABLE students (
	student_id INT PRIMARY KEY
AUTO_INCREMENT,
	name VARCHAR(50),
    gender VARCHAR(10),
    attendance INT,
    study_hours int,
    math_score INT,
    science_score INT,
    english_score INT 
);
-- insert sample data
INSERT INTO students (name, gender, attendance, study_hours, math_score, science_score, english_score) VALUES
('Amit', 'Male', 90, 8, 88, 84, 80),
('Priya', 'Female', 95, 7, 92, 90, 89),
('Rohan', 'Male', 80, 6, 76, 78, 70),
('Sneha', 'Female', 85, 7, 81, 83, 79),
('Kiran', 'Male', 70, 5, 65, 60, 58),
('Ritika', 'Female', 88, 8, 90, 85, 87),
('Arjun', 'Male', 75, 6, 72, 74, 68),
('Neha', 'Female', 92, 9, 95, 94, 90);
-- View all student data
SELECT * FROM students;
-- SQL QUERIES FOR ANALYSIS
-- average score per student
SELECT
    name AS student_name,
    ROUND((math_score + science_score + english_score)/3, 2) AS avg_score
FROM students;
-- average scores by gender
SELECT gender,
       ROUND(AVG(math_score),2) AS avg_math,
       ROUND(AVG(science_score),2) AS avg_science,
       ROUND(AVG(english_score),2) AS avg_english
FROM students
GROUP BY gender;
-- Correlation proxy: Attendance vs. Average Score
SELECT name,
       attendance,
       ROUND((math_score + science_score + english_score)/3,2) AS avg_score
FROM students
ORDER BY attendance DESC;
-- Top 3 students overall average
SELECT
  name AS student_name,
  ROUND((math_score + science_score + english_score) / 3, 2) AS avg_score
FROM students
ORDER BY avg_score DESC
LIMIT 3;
-- Rank all students by their average score
SELECT 
    name,
    ROUND((math_score + science_score + english_score) / 3, 2) AS avg_score,
    RANK() OVER (ORDER BY (math_score + science_score + english_score) / 3 DESC) AS student_rank
FROM students;
-- Finding students who scored above overall average
SELECT 
    name,
    ROUND((math_score + science_score + english_score)/3,2) AS avg_score
FROM students
WHERE (math_score + science_score + english_score)/3 >
      (SELECT AVG((math_score + science_score + english_score)/3) FROM students)
ORDER BY avg_score DESC;
-- Identifying subject topper ( Highest marks in subject)
SELECT 
  'Math' AS subject,
    name,
    math_score AS top_score
FROM students
WHERE math_score = (SELECT MAX(math_score) FROM students)
UNION ALL
SELECT 
    'Science', name, science_score
FROM students
WHERE science_score = (SELECT MAX(science_score) FROM students)
UNION ALL
SELECT 
    'English', name, english_score
FROM students
WHERE english_score = (SELECT MAX(english_score) FROM students);
-- average study hours and attendance by gender
SELECT 
    gender,
    ROUND(AVG(study_hours), 2) AS avg_study_hours,
    ROUND(AVG(attendance), 2) AS avg_attendance
FROM students
GROUP BY gender;


