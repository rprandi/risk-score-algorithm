class NoHomeRule
  def self.apply(params)
    return false if params[:house].empty?
    true
  end
end
