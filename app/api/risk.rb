require 'sinatra'

input_fields = [:age, :dependents, :house, :income, :marital_status, :risk_questions, :vehicles]

post '/risk' do

  # validate if the post body has all the input_fields fields
  halt 400, "Missing input fields" unless input_fields.all? { |field| params.has_key? field }
end