# TODO

## Now

- remove format logger for AS
- Add comments on how create sneakers workers (rake file) and create queue on rabbitmq (rake setup file)
- Add coments on services, etc.
- add commentaries on services/caches/...

- Cache queries on redis (missing pagination for previous/next matches)

- Fix css on Bet#create when display error message

## Later

- remover user#registration, only permit auth through omniauth

- update scrap_page/cbf to add championship year to each sub entity (ranking, rounds, matches), then update services parse/create_or_update to query championship according to the championship year passed through each entity. This way, we will be able to add some old championships

- add some form of rescue for cases of missing team avatar
- create bet twitter
- Create configs (as user, passw) to rabbit config
- Create rounds page
- Resize team avatar before saving
- Create table statistic per match & show statistic on bet#show
- Create specs for helpers match & bet
- Create specs for views
