class DisabilityRules < RiskRules
  def initialize(params)
    @params = params

    @score_calculation_rules = [
      BelowThirtyYearsOldRule,
      HouseMortgagedRule,
      BelowFortyYearsOldRule,
      IncomeAbove200000Rule,
      HasDependentsRule,
      IsMarriedDisabilityRule,
    ]

    @eligibility_rules = [
      NoIncomeRule,
      OverSixtyYearsOldRule
    ]
  end
end
