class HomeController < ApplicationController
  def index
    @stories = Story::Filter.new.filter(params)
  end

  def feed
    @stories = Story.all
    respond_to do |format|
      format.rss { render layout: false }
      format.atom { render 'feed.rss', layout: false }
      format.html { render 'feed.rss', layout: false }
    end
  end
end
