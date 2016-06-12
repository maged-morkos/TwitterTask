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

# 2- FollowersViewController
After signing in a list of followers will appear with the folloing features

## what is used in this class
- Reach file to get the statues of the network
- an Extension for UIImageView for lazy loading images in the tableView

## Logic
- using Twitter Api and the help of the Swiftter library a list of followers was retrieved
- I created a model with name "FollowerModel" to store the retrieved data
- a custome UITableViewCell was created to display the data with a designable way
  - display user photo
  - display user full name
  - display user screen name
  - display user description if exist and if not the tableViewCell will change it's hight and fit the content
  
- everytime the app will check if it is online or offline if it was offline the data will retrieved from the cashed one if exist and if not a message will appear to the user to connect and try again and in case of online statues the app will directly connect to twitter Apis and get the followers list

