class HasDependantsRule
  def self.apply(params)
    return -1 if params[:dependents] > 0
    0
  end
end
