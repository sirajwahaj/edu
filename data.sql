-- Insert data into faculties table
INSERT INTO faculties (faculty_name, faculty_abbreviation) VALUES
    ('Engineering', 'ENG'),
    ('Science', 'SCI'),
    ('Business', 'BUS'),
    ('Arts', 'ART'),
    ('Health Sciences', 'HSC'),
    ('Social Sciences', 'SSC'),
    ('Computer Science', 'CSC'),
    ('Mathematics', 'MTH'),
    ('Medicine', 'MED'),
    ('Law', 'LAW'),
    ('Physics', 'PHY'),
    ('Economics', 'ECO'),
    ('Psychology', 'PSY'),
    ('Chemistry', 'CHE'),
    ('History', 'HIS');

-- Insert data into departments table
INSERT INTO departments (department_name, department_abbr, faculty_id) VALUES
    ('Computer Engineering', 'CENG', 1),
    ('Physics', 'PHY', 2),
    ('Business Administration', 'BADM', 3),
    ('History', 'HIS', 4),
    ('Nursing', 'NURS', 5),
    ('Psychology', 'PSY', 6),
    ('Software Engineering', 'SENG', 7),
    ('Mathematics', 'MATH', 8),
    ('Medicine', 'MED', 9),
    ('Law', 'LAW', 10),
    ('Theoretical Physics', 'TPHY', 2),
    ('International Economics', 'IECO', 3),
    ('Clinical Psychology', 'CLPSY', 6),
    ('Organic Chemistry', 'OCHEM', 2),
    ('Ancient History', 'AHIS', 4);

-- Insert data into courses table
INSERT INTO courses (course_code, course_name, credits, course_capacity, department_id) VALUES
    ('CSCI101', 'Introduction to Programming', 3, 50, 7),
    ('PHY101', 'Classical Mechanics', 4, 40, 2),
    ('BADM201', 'Marketing Principles', 3, 30, 3),
    ('HIS202', 'World History', 3, 25, 4),
    ('NURS301', 'Medical Surgical Nursing', 5, 35, 5),
    ('PSY401', 'Cognitive Psychology', 4, 30, 6),
    ('SENG301', 'Database Systems', 4, 40, 7),
    ('MATH201', 'Calculus I', 3, 45, 8),
    ('MED501', 'Internal Medicine', 6, 20, 9),
    ('LAW401', 'Constitutional Law', 4, 30, 10),
    ('PHY301', 'Quantum Mechanics', 4, 35, 2),
    ('ECO301', 'International Trade', 3, 30, 3),
    ('PSY501', 'Abnormal Psychology', 4, 25, 6),
    ('OCHEM401', 'Organic Chemistry II', 4, 20, 2),
    ('AHIS301', 'Ancient Greece and Rome', 3, 25, 4);

-- Insert data into classifications table
INSERT INTO classifications (cl_name, cl_description) VALUES
    ('General Education', 'Courses that provide a broad educational foundation.'),
    ('Core Courses', 'Essential courses required for a specific program.'),
    ('Elective Courses', 'Optional courses that students can choose based on their interests.'),
    ('Advanced Courses', 'Courses that delve into specific topics at an advanced level.');

-- Insert data into courses_classifications table
INSERT INTO courses_classifications (cl_id, course_id) VALUES
    (1, 1), (1, 2), (2, 3), (1, 4), (2, 5),
    (3, 6), (2, 7), (2, 8), (4, 9), (2, 10),
    (1, 11), (3, 12), (3, 13), (2, 14), (1, 15);

-- Insert data into prerequisites table
INSERT INTO prerequisites (course_id, pre_course_id) VALUES
    (7, 1), (9, 2), (10, 3), (14, 8), (15, 12),
    (7, 6), (9, 8), (14, 10), (6, 1), (13, 8),
    (11, 2), (12, 3), (5, 1), (3, 1), (4, 2);

-- Insert data into programs table
INSERT INTO programs (program_name, program_abbr) VALUES
    ('Computer Science', 'CS'),
    ('Physics', 'PH'),
    ('Business Administration', 'BADM'),
    ('History', 'HIST'),
    ('Nursing', 'NURS'),
    ('Psychology', 'PSY'),
    ('Software Engineering', 'SWE'),
    ('Mathematics', 'MATH'),
    ('Medicine', 'MED'),
    ('Law', 'LAW');

