class HomeController < ApplicationController
  def index
    @stories = Story.timeline.sort{ |s1, s2| s2.ratings.positive.size <=> s1.ratings.positive.size }
  end
end
