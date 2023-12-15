-- Drop tables if they exist
DROP TABLE IF EXISTS registration_to_course;
DROP TABLE IF EXISTS students_courses;
DROP TABLE IF EXISTS students;
DROP TABLE IF EXISTS person;
DROP TABLE IF EXISTS student_programs;
DROP TABLE IF EXISTS programs_courses;
DROP TABLE IF EXISTS programs_branches;
DROP TABLE IF EXISTS branches;
DROP TABLE IF EXISTS programs;
DROP TABLE IF EXISTS prerequisites;
DROP TABLE IF EXISTS courses_classifications;
DROP TABLE IF EXISTS classifications;
DROP TABLE IF EXISTS courses;
DROP TABLE IF EXISTS departments;
DROP TABLE IF EXISTS faculties;

-- Create faculties table
CREATE TABLE faculties (
    faculty_id SERIAL PRIMARY KEY,
    faculty_name VARCHAR(255),
    faculty_abbreviation VARCHAR(10)
);

-- Create departments table
CREATE TABLE departments (
    department_id SERIAL PRIMARY KEY,
    department_name VARCHAR(255),
    department_abbr VARCHAR(30) UNIQUE,
    faculty_id INT REFERENCES faculties(faculty_id)
);

-- Create courses table
CREATE TABLE courses (
    course_id SERIAL PRIMARY KEY,
    course_code VARCHAR(60),
    course_name VARCHAR(255),
    credits INT,
    course_capacity INT,
    department_id INT REFERENCES departments(department_id)
);

-- Create classifications table
CREATE TABLE classifications (
    cl_id SERIAL PRIMARY KEY,
    cl_name VARCHAR(150),
    cl_description TEXT
);

-- Create courses_classifications table
CREATE TABLE courses_classifications(
    cl_id INT REFERENCES classifications(cl_id),
    course_id INT REFERENCES courses(course_id),
    PRIMARY KEY (cl_id, course_id)
);

-- Create prerequisites table
CREATE TABLE prerequisites (
    course_id INT REFERENCES courses(course_id),
    pre_course_id INT REFERENCES courses(course_id),
    PRIMARY KEY (course_id, pre_course_id)
);

-- Create programs table
CREATE TABLE programs (
    program_id SERIAL PRIMARY KEY,
    program_name VARCHAR(255),
    program_abbr VARCHAR(30)
);

-- Create branches table
CREATE TABLE branches (
    branch_id SERIAL PRIMARY KEY,
    branch_name VARCHAR(255) 
);

-- Create programs_branches table
CREATE TABLE programs_branches (
    branch_id INT REFERENCES branches(branch_id),
    program_id INT REFERENCES programs(program_id),
    PRIMARY KEY (branch_id, program_id)
);

-- Create programs_courses table
CREATE TABLE programs_courses (
    course_id INT REFERENCES courses(course_id),
    program_id INT REFERENCES programs(program_id),
    is_compulsory BOOLEAN,
    PRIMARY KEY (course_id, program_id)
);

-- Create student_programs table
CREATE TABLE student_programs (
    student_id SERIAL PRIMARY KEY,
    program_id INT REFERENCES programs(program_id),
    department_id INT REFERENCES departments(department_id) ON DELETE SET NULL
);

-- Create person table
CREATE TABLE person (
    person_id SERIAL PRIMARY KEY,
    prs_name VARCHAR(100),
    prs_lastname VARCHAR(100),
    prs_birth_date DATE
);

-- Create students table
CREATE TABLE students (
    student_id SERIAL PRIMARY KEY,
    branch_id INT REFERENCES branches(branch_id),
    person_id INT REFERENCES person(person_id),
    program_id INT REFERENCES programs(program_id) 
);

-- Create students_courses table
CREATE TABLE students_courses (
    student_id INT REFERENCES students(student_id),
    course_id INT REFERENCES courses(course_id),
    grade VARCHAR(50) CHECK (grade IN ('U', '3', '4', '5') OR grade IS NULL),
    PRIMARY KEY (student_id, course_id)
);

-- Create registration_to_course table
CREATE TABLE registration_to_course (
    reg_id SERIAL PRIMARY KEY,
    reg_date DATE,
    person_id INT REFERENCES person(person_id),
    course_id INT REFERENCES courses(course_id)
);
