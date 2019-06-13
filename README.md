# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

Here are some environment notes from Aaron that i used to setup a local environment.



From Aaron Eisenburger:
1. Install homebrew
https://brew.sh/

2. Install dependencies
brew install rbenv ruby-build postgresql redis

3. Follow homebrew instructions for creating new postgres database

4. run 'rbenv install 2.5.5' (you will need xcode + dev tools for this)

5. Pull sapphire repo from github

6. From repo, run 'gem install bundler puma-dev' and then 'bundle install'

7. From repo, run 'rails db:create db:migrate'

8. From repo, run 'puma-dev link igems'

9. Startup jobs processor/change tracking
From repo, by run 'guard'

10. From browser, navigate to http://igems.test

11. Optional - download and import db from heroku to get seed data:
https://devcenter.heroku.com/articles/heroku-postgres-import-export#export

// end Aaron's notes.   

This the above generally right for a new local env.
I had to do a a few extra things to get going.  Also note that when i did the git "pull" i loaded everything into a "sapphire" directory, and thus everything locally is tested on http://sapphire.test instead of igems.test.  

puma-dev —install command

Also had to load the correct 2.5.5 version of the env as for some reason i had ruby 2.3.7.

Then, to get connected to Heroku:

brew install heroku/brew/heroku

Create a ruby app:
// not needed as we already have an app.
heroku create


To push code:

git push heroku master


Tail the log file on heroku:

heroku logs --tail -a igems

Backup the db:
heroku pg:backups:capture -a igems
Download the latest
heroku pg:backups:download -a igems

Local restore
pg_restore --verbose --clean --no-acl --no-owner -h localhost -U <myuser> -d sapphire_development latest.dump
  
  
Please update this with any knowlege or workarounds you have.   Still needed: 

* notes on committing changes to github
* notes on creating a deployment
