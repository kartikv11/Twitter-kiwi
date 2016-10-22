module UsersModule
  class User < BaseModule::BaseModel

    # Define utils globally
    # Kept them as global constants, so that they are specific
    # to this class only

    # regular expression for the validation if email is in valid format or not
    VALID_EMAIL_REGEX = CommonModule::RegexUtil::VALID_EMAIL_REGEX

    # a user has_many userposts, destroys dependent userposts if user is destroyed
    has_many :userposts, dependent: :destroy


    ### operates for user.followings relationship ###
    has_many :active_relationships, class_name:  "Relationship",
                                  foreign_key: "follower_id",
                                  dependent:   :destroy

    has_many :followings, through: :active_relationships
    ####################################


    ### operates for user.followers passive relationship ###
    has_many :passive_relationships, class_name:  "Relationship",
                                   foreign_key: "following_id",
                                   dependent:   :destroy

    has_many :followers, through: :passive_relationships
    ###################################


    # validates the presence of name field
  	validates :name, presence: true, length: { maximum: 50 }

    # validates the presence of user_name field
  	validates :user_name, presence: true, length: { maximum: 10 }

    # validates the presence, format of email_id field.
    validates :email_id, presence: true, length: { maximum: 255 },
                      format: { with: VALID_EMAIL_REGEX },
                      uniqueness: { case_sensitive: false }

    before_save { self.email_id = email_id.downcase }

    has_secure_password
    validates :password, presence: true, length: { minimum: 6 }


    # Returns user's streamed feed consisting of other followings of this user
    def streamed_feed
      Userpost.where("user_id IN (:following_ids) OR user_id = :user_id",
                following_ids: following_ids, user_id: id)
    end

    # Follows another user
    def follow(another_user)
      active_relationships.create(following_id: another_user.id)
    end

    # Unfollows another user
    def unfollow(another_user)
      active_relationships.find_by(following_id: another_user.id).destroy
    end

    # Returns true iff current user is following the another user
    def following?(another_user)
      following.include?(another_user)
    end

  end
end
