require "rubygems"
require "bundler"
Bundler.require(:default)
Bundler.require(Sinatra::Base.environment)
require "active_support/deprecation"
require "active_support/all"

require_relative '../app/services/rules/below_forty_years_old'
require_relative '../app/services/rules/below_thirty_years_old'
require_relative '../app/services/rules/has_dependants'
require_relative '../app/services/rules/house_mortgaged_disability'
require_relative '../app/services/rules/income_above_200_000'
require_relative '../app/services/rules/is_married'
require_relative '../app/services/rules/no_income'
require_relative '../app/services/rules/no_vehicle'
require_relative '../app/services/rules/over_sixty_years_old'
require_relative '../app/services/rules/vehicle_produced_before_five_years'
require_relative '../app/services/risk'
require_relative '../app/services/auto'
require_relative '../app/api/risk'
