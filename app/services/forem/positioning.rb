class Forem::Positioning

  def set_association(record)
    case record.class.name
    when 'Forem::Category'
      Forem::Category
    when 'Forem::Forum'
      record.category.forums
    end
  end

end
