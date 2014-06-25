class Story::Filter
  DEFAULT_FILTERS = {
    order: :by_date,
    filter: :by_current_month
  }

  attr_reader :stories, :params

  def filter(params)
    @params = params

    @stories = Story.page @params[:page]
    @stories = @stories.tagged_with(splited_tags(@params[:tags])) if @params[:tags].present?
    @stories = @stories.send(@params[:order] ||= DEFAULT_FILTERS[:order])
    @stories = @stories.send(@params[:filter] ||= DEFAULT_FILTERS[:filter])
    @stories = @stories.timeline
  end

  private

  def splited_tags(tags)
    tags.split(",").map(&:strip)
  end
end