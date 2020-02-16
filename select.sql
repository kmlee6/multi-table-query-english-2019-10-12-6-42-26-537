# 1.Query the existence of 1 course
select course.* 
from course 
join student_course on course.id=student_course.courseId 
where student_course.studentId=1;

# 2.Query the presence of both 1 and 2 courses
select student.* 
from student 
join (
  select studentId 
  from student_course 
  where courseId=1 or courseId=2 
  group by studentId 
  having count(*)=2) as temp 
on student.id=temp.studentId;

# 3.Query the student number and student name and average score of students whose average score is 60 or higher.
select student.id, student.name, avg(score) as avg_score 
from student_course 
join student on student.id=student_course.studentId 
group by student.id, student.name 
having avg_score > 60;

# 4.Query the SQL statement of student information that does not have grades in the student_course table
select student.* 
from student 
left join student_course on student.id = student_course.studentId 
where student_course.score is NULL;

# 5.Query all SQL with grades
select * 
from student_course 
join course on courseId=course.id 
join teacher on teacherId=teacher.id 
join student on studentId=student.id;

# 6.Inquire about the information of classmates who have numbered 1 and also studied the course numbered 2
select student.* from student join 
(select distinct studentId from student_course join 
(select courseId from student_course where studentId=1) as temp 
on student_course.courseId=temp.courseId) as condition1
on id=condition1.studentId
join (select studentId from student_course where courseId=2) as condition2
on id=condition2.studentId
and id!=1;

# 7.Retrieve 1 student score with less than 60 scores in descending order
select student.*, score  
from student_course 
join student on student_course.studentId=student.id 
where score < 60 and student_course.courseId=1 
order by score desc;

# 8.Query the average grade of each course. The results are ranked in descending order of average grade. When the average grades are the same, they are sorted in ascending order by course number.
select course.id, course.name, avg(score) as avg_score 
from student_course 
join course on student_course.courseId=course.id 
group by course.name, course.id 
order by avg_score desc, course.id asc;

# 9.Query the name and score of a student whose course name is "Math" and whose score is less than 60
select student.name, student_course.score 
from student_course 
join student on student_course.studentId=student.id 
join course on student_course.courseId=course.Id 
where course.name="Math" and student_course.score < 60;
