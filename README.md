# Focal [![Build Status](https://travis-ci.org/kabisaict/focal.png?branch=master)](https://travis-ci.org/kabisaict/focal) [![Code Climate](https://codeclimate.com/github/kabisaict/focal.png)](https://codeclimate.com/github/kabisaict/focal) [![Dependency Status](https://gemnasium.com/kabisaict/focal.png)](https://gemnasium.com/kabisaict/focal)

Focal is a tool to create sexy burndowns from one ore more Pivotal Tracker
projects.

_Note: at this time Focal is still in early development and probably not
usable for anything else than adding more features and fixing bugs._

See the github wiki for more details.

## Benefits

With focal it's easy to get insight into your current and past iterations. With
all the data that focal gathers on a daily basis it's also possible to create 
more detailed and interesting graphs and charts.

## Deployment

Simple clone and push to Heroku. A PostgreSQL database will be created for you.

**Migrate the database**

    heroku run bundle exec rake db:migrate
    
**Login and change password**

    /admin

Default ActiveAdmin credentials apply: `admin@example.com` with `password`. 
Change these directly!

**Configure a burndown**

Create a new burndown. Fill in the entire form. 

**Import manually**

Import data manually to see if everything's working okay:

    heroku run bundle exec rake focal:import
    
You should now be able to see a burndown at `/burndowns/:id`.

**Schedule imports**

Add the Heroku scheduler add-on and schedule a **daily** job, preferably
about an hour or so before your stand-up with this command:

    bundle exec rake focal:import

That's all there is to it. Feel free to create more burndowns if you like.

## Development

Focal is tested against ruby 1.9.3 and ruby-2.0.0. Setting Focal up for local
development is pretty straight forward:

    bundle install
    rake db:migrate
    rake db:seed    # To generate a sample burndown

A rake task exists if you want to pull real data from Pivotal Tracker (note that
this does not work with the seed burndown):

    rake focal:import

## Authors

Focal is a Kabisa initiative.

 * Ariejan de Vroom <ariejan@ariejan.net>

## License

Focal is licensed under the MIT license. See `LICENSE.txt` for details.
