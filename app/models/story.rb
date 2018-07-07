class Story < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    title  :string
    body   :text
    status :string
    tasks_count :integer, default: 0, null: false
    timestamps
  end
  attr_accessible :title, :body, :status, :status_id, :project, :project_id, :tasks

  validates_presence_of :title

  belongs_to :project, inverse_of: :stories, counter_cache: true
  
  has_many :tasks, dependent: :destroy, inverse_of: :story

  children :tasks

  # --- Permissions --- #

  def create_permitted?
    acting_user.signed_up?
  end

  def update_permitted?
    acting_user.signed_up? && !project_changed?
  end

  def destroy_permitted?
    acting_user.signed_up?
  end

  def view_permitted?(field)
    true
  end

end
