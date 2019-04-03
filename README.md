# README

## System dependencies

 - docker 17.06.2-ce
 - docker-compose 1.16.1

Documentation for install Docker
- https://docs.docker.com/install/linux/docker-ce/ubuntu/#install-docker-ce

Documentation for install Docker-Compose
- https://docs.docker.com/compose/install/

- This project was tested in ubuntu 16.04

## Configuration

  After install Docker and Docker-Compose, download the project and create a file in the folder config/ called application.yml and paste this  development:                                                                                                                                                                                              
   ENCODED_KEY: "Fv0rYACkGYKpvO+PvDZ0/Gu8S+CI4dtT4Qw5v8XOTHk=\n"                                                                                                                                           
   ENCODED_SALT: 'xji7/26BMc+K07j4B8RG9/f7O1YubZidQXwKu6OwvEcCKEQvD3fSEy7Cywrg\nKO5LbNmw5s8NUxSaxuSoA9UbDg==\n'                                                                                            
   CREDENTIALS_BASE_TOKEN: 'base_token_30'                                                                                                                                                                 
   CONDOR_USERNAME: ‘insertecodigoaqui’                                                                                                                                                                          
   CONDOR_PSS: 'insertepassaqui'                                                                                                                                                                                 
 test:                                                                                                                                                                                                     
   ENCODED_KEY: "Fv0rYACkGYKpvO+PvDZ0/Gu8S+CI4dtT4Qw5v8XOTHk=\n"                                                                                                                                           
   ENCODED_SALT: 'xji7/26BMc+K07j4B8RG9/f7O1YubZidQXwKu6OwvEcCKEQvD3fSEy7Cywrg\nKO5LbNmw5s8NUxSaxuSoA9UbDg==\n'                                                                                            
   CREDENTIALS_BASE_TOKEN: 'base_token_30'                                                                                                                                                                 
   CONDOR_USERNAME: ‘insertecodigoaqui’                                                                                                                                                                          
   CONDOR_PSS: 'insertepassaqui'
   
 then build the project with this command:
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
