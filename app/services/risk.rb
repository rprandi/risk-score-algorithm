class RiskRules
  @score_calculation_rules = []
  @eligibility_rules = []

  def is_eligible?
    score = true

    @eligibility_rules.each do |rule|
      score &= rule.apply(@params)
    end

    score
  end

  def calculate_score
    score = 0

    @score_calculation_rules.each do |rule|
      score += rule.apply(@params)
    end

    score
  end
end
