# frozen_string_literal: true

User.create!(
  email: 'test@gmail.com',
  password: '123456',
  password_confirmation: '123456',
  first_name: 'John',
  last_name: 'Abramh',
  admin: false
)
