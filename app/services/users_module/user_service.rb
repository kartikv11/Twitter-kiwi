module UsersModule
  class UserService < BaseModule::BaseService

    def initialize(params = '')
      @params = params
      @users_dao = UsersModule::UsersDao.new(@params)
    end

    #
    # To signup a user
    #
    # Parameters::
    #   * signup_params [hash]
    #
    # @return [response]
    def signup(signup_params)
      validate_user_name(signup_params[:user_name])
      validate_email_id(signup_params[:email_id])
      @users_dao.create_user(signup_params)
    end

    #
    # To create a user's post
    #
    # Parameters::
    #   * id [integer] User who is posting the post
    #   * content [String] Content being posted by the user
    #
    # @return [response]
    def create_user_post(user_params)
      user = validate_user_existence(user_params[:id])
      @users_dao.create_user_post({
          user: user,
          content: user_params[:user][:content]
        })
    end

    #
    # To create a user's following
    #
    # Parameters::
    #   * id [integer] User who is posting the post
    #   * following_id [integer] user_id of user which is to be followed
    #
    # @return [response]
    def create_user_following(user_params)
      requesting_user = validate_user_existence(user_params[:id])
      another_user = validate_user_existence(user_params[:user][:following_id])

      @users_dao.create_user_relationship({
          user: requesting_user,
          following: another_user
        })
    end

    #
    # To fetch user's timeline
    #
    # Parameters::
    #   * id [integer] User who is posting the post
    #   * pagination_params [Hash] params for pagination
    #
    # @return [response]
    def get_user_timeline(timeline_args)
      user = validate_user_existence(timeline_args[:id])
      @users_dao.get_user_timeline({
          user: user,
          pagination_params: timeline_args[:pagination_params]
        })
    end

    def get_user_from_user_id(user_id)
      user = @users_dao.get_by_field('id', user_id)
    end

    ###############################
    #       Private Functions     #
    ###############################

    private

    #
    # find & validate user existence
    #
    def validate_user_existence(user_id)
      user = get_user_from_user_id(user_id)
      raise CUSTOM_ERROR_UTIL::UnAuthenticatedUserError.new(CONTENT_UTIL::USER_NOT_FOUND) if user.blank?
      return user
    end

    #
    # Function to validate user_name
    #
    def validate_user_name(user_name)
      if @users_dao.get_by_field('user_name', user_name).present?
        raise CUSTOM_ERROR_UTIL::InvalidDataError.new(CONTENT_UTIL::FIELD_ALREADY_TAKEN % {field: 'UserName'})
      end
    end

    #
    # Function to validate user_name
    #
    def validate_email_id(email_id)
      if @users_dao.get_by_field('email_id', email_id).present?
        raise CUSTOM_ERROR_UTIL::InvalidDataError.new(CONTENT_UTIL::ALREADY_REGISTERED)
      end
    end

  end
end
