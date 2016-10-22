module UsersModule
  class Userpost < BaseModule::BaseModel

    # Define utils globally
    # Kept them as global constants, so that they are specific
    # to this class only
    #

    # Rails >4.0 default_scope definition
    default_scope -> { order(created_at: :desc) }

    belongs_to :user
    validates :user_id, presence: true
    validates :content, presence: true, length: { maximum: 140 }

  end
end
