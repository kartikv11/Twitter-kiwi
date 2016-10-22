#
# Module to handle functionalities related to User
#
module UsersModule
  #
  # API to follow another user
  #
  class FollowUserApi < BaseModule::BaseApi

    USER_SERVICE = UsersModule::UserService
    USER_RESPONSE_DECORATOR = UsersModule::UserResponseDecorator

    def initialize(params = '')
      @params = params
    end

    #
    # Validate user's follow request hash and create the following
    #
    # @return [Response] [response to be sent to the user]
    #
    def enact(request)
      begin
        validate_following_request(request)
        user_service = USER_SERVICE.new(@params)
        response = user_service.create_user_following(request)
        return USER_RESPONSE_DECORATOR.create_success_response
      rescue CUSTOM_ERROR_UTIL::UnAuthenticatedUserError => e
        return USER_RESPONSE_DECORATOR.create_response_unauthenticated_user(e.message)
      rescue CUSTOM_ERROR_UTIL::InsufficientDataError, CUSTOM_ERROR_UTIL::InvalidDataError, CUSTOM_ERROR_UTIL::InvalidArgumentsError => e
        return USER_RESPONSE_DECORATOR.create_response_bad_request(e.message)
      end
    end

    #
    # Function to validate user's request for following
    #
    def validate_following_request(request)
      if request[:id].blank? || request[:user][:following_id].blank?
        raise CUSTOM_ERROR_UTIL::InsufficientDataError.new(CONTENT_UTIL::INSUFFICIENT_DATA)
      end
    end

  end
end
