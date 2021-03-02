# frozen_string_literal: true

# This module permits to stub methods on factory bot instances
# allow(object).to receive(:do_something).and_return true
#
FactoryBot::SyntaxRunner.class_eval do
  include RSpec::Mocks::ExampleMethods
end
