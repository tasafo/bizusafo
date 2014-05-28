class HomeController < ApplicationController
  def index
    @stories = Story.timeline
  end
end
