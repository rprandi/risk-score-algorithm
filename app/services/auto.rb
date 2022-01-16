class AutoRules < RiskRules
  def initialize(params)
    @params = params

    @score_calculation_rules = [
      BelowThirtyYearsOldRule,
      BelowFortyYearsOldRule,
      IncomeAbove200000Rule,
      VehicleProducedBeforeFiveYearsRule
    ]

    @eligibility_rules = [
      NoVehicleRule
    ]
  end
end
