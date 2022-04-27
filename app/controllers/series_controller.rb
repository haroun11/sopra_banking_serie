class SeriesController < ApplicationController

  def index
    if params[:query].present?
      @series = Serie.search(params[:query])
    else
		  @series = Serie.all
    end
	end

end
