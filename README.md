# Buddie Up
An application built in Ruby On Rails as part of the Le Wagon Full Stack Web Development bootcamp. 
Our 4 person team completed this project in 2 weeks as our final project.

Buddie Up is an application to help find like-minded gamers and avoid the toxicity of public matchmaking. Each user has a profile and can start chats with other users to set up game sessions in which ever game they choose. Once a gaming session is complete they may rate the individual, which will be then displayed on their public profile.
Favourite users and games can be added, and are displayed on a users profile page.
A user can avoid another user, where they will no longer be shown in searches.

Currently hosted at: https://buddie-up.com

![chrome-capture (2)](https://user-images.githubusercontent.com/16850455/133082190-8b677751-71fc-4876-981c-250d9adecbf7.jpg)
![chrome-capture (1)](https://user-images.githubusercontent.com/16850455/133082194-50d944bb-dedb-41f8-8add-fe29e19f9558.jpg)


## Local Installation

Buddie Up was built in Ruby 2.7.3 so please ensure that you are on that version with:

``` 
$ rbenv local 1.9.3-p183
```
Then execute:

```
$ bundle install
$ yarn install
$ rails db:create db:migrate db:seed
$ rails s
```
You can then find a local server running at: http://localhost:3000
