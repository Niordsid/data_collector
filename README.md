# README

## System dependencies

 - docker 17.06.2-ce
 - docker-compose 1.16.1

Documentation for install Docker
- https://docs.docker.com/install/linux/docker-ce/ubuntu/#install-docker-ce

Documentation for install Docker-Compose
- https://docs.docker.com/compose/install/

## Configuration

  After install Docker and Docker-Compose, download the project and built it with this command:
  ```
  sudo docker-compose build
  ```
## Database creation
  After build the project, we should create the database, execute the command:
  
  ```
  sudo docker-compose run app rake db:create
  ```
## Database initialization
  Run the migrations for create the tables on the database with the command:
  
  ```
  sudo docker-compose run app bundle exec rails db:migrate
  sudo docker-compose run app bundle exec rails db:migrate RAILS_ENV=test
  ```
 ## Author
 * **Andres Santana** - *Initial work* - [Niordsid](https://github.com/Niordsid)
