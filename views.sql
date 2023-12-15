------Basic Information --------------------------------

CREATE OR REPLACE VIEW basic_information AS
SELECT s.student_id AS idnr,
    concat(p.prs_name, ' ', p.prs_lastname) AS name,
    pr.program_name AS program,
    b.branch_name AS branch
   FROM students s
     JOIN person p ON s.person_id = p.person_id
     JOIN programs pr ON s.program_id = pr.program_id
     LEFT JOIN branches b ON s.branch_id = b.branch_id;


---- Finished Courses-------------------------------

CREATE OR REPLACE VIEW finished_courses AS
SELECT p.prs_name AS student,
    c.course_name AS course,
    sc.grade,
    c.credits
   FROM students_courses sc
     JOIN courses c ON sc.course_id = c.course_id
     JOIN person p ON sc.student_id = p.person_id
     WHERE sc.grade IS NOT NULL 
     ORDER BY student;



---- Passed Courses-------------------------------

 CREATE OR REPLACE VIEW passed_courses AS
 SELECT p.prs_name AS student,
    c.course_name AS course,
    c.credits
   FROM students_courses sc
     JOIN courses c ON sc.course_id = c.course_id
	 JOIN person p ON sc.student_id = p.person_id
  WHERE sc.grade IS NOT NULL AND sc.grade <> 'U'
  ORDER BY student;


---- Registrations-------------------------------

CREATE OR REPLACE VIEW registrations AS
WITH RankedRegistrations AS (
    SELECT reg_date, course_id, person_id, ROW_NUMBER() OVER (ORDER BY reg_date) AS priority
    FROM registration_to_course
)
SELECT 
    c.course_name Course,
	concat(p.prs_name, ' ', p.prs_lastname) Student,
    CASE
        WHEN rr.priority <= c.course_capacity THEN 'registered'
        ELSE 'waiting'
    END AS Status
FROM RankedRegistrations rr
JOIN courses c ON c.course_id = rr.course_id
JOIN person p ON rr.person_id = p.person_id;



---- Unread Compulsory Courses-------------------------------

CREATE OR REPLACE VIEW unread_madatory AS
SELECT 
    CONCAT(p.prs_name, ' ', p.prs_lastname) "Name",
    c.course_name "Course Title"
FROM courses c 
JOIN programs_courses pc ON c.course_id = pc.course_id
JOIN programs prg ON pc.program_id = prg.program_id 
JOIN students_courses sc ON c.course_id = sc.course_id 
JOIN students s ON sc.student_id = s.student_id
JOIN person p ON s.person_id = p.person_id 
WHERE pc.is_compulsory = true AND sc.grade IS NULL;




---- Queue and Pirorities-------------------------------

CREATE OR REPLACE VIEW course_queue_position AS
WITH RankedRegistrations AS (
    SELECT reg_date,
        course_id,
        person_id,
        ROW_NUMBER() OVER (PARTITION BY course_id ORDER BY reg_date) AS priority
    FROM registration_to_course
)
SELECT
    CONCAT(p.prs_name, ' ', p.prs_lastname) "Student",
    c.course_name "Course",
    ROW_NUMBER() OVER (PARTITION BY c.course_id ORDER BY rr.priority) "Place"
FROM RankedRegistrations rr
JOIN courses c ON c.course_id = rr.course_id
JOIN person p ON rr.person_id = p.person_id
WHERE rr.priority < c.course_capacity
ORDER BY c.course_name, rr.priority;
