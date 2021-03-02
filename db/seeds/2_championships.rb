# frozen_string_literal: true

# Set all the 'must' class for working properly

division = Division.create!(name: 'Série A')

league = League.create!(name: 'Campeonato Brasileiro', division: division)

championship = Championship.create!(
  league: league,
  year: 2020,
  number_of_participants: 20
)

GlobalSetting.create!(
  singleton_guard: 0,
  championship_id: championship.id,
  cbf_url: 'https://www.cbf.com.br/futebol-brasileiro/competicoes/campeonato-brasileiro-serie-a'
)
