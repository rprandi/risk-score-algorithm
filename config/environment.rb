require "rubygems"
require "bundler"
Bundler.require(:default)                   # load all the default gems
Bundler.require(Sinatra::Base.environment)  # load all the environment specific gems
require "active_support/deprecation"
require "active_support/all"

require_relative '../app/services/rules/below_thirty_years_old'
require_relative '../app/services/rules/below_forty_years_old'
require_relative '../app/services/rules/no_vehicle'
require_relative '../app/services/rules/income_above_200_000'
require_relative '../app/services/risk'
require_relative '../app/services/auto'
require_relative '../app/api/risk'

