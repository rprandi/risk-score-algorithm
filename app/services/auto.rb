class AutoRules < RiskRules
  DEFAULT_BUSINESS_RULES = [
    BelowThirtyYearsOldRule,
    BelowFortyYearsOldRule
  ]

  def initialize(params, new_rules=[])
    @params = params
    @rules = (DEFAULT_BUSINESS_RULES + new_rules).uniq
  end

  def calculate_risk
    score = 0

    @rules.each do |rule|
      score += rule.apply(@params)
    end

    score
  end
end
