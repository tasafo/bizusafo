namespace :reset_story_rating_counter do
  task :run => :environment do
    Story.all.each do |story| 
      counter = story.ratings.positive.size - story.ratings.negative.size
      story.update_attributes rating_counter: counter
    end
  end
end