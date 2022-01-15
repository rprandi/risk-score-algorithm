require "sinatra/base"

class RiskAPI < Sinatra::Base
  REQUIRED_POST_FIELDS = [:age, :dependents, :house, :income, :marital_status, :risk_questions, :vehicle].freeze

  post '/risk' do
    # validate if the post body has all the input_fields fields
    missing_fields = validate_post_params(params)

    if missing_fields.any?
      halt 400, "Missing fields: #{missing_fields.join(', ')}"
    end


    status 200
  end

  private

  def validate_post_params(params)
    missing_fields = []
    REQUIRED_POST_FIELDS.each do |field|
      missing_fields.push(field) unless params.has_key? field
    end
    missing_fields
  end
end
