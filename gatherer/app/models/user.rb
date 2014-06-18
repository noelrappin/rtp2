class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  ##START:roles
  has_many :roles
  has_many :projects, through: :roles
  ##END:roles

  ##START:can_view
  def can_view?(project)
    projects.to_a.include?(project)
  end
  ##END:can_view
end
