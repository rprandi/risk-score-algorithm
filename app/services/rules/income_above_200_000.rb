class IncomeAbove200000Rule
  def self.apply(params)
    return -1 if params[:income] > 200_000
    0
  end
end
