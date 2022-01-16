class OverSixtyYearsOldRule
  def self.apply(params)
    return false if params[:age] > 60
    true
  end
end
