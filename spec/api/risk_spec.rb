require_relative '../spec_helper'

RSpec.describe RiskAPI do
  let!(:app) { RiskAPI }


  describe 'POST /risk' do
    it 'Returns a Bad Request when no body is sent' do
      post '/risk'
      expect(last_response.status).to eq(400)
    end

    describe 'when the body is valid' do
      let(:body) {{
        age: 35,
        dependents: 2,
        house: { ownership_status: "owned"},
        income: 0,
        marital_status: "married",
        risk_questions: [0, 1, 0],
        vehicle: { year: 2018}
      }}

      it 'Returns a 200 when the body is valid' do
        post '/risk', body
        expect(last_response.status).to eq(200)
      end
    end
  end
end
