# frozen_string_literal: true
championship = Championship.find_by(year: 2020)

(1..38).each do |n|
  Round.create!(
    championship: championship,
    number: n
  )
end
