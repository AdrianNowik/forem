class Forem::PostSearchesController < Forem::ApplicationController

  def results
    @results = Forem::PostSearch.new(post_search_params).search
  end

  private

  def post_search_params
    params.require(:post_search).permit :text
  end
end
