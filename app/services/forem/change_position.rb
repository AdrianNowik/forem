class Forem::ChangePosition < Forem::Positioning

  def initialize(record, direction)
    @direction = direction
    @position = record.position
    @record = record
    @association = set_association(record)

  end

  def process
    if @direction == 'down'
      moved = @association.find_by(position: @position - 1)
      moved.update_attribute(:position, moved.position + 1)
      @record.update_attribute(:position, @position - 1)
    elsif @direction == 'up'
      moved = @association.find_by(position: @position + 1)
      moved.update_attribute(:position, moved.position - 1)
      @record.update_attribute(:position, @position + 1)
    end
  end

end
