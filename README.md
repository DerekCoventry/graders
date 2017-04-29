# Final Project v1.0 by Useless Nuts

This is a Ruby on Rails web application that provides an interface for students to apply for a grader position and professors to look for graders. 

_Recommended Rails version: 5.0.2_

_It is highly recommended that the email address used for an account should match the user's OSU email_

----

### Setting up this project on local development environment

1) Clone this repo

2) Run the command <code>bundle install</code> to install gems and dependencies.

3) Run the command <code>rake db:setup</code> to set up the database.

4) Run the command <code>rails db:migrate</code> to perform the migrations to the database schema.

5) Run the command <code>rails db:seed</code> to seed the database with preset values.

6) Finally run the command <code>rails s</code> to start the rails server and access the web application in the browser.

----------

### Students

For a student accessing the web application to apply for a grader position:

1) Sign up or log in to an existing account 

2) Use the COURSES tab to view a list of the courses and to see which courses are looking for graders and how many/which graders have already been assigned

3) Navigate to the STUDENTS tab:

	1) New Application - Click this button to start a new application

	2) View Applications - Click this button to view and edit previous applications

	3) View Courses - Click this button to view the course listing for a semester

4) Other Options:

	* Professor Authentication - Click here to authenticate your account as a professor account (only needs to be done the first time)

	* Staff Authentication - Click here to authenticate your account as a staff account (only needs to be done the first time)

_Note: Authentication is done automatically when signing up with your osu email. In case the authentication fails these options can be used._

----------

### Professors

_For a professor that has professor priveledges on his/her account:_

1) Log in 

2) Use the COURSES tab to view a list of the courses and to see which courses are looking for graders and how many/which graders have already been assigned or to deactivate a coure i.e. make it unable for students to apply to be a grader for that course 

3) Use the CHOOSE STUDENTS tab to view a list of applicants

	* Sort the list of applicants based on course/section/preference of the applicant

	* Click on the reference number to view all the recommendations the student has recieved or to add a new one 

	* Click on the feedback number to view/add feedbacks for the student

4) Click on the PROFFESSORS tab:

	1) Available Students - Click this button to view applicants

	2) Submit Recommendations - Click this button to view and edit recommendations that you have given or to add a new one

	3) View Courses - Click this button to view the course listing for a semester, request up to 4 graders for a course or to deactivate a course
	
5) Click on the RECOMMENDATIONS tab to view all the recommendations that you have submitted, edit the existing recommendations and to add a new recommendation

6) Click on the FEEDBACK tab to view all the feedback that you have submitted, edit the existing feedback, delete the existing feedback and to add a new feedback, delete the existing feedback

----

### Staff

1) Click on COURSES tab

	1) Edit course listing

	2) View a final course listing for easy printing

	3) Click *Gather Course Data* to refresh course lisitng

	4) Click *Add Course* to add a new course

	5) Click *Configure Courses* to edit courses 

	6) Click *Autofill graders* to automatically match graders

	7) Sort courses, request graders/delete requests and deactivate courses

2) Use the CHOOSE STUDENTS tab to view a list of applicants

	* Sort the list of applicants based on course/section/preference of the applicant

	* Click on the reference number to view all the recommendations the student has recieved or to add a new one 

	* Click on the feedback number to view/add feedbacks for the student

3) Click on the PROFFESSORS tab:

	1) Available Students - Click this button to view applicants

	2) Submit Recommendations - Click this button to view and edit recommendations that you have given or to add a new one

	3) View Courses - Click this button to view the course listing for a semester, request up to 4 graders for a course or to deactivate a course
	
4) Click on the RECOMMENDATIONS tab to view all the recommendations that you have submitted, edit the existing recommendations and to add a new recommendation

5) Click on the FEEDBACK tab to view all the feedback that you have submitted, edit the existing feedback, delete the existing feedback and to add a new feedback, delete the existing feedback

6) Click on DIRECTORY tab to view a list of professors and staff
	
	1) Use the *Gather Data* button to refresh the list

7) Click on PRE-REQS tab to view a list of courses and pre-requisites
	
	1) Use the *Gather Data* button to refresh the list

	2) View individually, edit prereqs or delete prereqs

----