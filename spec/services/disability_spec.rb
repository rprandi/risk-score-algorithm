require_relative '../spec_helper'

RSpec.describe DisabilityRules do
  let!(:subject) { DisabilityRules }

  let(:default_params) {
    {
      age: 50,
      dependents: 0,
      house: { ownership_status: "owned"},
      income: 100,
      marital_status: "single",
      risk_questions: [0, 1, 0],
      vehicle: { year: 2000 }
    }
  }

  describe 'is_eligible?' do
    describe 'Age Rule' do
      describe 'when user is over 60 years old' do
        it 'returns false' do
          eligible = subject.new(default_params.merge({ age: 61 })).is_eligible?
          expect(eligible).to eq(false)
        end
      end

      describe 'when user is exactly 60 years old' do
        it 'returns true' do
          eligible = subject.new(default_params.merge({ age: 60 })).is_eligible?
          expect(eligible).to eq(true)
        end
      end

      describe 'when user is below 60 years old' do
        it 'returns true' do
          eligible = subject.new(default_params.merge({ age: 59 })).is_eligible?
          expect(eligible).to eq(true)
        end
      end
    end

    describe 'Income Rule' do
      describe 'when user has no income' do
        it 'returns false' do
          eligible = subject.new(default_params.merge({ income: 0 })).is_eligible?
          expect(eligible).to eq(false)
        end
      end

      describe 'when user has income > 0' do
        it 'returns true' do
          eligible = subject.new(default_params.merge({ income: 1 })).is_eligible?
          expect(eligible).to eq(true)
        end
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

    describe 'Dependent Rule' do
      describe 'when user has no dependents' do
        it 'returns score of 0' do
          risk_score = subject.new(default_params.merge({ dependents: 0 })).calculate_score
          expect(risk_score).to eq(0)
        end
      end
      describe 'when user has dependents' do
        it 'returns score of 1' do
          risk_score = subject.new(default_params.merge({ dependents: 1 })).calculate_score
          expect(risk_score).to eq(1)
        end
      end

    end

    describe 'Marriage Rule' do
      describe 'when user is married' do
        it 'returns score of -1' do
          risk_score = subject.new(default_params.merge({ marital_status: "married" })).calculate_score
          expect(risk_score).to eq(-1)
        end
      end
      describe 'when user is single' do
        it 'returns score of 0' do
          risk_score = subject.new(default_params.merge({ marital_status: "single" })).calculate_score
          expect(risk_score).to eq(0)
        end
      end

    end

    describe 'House Mortgaged Rule' do
      describe 'when user has a mortgaged house' do
        it 'returns score of 1' do
          risk_score = subject.new(default_params.merge({ house: { ownership_status: "mortgaged" } })).calculate_score
          expect(risk_score).to eq(-1)
        end
      end
      describe 'when user has an owned house' do
        it 'returns score of 0' do
          risk_score = subject.new(default_params.merge({ house: { ownership_status: "owned" } })).calculate_score
          expect(risk_score).to eq(0)
        end
      end

    end
  end
end
