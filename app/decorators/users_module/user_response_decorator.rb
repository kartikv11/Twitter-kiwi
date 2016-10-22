module UsersModule
  class UserResponseDecorator < BaseModule::BaseResponseDecorator
    # Define utils globally with versioning
    # Kept them as global constants, so that they are specific
    # to this class only
    RESPONSE_CODES_UTIL = CommonModule::ResponseCodes
    USER_SERVICE_HELPER = UsersModule::UserServiceHelper

    #
    # Send HTTP-UnAuthorized (unauthenticated) response code back to user
    #
    def self.create_response_unauthenticated_user(message = '')
      message = message.present? ? message : CONTENT_UTIL::UNAUTHENTIC_USER
      response = {
        error: { message: message },
        response: RESPONSE_CODES_UTIL::UN_AUTHORIZED
      }
      return response
    end

    #
    # Create response for user signup request
    #
    def self.create_signup_response
      response = {
        payload: { message: 'User Signup successful' },
        response: RESPONSE_CODES_UTIL::SUCCESS
      }
      return response
    end

    #
    # Create response for user timeline
    #
    def self.create_user_timeline_response(timeline_args)
      timeline_posts = USER_SERVICE_HELPER.get_all_user_posts_details_array(timeline_args[:elements])
      response = {
        payload: {
          posts: timeline_posts
        },
        response: RESPONSE_CODES_UTIL::SUCCESS
      }
      if (timeline_args[:page_count])
        response[:meta] = {
          page_count: timeline_args[:page_count]
        }
      end
      return response
    end

  end
end
