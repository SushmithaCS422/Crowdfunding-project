create database project;
use project;

select * from projects;
#Q1 Convert the Date fields to Natural Time
select from_unixtime(created_at)created_date from projects;
select from_unixtime(deadline)deadline_date from projects;
select from_unixtime(updated_at)updated_date from projects;
select from_unixtime(state_changed_at)statechanged_date from projects;
select from_unixtime(successful_at)successful_date from projects;
select from_unixtime(launched_at)launched_date from projects;

#Q2 
select year(from_unixtime(created_at))year from projects;
select month(from_unixtime(created_at))month_no from projects;
select monthname(from_unixtime(created_at))month_name from projects;
select concat("Qtr",-quarter(from_unixtime(created_at)))quarter from projects;
select date_format("%y-%M",from_unixtime(created_at))YearMonth from projects;
select weekday(from_unixtime(created_at))weekday from projects;

#Q3 Convert the Goal amount into USD using the Static USD Rate.
select (goal*static_usd_rate)goal_amount from projects;

#Q4 
# Total Number of Projects based on outcome
select state,count(*)outcome from projects group by 1;
# Total Number of Projects 
select count(*)project from projects;
# Total Number of Projects based on Locations
select country,count(projectid)no_of_project from projects group by 1;
#  Total Number of Projects based on  Category
select category_id,count(projectid)no_of_project from projects group by 1;
# Total Number of Projects created by Year , Quarter , Month
select year(from_unixtime(created_at))year,concat("Qtr",-quarter(from_unixtime(created_at)))quarter,
month(from_unixtime(created_at))month,count(*)no_of_project from projects group by 1,2,3;

#Q5
# A)Successful Projects Amount Raised 
select state,sum(usd_pledged)amount_raised,count(*)no_of_project from projects where state="successful" group by 1;
#B) Successful Projects  Number of Backers
select count(backers_count)no_of_backers from projects where state ="successful" ;
# C)Successful Projects Avg NUmber of Days for successful projects
select state,avg(day((from_unixtime(successful_at))))day from projects where state ="successful" group by 1;

#Q6
#A)Top Successful Projects Based on Number of Backers
select name,backers_count from projects where state="successful" order by backers_count desc limit 10;
select * from (select name,backers_count ,dense_rank() over(order by backers_count desc)rnk from projects where state="successful")rnk where rnk in (1,2,3,4,5,6,7,8,9,10);

# B)Top Successful Projects Based on Amount Raised.
select name,pledged from projects where state="successful" order by pledged desc limit 10;




 