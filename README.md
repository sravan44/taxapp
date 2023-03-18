##### Prerequisites

The setups steps expect following tools installed on the system.

- Github
- Ruby [2.7.1](https://github.com/organization/project-name/blob/master/.ruby-version#L1)
- Rails [6.0.1](https://github.com/organization/project-name/blob/master/Gemfile#L12)

##### 1. Check out the repository

```bash
git clone git@github.com:sravan44/taxapp.git
```

##### 2. Create database.yml file

Change the configurations in database.yml according to the local postgres configurations.

```bash
config/database.yml
```

##### 3. Create and setup the database

Run the following commands to create and setup the database.

```ruby
bundle exec rake db:create
bundle exec rake db:migrate
```

##### 4. Start the Rails server

You can start the rails server using the command given below.

```ruby
rails s
```

And now you can visit the site with the URL http://localhost:3000