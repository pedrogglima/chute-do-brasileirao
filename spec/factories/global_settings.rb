# frozen_string_literal: true

FactoryBot.define do
  factory :global_setting do
    association :championship
    singleton_guard { 0 }
    cbf_url do
      'https://www.cbf.com.br/futebol-brasileiro/competicoes/campeonato-brasileiro-serie-a'
    end
    granted_period { 3 }

    initialize_with do
      GlobalSetting.where(singleton_guard: 0).first_or_create
    end
  end
end
