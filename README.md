
  ```sh
  $ docker-compose up -d db
  $ docker-compose build web
  $ docker-compose run --rm web rake db:create db:migrate
