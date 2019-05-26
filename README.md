# powr-github-app
A simple Rails app with a feature to authorize via Github (Oauth) and log login history into database

# Step 1
- Open terminal from the project folder and run 'bundle install'
- Then run 'rake db:migrate' to create 'login_histories' table in SQLite database

# Step 2
Create 'local_env.yml' file in '/config' folder with the following content:
CLIENT_ID: 'YOUR_GITHUB_APP_CLIENT_ID'
CLIENT_SECRET: 'YOUR_GITHUB_APP_CLIENT_SECRET'

# Step 3
Open '/config/initializers/constants.rb' file and replace the value of 'LOGIN_USERNAME' key with your Github username

# Step 4
Start the server by running 'rails s' command

# Step 5
Last TEN logged logins will be visible at 'http://localhost:3000/home' page

# Step 6
Follow 'Go to Authorization Page' link and press 'Authorize via Github!' to authorize

# Step 7
After successfully entering credentials, you will be redirected to 'http://localhost:3000/home' page, where latest login info list will be shown

# Step 8
BONUS task:
Upon successful authorization in Step 7, code snippets from the task desciption will be added at appropriate places to index.html of 'YOUR_LOGIN_USERNAME.github.io' repository and committed to the server