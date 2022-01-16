class HouseMortgagedRule
  def self.apply(params)
    return 1 if params[:house].present? && params[:house][:ownership_status] == 'mortgaged'
    0
  end
end
