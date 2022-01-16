class NoVehicleRule
  def self.apply(params)
    return false if params[:vehicle].empty?
    true
  end
end
