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

Chute do Brasileirão is a webpage where you can follow the Campeonato Brasileirio de Futebol - Série A standings, next matches, previous matches, matches score and more. You can also make a guess on the score for the matches of the day.

- image frontpage

### Who should read this document?

If you are recruiter and found this page througth my curriculum, or if you already know the webpage and want to understant more about it. If you are in one of these categories, you can reads this document to understant about the project and how it was build.

## Campeonato Brasileiro de Futebol

CBF (Campeonato Brasileiro de Futebol) is a brazilian soccer championship that happens once a year (on the time of the writing, the championship was in the end of the CBF 2020). The championship has many division (e.g A, B, C, etc). For the division A, 20 teams compete for the championship cup. To win the championship cup, each team must match, twice, with the others 19 teams (hence, the championship has in the total 380 matches). For each match, the winner gains 3 points or 1 point for ties. On the end of the 380 matches, the team with more points wins the championship cup. For the last, the first six on the ranking of division A have the chance to compete on the Libertadores championship, and the last four on the ranking will play on division B (one division bellow A) on the next championship.

- image tabela

## Project Architecture

First, let me talk about why I choose this project. I was looking, mainly, for a project where I could use a Message Broker, even if it was a simple use case. But I also had others interesting: that other people had interesting on using it; that it had little maintenance; and that was a long term project with possibility of expansion. So, while searching for projects using message brokers, I found the following example: server B scraps restaurant webpages for menu pricing, than sends to server A the results through the message broker using the publisher/consumer pattern. I found the idea cool, even if hosting two servers and one message broker to exchange a little of data sound a little overkilling - it could be easy done using one server and one manager task. But I didn't like the idea of scraping restaurants page, so I decided to scrap something that I could find more intersting on it - the national soccer championship.

I found two ways of getting data for this project: first, paying for a private API (no way I'm gona spend money on that); second, scraping the [CBF official page](https://www.cbf.com.br/futebol-brasileiro/competicoes/campeonato-brasileiro-serie-a). Obviously, I choose the second, even though it could give me a little more work and less data (there aren't data about players). So, now that I said the main idea of the project, lets see the overview architecture.

### Overview architecture

- image

As you can see on the image, we have two Rails serves (let's called them server A and B). On server A we build a monolith Rails app where clients can have access to views and the API. Still on server A, I'm using two databases: a relational database (Postgres), and a no-sql database (Redis). The reason for choosing the relational database is because the project has relational associations between entities (e.g championship has many matches, users has many bets, and matches has many bets). For the no-sql database, even though many applications make use of it (e.g Rails for caching, Sidekiq for manager their process queues), I use it to cache some relative heavy queries. For performance reasons, I added the manager task (Sidekiq) to query those cached queries and populate the no-sql database from time to time.

The server B is used only to scrap the CBF official page for data. I'm not using any database for server B, hence, after scraping and formatting the data, server B publishes it on the message broker (RabbitMQ) queue. Server A, listening on the same queue, acknowledges and consumes the data, where it attempts to save the data on the relational database.

For the last, but not less important, a reverse proxy (Nginx) is placed between server A and the clients, letting the others applications closed to public access. All this setup is running on Docker and orchestrated by Swarm.

### Database relational entity

- image

There aren't much to say here, the image says by itself. The only think I can say is about the entities meaning for the project:

- **Championship**: almost all the main entities are related direct and indirect to it (e.g matches, rounds, guesses/bets). Also, every year we have a new championship.
- **Round**: the only purpose of this entity is map 10 matches. The championship has 38 rounds with 10 matches each, which sum up to 380 matches.
- **Match**: this entity represents the real matches between two teams, the place of the game, the date and time, the scores and everything else that can happen during the match.
- **Division**: the CBF has many division, and I let it open to the future possibility of adding more divisions to the project - right now only division A is taking in count.
- **League**: as the same as division, I let it open to the possibility of adding others leagues besides the CBF.
- **Team**: this entity represents the real teams, with their names, avatar and, maybe in the future, the association with the entity player.
- **User**: kept it simple, one model to represent user and admin. Less complexity for authentication and everything else.
- **Bet**: this represents the guesses an user can give to a match. A better name for this entity would be 'bet_score' or 'bet_match_score', it helps identify the kind of bet it represents.
- **Global Setting**: I use the singleton pattern for this entity. It holds the global settings: e.g "which championship is occuring right now", or "which url is used to access the CBF official page". The advantage of using a database table to hold the global setting, instead of using a file, is how easily is to change their values. No need for rebooting the server, and can be easily accessed and changed.

### Tools, Libraries and 3º Services

- **Tools**: Ruby on Rails, StimulusJs, Bootstrap, Sidekiq, Nginx, Redis DB, Postgres DB, RabbitMQ, Docker, Swarm

- **Libraries**: (main gems) JWT, Devise, Pundit, Haml, Faker, Rspec-rails, Shoulda-matchers, Factory_bot, etc.; (main packages) Bootstrap, Stimulus-carousel, Fontawesome.

- **3º Services**: DigitalOcean droplets, Amazon S3, Amazon Cloudfront.

## Future Expectations

Future expectations are increase the number of users interacting with the project. I hope to achieve this through:

- Creating more guess/bet (e.g Guess the players that will make goals)
- Creating more interaction among users (e.g Top 5 users bets; show users statistics about guesses)
- Adding avatar for the users using their favorite team.
- Creating a mobile app: better access and interoperability for user.

## How to use

bla bla
