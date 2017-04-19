# Final Project v1.0 by Useless Nuts

This is a Ruby on Rails web application that provides an interface for students to apply for a grader position and professors to look for graders. 

_Recommended Rails version: 5.0.2_

_It is highly recommended that the email address used for an account should match the user's OSU email_

----

### Setting up this project on local development environment

1) Clone this repo

2) Run the command <code>bundle install</code>

3) Run the command <code>rake db:setup</code>

4) Run the command <code>rails db:migrate</code>

5) Run the command <code>rails db:seed</code>

----------

### Students

For a student accessing the web application to apply for a grader position:

1) Sign up or log in to an existing account 

2) Navigate to the STUDENTS tab 
	
Here you will have 3 options:

* New Application - Click this button to start a new application

* View Applications - Click this button to view and edit previous applications

* View Courses - Click this button to view the course listing for a semester

----------

### Professors

_For a professor accessing the application for the first time:_

1) Sign up and create an account

2) Click on the PROFESSOR AUTHENTICATION tab

Now you have 2 options:

* My Account Email is my Staff Email - Clicking on this link will verify the user's email and grant professor priveledges

* My Account Email is Different from my Staff Email - Clicking on this link will prompt you to create a new account

----

_For a professor that has professor priveledges on his/her account:_

* Log in 

* Navigate to the PROFESSORS tab to view students, view courses or submit recommendations

	1) View Students - Here the professor can filter and search for students available and eligible for grader positions for different classes.

	2) Submit Recommendation - Here the professor can submit a new recommendation for a student.

	3) View Courses - This option allows the professor to view the course list, create a new course or edit an existing course.

* Navigate to the RECOMMENDATIONS tab to view, edit or create recommendations.
