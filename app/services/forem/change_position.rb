class Forem::ChangePosition

  def initialize(record, direction)
    @direction = direction
    @position = record.position
    @record = record

  end

  def process
    if @direction == 'down'
      moved = @record.class.find_by(position: @position - 1)
      moved.update_attribute(:position, moved.position + 1)
      @record.update_attribute(:position, @position - 1)
    elsif @direction == 'up'
      moved = @record.class.find_by(position: @position + 1)
      moved.update_attribute(:position, moved.position - 1)
      @record.update_attribute(:position, @position + 1)
    end
  end

end
