class HomeController < ApplicationController
  def index
    @stories = Story::Filter.new.filter(params)
  end
end
