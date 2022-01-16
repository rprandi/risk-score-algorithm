class VehicleProducedBeforeFiveYearsRule
  def self.apply(params)
    current_year = Time.new.year

    return 1 if params[:vehicle][:year].to_i >= current_year - 5
    0
  end
end
