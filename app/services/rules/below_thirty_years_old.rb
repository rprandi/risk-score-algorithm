class BelowThirtyYearsOldRule
  def self.apply(params)
    return -1 if params[:age] < 30
    0
  end
end
