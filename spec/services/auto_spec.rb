require_relative '../spec_helper'

RSpec.describe AutoRules do
  let!(:subject) { AutoRules }

  let(:default_params) {
    {
      age: 50,
      dependents: 2,
      house: { ownership_status: "owned"},
      income: 0,
      marital_status: "married",
      risk_questions: [0, 1, 0],
      vehicle: { year: 2018 }
    }
  }

  describe 'Age Rule' do
    describe 'when user has 29 years old' do
      it 'returns score of -2' do
        risk_score = subject.new(default_params.merge({ age: 29 })).calculate_risk
        expect(risk_score).to eq(-2)
      end
    end
    describe 'when user has 30 years old' do
      it 'returns score of -1' do
        risk_score = subject.new(default_params.merge({ age: 30 })).calculate_risk
        expect(risk_score).to eq(-1)
      end
    end
    describe 'when user has 39 years old' do
      it 'returns score of -1' do
        risk_score = subject.new(default_params.merge({ age: 39 })).calculate_risk
        expect(risk_score).to eq(-1)
      end
    end
    describe 'when user has 40 years old' do
      it 'returns score of 0' do
        risk_score = subject.new(default_params.merge({ age: 40 })).calculate_risk
        expect(risk_score).to eq(0)
      end
    end
  end
end
