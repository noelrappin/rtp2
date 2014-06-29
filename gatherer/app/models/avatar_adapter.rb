class AvatarAdapter

  attr_accessor :email, :gravatar

  def initialize(email)
    @email = email
    @gravatar = Gravatar.new(email)
  end

  def image_url
    gravatar.image_data
  end

end
