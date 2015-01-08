class Forem::PostSearch

  include ActiveModel::Model
  def initialize(args={})
    args.present? && args.each do |k,v|
      instance_variable_set("@#{k}", v) unless v.nil?
    end
  end

  attr_accessor :text


  def search
    Forem::Post.approved.where("forem_posts.text ilike '%#{@text}%'")
  end

end
