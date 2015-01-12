require 'friendly_id'

module Forem
  class Category < ActiveRecord::Base
    extend FriendlyId
    friendly_id :name, :use => [:slugged, :finders]

    has_many :forums
    validates :name, :presence => true
    validates :position, numericality: { only_integer: true }

    def to_s
      name
    end

    def self.reorganize_positions(position)
      where('position > ?', position).map{ |category| category.update(position: category.position - 1) }
    end

  end
end
