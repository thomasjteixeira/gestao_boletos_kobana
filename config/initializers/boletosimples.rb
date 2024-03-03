# frozen_string_literal: true

require 'boletosimples'

BoletoSimples.configure do |c|
  c.api_token = ENV.fetch('BOLETOSIMPLES_API_TOKEN', nil)
  c.user_agent = ENV.fetch('BOLETOSIMPLES_USER_AGENT', nil)
  c.debug = true
  # c.custom_headers = { 'X-CUSTOM' => 'CONTENT' }
end
