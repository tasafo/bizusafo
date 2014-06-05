class HomeController < ApplicationController
  def index
    @stories = Story

    @stories = @stories.send(params[:order] ||= :by_date)
    @stories = @stories.send(params[:filter] ||= :timeline)
    @stories = @stories.timeline
  end
end