# frozen_string_literal: true

league = League.find_by(name: "Campeonato Brasileiro", division: "série A")

Championship.create!(
  league: league,
  year: 2020,
  number_of_participants: 20
)
