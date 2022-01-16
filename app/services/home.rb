class HomeRules < RiskRules
  def initialize(params)
    @params = params

    @score_calculation_rules = [
      BelowThirtyYearsOldRule,
      HouseMortgagedRule,
      BelowFortyYearsOldRule,
      IncomeAbove200000Rule,
    ]

    @eligibility_rules = [
      NoHomeRule
    ]
  end
end