-- Insert data into branches table
INSERT INTO branches (branch_name) VALUES
    ('Main Branch'),
    ('Physics Branch'),
    ('Business Branch'),
    ('History Branch'),
    ('Health Sciences Branch'),
    ('Social Sciences Branch'),
    ('Computer Science Branch'),
    ('Mathematics Branch'),
    ('Medicine Branch'),
    ('Law Branch');

-- Insert data into programs_branches table
INSERT INTO programs_branches (branch_id, program_id) VALUES
    (1, 1), (2, 2), (3, 3), (4, 4), (5, 5),
    (6, 6), (7, 7), (8, 8), (9, 9), (10, 10);

-- Insert data into programs_courses table
INSERT INTO programs_courses (course_id, program_id, is_compulsory) VALUES
    (1, 1, true), (2, 2, true), (3, 3, true), (4, 4, true), (5, 5, true),
    (6, 6, true), (7, 7, true), (8, 8, true), (9, 9, true), (10, 10, true),
    (11, 1, false), (12, 2, false), (13, 3, false), (14, 4, false), (15, 5, false);

-- Insert data into student_programs table
INSERT INTO student_programs (program_id, department_id) VALUES
    (1, 1), (2, 2), (3, 3), (4, 4), (5, 5),
    (6, 6), (7, 7), (8, 8), (9, 9), (10, 10),
    (1, 1), (2, 2), (3, 3), (4, 4), (5, 5);

-- Insert data into person table
INSERT INTO person (prs_name, prs_lastname, prs_birth_date) VALUES
    ('John', 'Doe', '1990-05-15'),
    ('Jane', 'Smith', '1992-08-22'),
    ('Michael', 'Johnson', '1988-03-10'),
    ('Emily', 'Williams', '1995-12-01'),
    ('Daniel', 'Brown', '1993-06-05'),
    ('Sophia', 'Miller', '1994-09-18'),
    ('Ryan', 'Davis', '1991-11-30'),
    ('Olivia', 'Martinez', '1996-02-14'),
    ('Ethan', 'Anderson', '1989-07-08'),
    ('Ava', 'Garcia', '1997-04-25'),
    ('William', 'Taylor', '1998-10-03'),
    ('Emma', 'Wilson', '1991-01-17'),
    ('Matthew', 'Moore', '1992-06-08'),
    ('Chloe', 'Thomas', '1994-03-22'),
    ('David', 'Lee', '1993-09-07');

-- Insert data into students table
INSERT INTO students (branch_id, person_id, program_id) VALUES
    (1, 1, 1),
    (2, 2, 2),
    (3, 3, 3),
    (4, 4, 4),
    (5, 5, 5),
    (6, 6, 6),
    (7, 7, 7),
    (8, 8, 8),
    (9, 9, 9),
    (10, 10, 10),
    (1, 11, 1),
    (2, 12, 2),
    (3, 13, 3),
    (4, 14, 4),
    (5, 15, 5);

-- Insert data into students_courses table
INSERT INTO students_courses (student_id, course_id, grade) VALUES
    (1, 1, '4'),
    (2, 2, '5'),
    (3, 3, '3'),
    (4, 4, '4'),
    (5, 5, '5'),
    (6, 6, '3'),
    (7, 7, '4'),
    (8, 8, '5'),
    (9, 9, '4'),
    (10, 10, '3'),
    (11, 11, 'U'),
    (12, 12, '3'),
    (13, 13, '4'),
    (14, 14, '5'),
    (15, 15, '4');

-- Insert data into registration_to_course table
INSERT INTO registration_to_course (reg_date, person_id, course_id) VALUES
    ('2023-01-10', 1, 1),
    ('2023-02-15', 2, 2),
    ('2023-03-20', 3, 3),
    ('2023-04-25', 4, 4),
    ('2023-05-30', 5, 5),
    ('2023-06-05', 6, 6),
    ('2023-07-10', 7, 7),
    ('2023-08-15', 8, 8),
    ('2023-09-20', 9, 9),
    ('2023-10-25', 10, 10),
    ('2023-11-30', 11, 11),
    ('2023-12-05', 12, 12),
    ('2024-01-10', 13, 13),
    ('2024-02-15', 14, 14),
    ('2024-03-20', 15, 15);
