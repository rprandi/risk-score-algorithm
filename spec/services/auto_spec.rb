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

  describe 'is_eligible?' do
    describe 'when user has no vehicle' do
      it 'returns false' do
        eligible = subject.new(default_params.merge({ vehicle: {}})).is_eligible?
        expect(eligible).to eq(false)
      end
    end

    describe 'when user has vehicle' do
      it 'returns true' do
        eligible = subject.new(default_params).is_eligible?
        expect(eligible).to eq(true)
      end
    end
  end

  describe '.calculate_score' do
    describe 'Age Rule' do
      describe 'when user has 29 years old' do
        it 'returns score of -2' do
          risk_score = subject.new(default_params.merge({ age: 29 })).calculate_score
          expect(risk_score).to eq(-2)
        end
      end
      describe 'when user has 30 years old' do
        it 'returns score of -1' do
          risk_score = subject.new(default_params.merge({ age: 30 })).calculate_score
          expect(risk_score).to eq(-1)
        end
      end
      describe 'when user has 39 years old' do
        it 'returns score of -1' do
          risk_score = subject.new(default_params.merge({ age: 39 })).calculate_score
          expect(risk_score).to eq(-1)
        end
      end
      describe 'when user has 40 years old' do
        it 'returns score of 0' do
          risk_score = subject.new(default_params.merge({ age: 40 })).calculate_score
          expect(risk_score).to eq(0)
        end
      end
    end

    describe 'Income Rule' do
      describe 'when income is 200_000' do
        it 'returns score of 0' do
          risk_score = subject.new(default_params.merge({ income: 200_000 })).calculate_score
          expect(risk_score).to eq(0)
        end
      end

      describe 'when income is less than 200_000' do
        it 'returns score of 0' do
          risk_score = subject.new(default_params.merge({ income: 199_999 })).calculate_score
          expect(risk_score).to eq(0)
        end
      end

      describe 'when income is more than 200_000' do
        it 'returns score of -1' do
          risk_score = subject.new(default_params.merge({ income: 200_001 })).calculate_score
          expect(risk_score).to eq(-1)
        end
      end
    end
  end
end
