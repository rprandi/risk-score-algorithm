class IsMarriedDisabilityRule
  def self.apply(params)
    return -1 if params[:marital_status] == 'married'
    0
  end
end
