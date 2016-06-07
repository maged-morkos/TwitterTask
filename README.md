# TwitterTask
below i will explain every class with it's logic and what is used with it

# 1- ViewController
First run for this app will open the main viewcontroller which contain a twitter login button which open safariViewController to enable the user to login after that the view will be dissmesed and a list with followers will appear

## What is used in this class
- used Swiffter library as a helper third party for handling Twitter Apis

## Logic
- logging by using the secret and consumer key from the app i have made in Twitter developer
- recieve an access token in case of logging successufly
- each access token contain a secret and key, i saved them for next running i will use them to call the Apis of Twitter
- everytime the app launch i check for the saved access token if it excist the app will open the followers screan directly and if not the login page will appear

