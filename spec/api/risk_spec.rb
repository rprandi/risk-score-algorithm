require_relative '../spec_helper'

RSpec.describe RiskAPI do
  let!(:app) { RiskAPI }


  describe 'POST /risk' do
    let(:body) { JSON.parse(last_response.body).symbolize_keys }

    #Happy Path
    describe 'when the body is valid' do
      let(:request) {{
        age: 35,
        dependents: 2,
        house: { ownership_status: "owned"},
        income: 0,
        marital_status: "married",
        risk_questions: [0, 1, 0],
        vehicle: { year: 2018}
      }}

      let(:response) {{
        auto: "economic",
        disability: "ineligible",
        home: "economic",
        life: "regular",
      }}

      it 'Returns a 200 when the body is valid' do
        post '/risk', request.to_json
        expect(last_response.status).to eq(200)
        expect(body).to eq(response)
      end
    end

    #Bad Request
    describe 'when the body is empty' do
      let(:request) {{
      }}

      let(:response) {{
        error: "Missing fields: age, dependents, house, income, marital_status, risk_questions, vehicle"
      }}

      it 'Returns a 200 when the body is valid' do
        post '/risk', request.to_json
        expect(last_response.status).to eq(400)
        expect(body).to eq(response)
      end
    end
    describe 'when the body is missing' do
      let(:request) {{
      }}

      let(:response) {{
        error: "Invalid Body"
      }}

      it 'Returns a 200 when the body is valid' do
        post '/risk'
        expect(last_response.status).to eq(400)
        expect(body).to eq(response)
      end
    end

    # Testing Ineligibility
    describe 'when user has age over 60' do
      describe 'when user has no income' do
        describe 'when user has no vehicle' do
          describe 'when user has no home' do
            let(:request) {{
              age: 61,
              dependents: 0,
              house: { },
              income: 0,
              marital_status: "married",
              risk_questions: [0, 0, 0],
              vehicle: { }
            }}

            let(:response) {{
              auto: "ineligible",
              disability: "ineligible",
              home: "ineligible",
              life: "ineligible",
            }}

            it 'Returns a 200 when the body is valid' do
              post '/risk', request.to_json
              expect(last_response.status).to eq(200)
              expect(body).to eq(response)
            end
          end
        end
      end

    end

    # Testing economic
    describe 'when user has age 19' do
      describe 'when income is over 200_000' do
        describe 'when house is owned' do
          describe 'when user has no dependents' do
            describe 'when user is not married' do
              describe 'when user has a new vehicle' do
                let(:request) {{
                  age: 19,
                  dependents: 0,
                  house: { ownership_status: "owned" },
                  income: 250_000,
                  marital_status: "single",
                  risk_questions: [0, 0, 0],
                  vehicle: { year: Time.new.year }
                }}

                let(:response) {{
                  auto: "economic",
                  disability: "economic",
                  home: "economic",
                  life: "economic",
                }}

                it 'Returns a 200 when the body is valid' do
                  post '/risk', request.to_json
                  expect(last_response.status).to eq(200)
                  expect(body).to eq(response)
                end
              end
            end
          end
        end
      end
    end

    # Testing responsible and regular
    describe 'when user has age between 40 and 60' do
      describe 'when income is below 200_000' do
        describe 'when house is mortgaged' do
          describe 'when user has dependents' do
            describe 'when user is married' do
              describe 'when user has a new vehicle' do
                describe 'when risk questions sum 3' do
                  let(:request) {{
                    age: 45,
                    dependents: 1,
                    house: { ownership_status: "owned" },
                    income: 50_000,
                    marital_status: "married",
                    risk_questions: [1, 1, 1],
                    vehicle: { year: Time.new.year }
                  }}

                  let(:response) {{
                    auto: "responsible",
                    disability: "responsible",
                    home: "responsible",
                    life: "responsible",
                  }}

                  it 'Returns a 200 when the body is valid' do
                    post '/risk', request.to_json
                    expect(last_response.status).to eq(200)
                    expect(body).to eq(response)
                  end
                end
                describe 'when risk questions sum 2' do
                  let(:request) {{
                    age: 45,
                    dependents: 1,
                    house: { ownership_status: "owned" },
                    income: 50_000,
                    marital_status: "married",
                    risk_questions: [1, 1, 0],
                    vehicle: { year: Time.new.year }
                  }}

                  let(:response) {{
                    auto: "regular",
                    disability: "regular",
                    home: "regular",
                    life: "responsible",
                  }}

                  it 'Returns a 200 when the body is valid' do
                    post '/risk', request.to_json
                    expect(last_response.status).to eq(200)
                    expect(body).to eq(response)
                  end
                end
                describe 'when risk questions sum 1' do
                  let(:request) {{
                    age: 45,
                    dependents: 1,
                    house: { ownership_status: "owned" },
                    income: 50_000,
                    marital_status: "married",
                    risk_questions: [1, 0, 0],
                    vehicle: { year: Time.new.year }
                  }}

                  let(:response) {{
                    auto: "regular",
                    disability: "regular",
                    home: "regular",
                    life: "responsible",
                  }}

                  it 'Returns a 200 when the body is valid' do
                    post '/risk', request.to_json
                    expect(last_response.status).to eq(200)
                    expect(body).to eq(response)
                  end
                end
                describe 'when risk questions sum 0' do
                  let(:request) {{
                    age: 45,
                    dependents: 1,
                    house: { ownership_status: "owned" },
                    income: 50_000,
                    marital_status: "married",
                    risk_questions: [0, 0, 0],
                    vehicle: { year: Time.new.year }
                  }}

                  let(:response) {{
                    auto: "economic",
                    disability: "economic",
                    home: "economic",
                    life: "regular",
                  }}

                  it 'Returns a 200 when the body is valid' do
                    post '/risk', request.to_json
                    expect(last_response.status).to eq(200)
                    expect(body).to eq(response)
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end
