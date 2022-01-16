class BelowFortyYearsOldRule
  def self.apply(params)
    return -1 if params[:age] < 40
    0
  end
end
