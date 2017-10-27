module Predicate
  def isa?(target_class)
    instance_of?(target_class)
  end

  def to_sa(object)
    if object.instance_of?(Actor)
      then puts "Actor #{object.name} has ID: #{object.id}.\n"
    elsif object.instance_of?(Song)
      then puts "<< #{object.name} >> by #{object.artist} in their album #{object.album} is owed by #{object.owners} .\n"
    elsif object.instance_of?(Album)
      then puts "The album #{object.name} by #{object.artist}. \n"
    end
  end

end
