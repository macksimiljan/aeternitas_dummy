class WebsitesController < ApplicationController

  def create
    @website = Website.new(params.permit(:url))
    if @website.save
      redirect_to root_path
    else
      render 'new'
    end
  end

  def index
    @websites = Website.all
  end
end