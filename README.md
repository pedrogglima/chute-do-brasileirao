# Table of Contents

- [1. Introduction](#introduction)
  - [1.1. Who should read this document?](#who-should-read)
- [2. Campeonato Brasileiro de Futebol](#campeonato-brasileiro)
- [3. Project Architecture](#architecture)
  - [3.1. Overview architecture](#overview-architecture)
  - [3.2. Database relational entity](#database-relational-entity)
  - [3.3. Tools, Libraries and 3º Services](#tools)
- [4. Future Expectations](#future-expectations)
- [5. How to use](#how-to-use)

## Introduction

_Note: First of all, this is more a personal portfolio than a open source project. This document doesn't follow the conventions used on open source project._

Chute do Brasileirão is a webpage where you can follow the Campeonato Brasileirio de Futebol - Série A rankings (also knonw as standings), next matches, previous matches, matches score and more. You can also make a guess on the score for the matches of the day.

The image below is the app's frontpage. In the main panel we can see informations about the championship's matches as such: today, next and previous matches, when and where they will happen, and the score from previous matches. On the sidebar we have information about the first six and the last four teams on the ranking.

![Frontpage](./images/frontpage.png "Frontpage")

### Who should read this document?

If you are recruiter and found this page througth my curriculum, or if you already know the webpage and want to understant more about it. If you are in one of these categories, you can reads this document to understant about the project and how it was build.

## Campeonato Brasileiro de Futebol

CBF (Campeonato Brasileiro de Futebol) is a brazilian soccer championship that happens once a year (on the time of the writing, the championship was in the end of the CBF 2020). The championship has many division (e.g A, B, C, etc). For the division A, 20 teams compete for the championship cup. To win the championship cup, each team must match, twice, with the others 19 teams (hence, the championship has in the total 380 matches). For each match, the winner gains 3 points or 1 point for ties. On the end of the 380 matches, the team with more points wins. For the last, the first six on the ranking of division A have the chance to compete on the Libertadores championship, and the last four on the ranking will play on division B (one division below A) on the next championship.

The image below is the Ranking page. Here we have informations about the teams and their rank on the current championship. We can also see informations for each team as: number of points, number of matches played, number of goals, next opponnent and more.

![Ranking](./images/ranking.png "Ranking")

## Project Architecture

First, let me talk about why I choose this project. I was looking, mainly, for a project where I could use a Message broker, even if it was a simple use case. But I also had others interesting: that other people had interesting on using it; that it had little maintenance; and that was a long term project with possibility of expansion. So, while searching for projects using message brokers, I found the following example: server B scraps restaurant webpages for menu pricing, than sends to server A the results through the Message broker. I found the idea cool, even if hosting two servers and one Message broker to exchange a little of data sound a little overkilling - it could be easily done using one server and one background processing. But I didn't like the idea of scraping restaurants page, so I decided to scrap something that I could find more intersting on it - the CBF.

I found two ways of getting data for this project: first, paying for a private API (but I'm not in positing to pay for that); second, scraping the [CBF official page](https://www.cbf.com.br/futebol-brasileiro/competicoes/campeonato-brasileiro-serie-a). Obviously, I choose the second, even though it could give me a little more work and less data (there isn't data about players). So, now that I introduce the main idea of the project, lets see the overview architecture.

### Overview architecture

![Overview architecture](./images/overview_architecture.jpg "Overview architecture")

As you can see on the image, we have two serves. On server A we build a monolith Ruby on Rails app where users can have access to html pages and the API. Still on server A, I'm using two databases: a relational database (Postgres DB), and a no-sql, in-memory database (Redis DB). The reason for choosing the relational database is because the project has relational associations between entities (e.g Championship has many Matches, Users has many Bets, and Matches has many Bets). For the in-memory database, even though many applications make use of it (e.g Rails for caching and sessions, and Sidekiq for manager their queues), I use it to cache some relative heavy queries. I'm also using the background processing (Sidekiq), mainly, for two reason: first, to keep the in-memory database data up to date with the scraped data; Second, for each new Team saved on the database, I need to download the team's image flag and save them on the project's storage (Amazon S3).

The server B is used only to scrap the CBF official page for data from time to time. I'm not using any database for server B, hence, after scraping and formatting the data, server B must publishes it to the Message broker queue (RabbitMQ). Server A, listening on the same queue, acknowledges and consumes the data, attempting to save the data on the relational database.

For the last, but not less important, a reverse proxy (Nginx) is placed between server A and the users. All these applications are running on Docker and orchestrated by Swarm.

### Database relational entity

![Database relationa entity diagram](./images/relational_entity_diagram.jpg "Database relationa entity diagram")

There aren't much to say here, the image says by itself. So I will only describe the entities meaning for the project. (If you want to see details about the tables, such as columns name, indexes, etc, you can check the config/schema.rb file).

- **Championship**: almost all the main entities are related direct and indirect to it (e.g matches, rounds, guesses/bets). Also, every year we have a new championship.
- **Round**: the only purpose of this entity is map 10 matches. The championship has 38 rounds with 10 matches each, which sum up to 380 matches.
- **Match**: this entity represents the real matches between two teams, the place of the game, the date and time, the scores and everything else that can happen during the match.
- **Ranking**: This entity represent the team's ranking (also known as Standing) on the championship. It also has details about the teams in the course of the championship's matches (e.g number of games, number of goals, number of vitories, next opponent, etc)
- **Division**: the CBF has many division, and I let it open to the future possibility of adding more divisions to the project - right now only division A is taking in count.
- **League**: as the same as division, I let it open to the possibility of adding others leagues besides the CBF.
- **Team**: this entity represents the real teams, with their names, flags image and, maybe in the future, the association with the entity player.
- **User**: kept it simple, one model to represent user and admin. Less complexity for authentication and everything else.
- **Bet**: this represents the guesses an user can give to a match. A better name for this entity would be 'bet_score' or 'bet_match_score', it helps identify the kind of bet it represents.
- **Global Setting**: I use the singleton pattern for this entity. It holds the global settings(e.g "which championship is occuring right now", or "which url is used to access the CBF official page"). The advantage of using a database table to hold the global settings, instead of using a file, is how easily is to change their values. No need for rebooting the server, and can be easily accessed and changed.

### Tools, Libraries and 3º Services

- **Tools**: Ruby on Rails, StimulusJs, Bootstrap, Sidekiq, Nginx, Redis DB, Postgres DB, RabbitMQ, Docker, Swarm, Git.

- **Libraries**: (main gems) JWT, Devise, Omniauth-Twitter, Pundit, Haml, Faker, Rspec-rails, Shoulda-matchers, Factory_bot, etc.; (main packages) Bootstrap, Stimulus-carousel, Fontawesome.

- **3º Services**: DigitalOcean droplets, Amazon S3, Amazon Cloudfront.

## Future Expectations

Future expectations are increase the number of users interacting with the project. I hope to achieve this through:

- Creating more guess/bet (e.g Guess the players that will make goals)
- Creating more interaction among users (e.g Top 5 users bets; showing users statistics about guesses)
- Adding a favorite team avatar for users.
- Creating a mobile app: easy access for users when compared to websites responsive.

## Getting started

This project is formed by two repositories: This one, where we can find the most part of the codebase, and the [second repository](https://github.com/pedrogglima/chute-do-brasileirao-scrapper.git), that has the lib used to scrap the CBF official page, and the logic to fetch and publish the data.

We will be running this on localhost as we don't have here the full settings for running on production.

### Prerequisites

The only thing you will need to install are [Docker and Docker Compose](https://docs.docker.com/compose/install/).

_Note: Because we are creating the tools from Docker's images, there are no need for downloading tools or worry about version compatibility. But if you are insteresting into know the tools version, you can find them on the docker-composite file and Dockerfile on this same repository._

#### Repositories

    git clone https://github.com/pedrogglima/chute-do-brasileirao.git

and

    git clone https://github.com/pedrogglima/chute-do-brasileirao-scrapper.git

_Note: To simplify the name for this repositories on the rest of this section, lets call them 'first repo' and 'second repo', respectively._

#### Updating the docker-compose.yml

The docker-compose file is found on the first repo. We need to update the path related to the second repo:

    Change all 'context: ../scraper/.' to 'context: path-to-the-second-repository/.')

We also need to create the env file, which contains the environment variables used to set up the tools and preferences. Inside the first repo:

    mkdir .env/development

Than add the following environment variables. Change the ones with '!...!' to values of your preference.

_Note: some of them you may need to subscribe on 3º services to get the credentials (e.g Twitter keys)._

    REDIS_CACHE=redis://redis_cache:6379/0
    DATABASE_HOST='!database!'
    POSTGRES_USER='!postgres!'
    POSTGRES_PASSWORD='add-some-long-secure-password'
    POSTGRES_DB='!add-the-database-name!'
    TWITTER_API_KEY='!add-your-twitter-api-key!'
    TWITTER_API_SECRET='!add-your-twitter-api-secret!'

#### Creating the Postgres database

Inside the first repo, runs:

    docker-compose run --rm app rails db:setup

Update the file db/seeds/1_users.rb with the informations of your admin user. After that, seed the database with the following command:

    docker-compose run --rm app rails db:reset

#### Running Docker

Inside the first repo, runs:

    docker-compose up

#### RabbitMQ

We need to setup the RabbitMQ queue. To do that go inside the second repo folder, than run the rake commmand:

    docker-compose exec scraper rails rabbitmq:setup

On the first repo, we need to start the workers that will listening on the RabbitMQ queue and consume the messages:

    docker-compose exec app rails sneakers:run

To scrap and dispatch a page manually, go to the second repo then runs:

    docker-compose exec scraper rails scrap_page:cbf:publish

#### Runnings specs

Inside the first repo, runs:

    docker-compose exec app rails spec

### Usage

#### UI

##### Login

Use one of the types to log in to the program: Twitter credentials or use your email address to create a new user.

![Registration Page](./images/registration.png "Registration Page")

##### My bets

Here we have the users bets.

![My bets](./images/my_bets.png "My bets")

##### Making a bet

![Making a bets](./images/making_a_bet.png "Making a bet")

#### API

##### Login

First, you need to get the Authorization Bearer token. You can do that by log in or sign in. e.g log in:

    {"email":"test/@mail.com", "password":"password"}

The result of this request, information about user:

    {
       "id": 2,
       "email": "test/@mail.com",
       "first_name": "Test",
       "last_name": "Test",
       "created_at": "2020-10-20T11:07:27.645+03:00",
       "updated_at": "2020-10-25T23:33:34.050+02:00",
    }

Now, you can find your authorization bearer token inside Headers:

     Content-Type: application/json; charset=utf-8
     Transfer-Encoding: chunked
     Connection: keep-alive
     Status: 200 OK
     Cache-Control: max-age=0, private, must-revalidate
     Referrer-Policy: strict-origin-when-cross-origin
     Authorization: Bearer: eyJhbGciOiJIUzI1NiJ9...Uo2HAV7eY

##### For getting the current rankings

You can make a GET request to https://localhost:3000/api/v1/tabelas passing the Authorization Bearer Token to the Header. You can use a http library (e.g curls) or the Postman desktop client.

As a result you should see the following json.

     {
       "data": {
          "championship": {
            "id": 1,
            "year": 2020,
            "number_of_participants": 20,
            "league": {
              "id": 1,
              "name": "Campeonato Brasileiro",
              "division": {
                "id": 1,
                "name": "Série A"
              }
            }
          },
          "rankings": [
            {
              "ranking": {
                "id": 21,
                "posicao": 1,
                "pontos": 71,
                "jogos": 37,
                "vitorias": 21,
                "empates": 8,
                "derrotas": 8,
                "gols_pro": 67,
                "gols_contra": 46,
                "saldo_de_gols": 21,
                "cartoes_amarelos": 87,
                "cartoes_vermelhos": 3,
                "aproveitamento": 63,
                "recentes": "EVV",
                "team": {
                  "id": 2,
                  "name": "Flamengo",
                  "state": "RJ",
                  "avatar_url": "https://conteudo.cbf.com.br/cdn/imagens/escudos/00006rj.jpg?v=2021021615"
                },
                "next_opponent": {
                  "id": 4,
                  "name": "São Paulo",
                  "state": "SP",
                  "avatar_url": "https://conteudo.cbf.com.br/cdn/imagens/escudos/00017sp.jpg?v=2021021615"
                }
              }
            },
            ...
          ]
        }
