class DisabilityRules < RiskRules
  SCORE_CALCULATION_RULES = [
    BelowThirtyYearsOldRule,
    HouseMortagedDisabilityRule,
    BelowFortyYearsOldRule,
    IncomeAbove200000Rule,
    HasDependantsRule,
    IsMarriedRule,
  ]

  ELIGIBILITY_RULES = [
    NoIncomeRule,
    OverSixtyYearsOldRule
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
