class ActiveModel::Serializer

  def id
    return object.id.to_s
  end

end
