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

CBF (Campeonato Brasileiro de Futebol) is a brazilian soccer championship that happens once a year (on the time of the writing, the championship was in the end of the CBF 2020). The championship has many division (e.g A, B, C, etc). For the division A, 20 teams compete for the championship cup. To win the championship cup, each team must match, twice, with the others 19 teams (hence, the championship has in the total 380 matches). For each match, the winner gains 3 points or 1 point for ties. On the end of the 380 matches, the team with more points wins the championship cup. For the last, the first six on the ranking of division A have the chance to compete on the Libertadores championship, and the last four on the ranking will play on division B (one division bellow A) on the next championship.

The image below is the Ranking page. Here we have informations about the teams and their rank on the current championship. We can also see informations for each team as: number of points, number of matches played, number of goals, next opponnent and more.

![Ranking](./images/ranking.png "Ranking")

## Project Architecture

First, let me talk about why I choose this project. I was looking, mainly, for a project where I could use a Message broker, even if it was a simple use case. But I also had others interesting: that other people had interesting on using it; that it had little maintenance; and that was a long term project with possibility of expansion. So, while searching for projects using message brokers, I found the following example: server B scraps restaurant webpages for menu pricing, than sends to server A the results through the Message broker. I found the idea cool, even if hosting two servers and one Message broker to exchange a little of data sound a little overkilling - it could be easily done using one server and one background processing. But I didn't like the idea of scraping restaurants page, so I decided to scrap something that I could find more intersting on it - the national soccer championship.

I found two ways of getting data for this project: first, paying for a private API (no way I'm gona spend money on that); second, scraping the [CBF official page](https://www.cbf.com.br/futebol-brasileiro/competicoes/campeonato-brasileiro-serie-a). Obviously, I choose the second, even though it could give me a little more work and less data (there isn't data about players). So, now that I said the main idea of the project, lets see the overview architecture.

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
- **Global Setting**: I use the singleton pattern for this entity. It holds the global settings: e.g "which championship is occuring right now", or "which url is used to access the CBF official page". The advantage of using a database table to hold the global setting, instead of using a file, is how easily is to change their values. No need for rebooting the server, and can be easily accessed and changed.

### Tools, Libraries and 3º Services

- **Tools**: Ruby on Rails, StimulusJs, Bootstrap, Sidekiq, Nginx, Redis DB, Postgres DB, RabbitMQ, Docker, Swarm, Git.

- **Libraries**: (main gems) JWT, Devise, Pundit, Haml, Faker, Rspec-rails, Shoulda-matchers, Factory_bot, etc.; (main packages) Bootstrap, Stimulus-carousel, Fontawesome.

- **3º Services**: DigitalOcean droplets, Amazon S3, Amazon Cloudfront.

## Future Expectations

Future expectations are increase the number of users interacting with the project. I hope to achieve this through:

- Creating more guess/bet (e.g Guess the players that will make goals)
- Creating more interaction among users (e.g Top 5 users bets; show users statistics about guesses)
- Adding a favorite team avatar for users.
- Creating a mobile app: better access and interoperability for user.

## How to use

bla bla
