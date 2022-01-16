class NoIncomeRule
  def self.apply(params)
    return false if params[:income] == 0
    true
  end
end
