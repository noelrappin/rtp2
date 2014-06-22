class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :roles
  has_many :projects, through: :roles

  ##START:new_can_view
  def can_view?(project)
    visible_projects.include?(project)
  end
  ##END:new_can_view

  ##START:visible_projects
  def visible_projects
    return Project.all.to_a if admin?
    (projects.to_a + Project.all_public).uniq.sort_by(&:id)
  end
  ##END:visible_projecs
end
