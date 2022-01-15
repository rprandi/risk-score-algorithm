class AutoRules < RiskRules
  SCORE_CALCULATION_RULES = [
    BelowThirtyYearsOldRule,
    BelowFortyYearsOldRule
  ]

  ELIGIBILITY_RULES = [
    NoVehicleRule
  ]

  def initialize(params)
    @params = params
  end


  def is_eligible?
    score = true

    ELIGIBILITY_RULES.each do |rule|
      score &= rule.apply(@params)
    end

    score
  end

  def calculate_score
    score = 0

    SCORE_CALCULATION_RULES.each do |rule|
      score += rule.apply(@params)
    end

    score
  end
end
