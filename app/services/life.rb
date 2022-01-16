class LifeRules < RiskRules
  def initialize(params)
    @params = params

    @score_calculation_rules = [
      BelowThirtyYearsOldRule,
      BelowFortyYearsOldRule,
      IncomeAbove200000Rule,
      HasDependentsRule,
      IsMarriedLifeRule,
    ]

    @eligibility_rules = [
      OverSixtyYearsOldRule
    ]
  end
end
