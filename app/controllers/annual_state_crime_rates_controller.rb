class AnnualStateCrimeRatesController < ApplicationController
  def index

  end



  def range_year_crime #This should be refactored into the database or a rake task. d
    range = AnnualStateCrimeRate.range_for_crime(params["crime"])
    gon.global.min = range.min
    gon.global.max = range.max
    gon.global.year_data = AnnualStateCrimeRate.rates_for_year_and_crime(params["form_year"], params["crime"])
    binding.pry
    @crimes = Crime.all
    redirect_to root_path
  end



end
