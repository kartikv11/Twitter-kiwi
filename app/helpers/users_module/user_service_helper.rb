#
# Module handles all the functionality related to User
#
module UsersModule
  #
  # Helper to generate User service responses
  # and other functionalities
  #
  module UserServiceHelper

    #
    # defining global variable
    #
    USER_SERVICE = UsersModule::UserService

    #
    # Create users array containing list of all relevant inforamtion about that User
    # with allowed events
    #
    def self.get_all_user_posts_details_array(user_posts)
      user_posts_array = []
      if user_posts.blank?
        return user_posts_array
      end
      user_posts.each do |user_post|
        user_detail = get_user_details(user_post[:user_id])
        user_post_detail = {
          id: user_post.id,
          content: user_post.content,
          created_at: user_post.created_at.strftime("%A, %d %B %Y, %r"),
          user: user_detail
        }
        user_posts_array.push(user_post_detail)
      end
      return user_posts_array
    end

    #
    # Get details of user
    #
    def self.get_user_details(user_id)
      return {} if user_id.blank?

      user = get_user_from_user_id(user_id)

      user_details = {
        id: user.id,
        name: user.name || '',
        user_name: user.user_name || ''
      }
      return user_details
    end

    #
    # Fetch user corresponding to passed user id
    # @param user_id [Integer] unique id of an user
    #
    # @return [Object] User object
    # @return [nil] if invalid user id passed
    def self.get_user_from_user_id(user_id)
      user_service_instance = USER_SERVICE.new({})
      begin
        user = user_service_instance.get_user_from_user_id(user_id)
      rescue e
        return nil
      end
    end

  end
end
