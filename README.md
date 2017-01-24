

# How to to run ?

  - Install docker, docker-compose

### For first time:
  ```sh
  $ docker-compose up -d db
  $ docker-compose build web
  $ docker-compose run --rm web rake db:create db:migrate
  ```
### After:
  ``` sh
  $ docker-compose up
  ```
### Doc for endpoints
 * Check localhost:3000

### Test
  ```
  $ docker-compose run --rm web bundle exec rspec
   ```
##### Also you can do all this without docker
 I think you know how to do it )
