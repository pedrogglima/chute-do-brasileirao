# frozen_string_literal: true
require 'securerandom'

FactoryBot.define do
  factory :team do
    avatar { FilesTestHelper.jpg }
    name { Faker::Name.unique.name }
    state { Faker::Address.country_code }
    avatar_url { "https://conteudo.cbf.com.br/cdn/imagens/escudos/00009rs.jpg?v=2021021009" }
  end
end
