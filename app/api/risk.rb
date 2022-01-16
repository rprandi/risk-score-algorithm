require "sinatra/base"
require "sinatra/reloader"

class RiskAPI < Sinatra::Base
  register Sinatra::Reloader

  REQUIRED_FIELDS = [:age, :dependents, :house, :income, :marital_status, :risk_questions, :vehicle]

  post '/risk' do
    body = JSON.parse(request.body.read).symbolize_keys

    missing_fields = find_missing_fields(body)
    if missing_fields.any?
      halt 400, { error: "Missing fields: #{missing_fields.join(', ')}" }.to_json
    end


    status 200

    response = {
      auto: calculate_score(body, AutoRules),
      disability: calculate_score(body, DisabilityRules),
      home: calculate_score(body, HomeRules),
      life: calculate_score(body, LifeRules)
    }

    body response.to_json
  end

  private

  def find_missing_fields(body)
    REQUIRED_FIELDS.select { |field| body[field].nil? }
  end

  def calculate_score(body, rules_klass)
    rules = rules_klass.new(body)
    return 'ineligible' unless rules.is_eligible?


    base_score = body[:risk_questions].reduce(:+)
    score = base_score + rules.calculate_score

    case
    when score <= 0
      'economic'
    when score == 1 || score == 2
      'regular'
    when score >= 3
      'responsible'
    end
  end
end
