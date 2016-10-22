module UsersModule

	class UsersDao < BaseModule::BaseDao

    def initialize(params = '')
      @params = params
      super
    end

    #
    # Create the record
    #
    # @param args [hash] model arguments
    #
    # @return [Model]
    #
    # @error [InvalidArgumentsError] if it fails to create
    #
    def create_user(args)
      message = 'User ' if message.blank?
      user = UsersModule::User.new(args)

      begin
        user.save!
        return user
      rescue ActiveRecord::RecordInvalid => e
        raise CUSTOM_ERROR_UTIL::InvalidArgumentsError.new('User Signup Failed!, ' + e.message)
      end
    end

    # def update(args, user)
    #   update_model(args, user, 'User')
    # end

    def get_by_id(id)
      get_model_by_id(UsersModule::User, id)
    end

    def get_by_field(field_name, field_value)
      get_model_by_field(UsersModule::User, field_name, field_value)
    end

    #
    # Get all users as per the paginate params
    # Pagination params:
    #  - order: In which order want users list (ASC/DESC) (not being passed at API level)
    #  - sort_by: key on which data is to be sorted (ex: id/name/status) (not being passed at API level)
    #  - page_no: Page number offset
    #  - per_page: entries to fetch per page
    #
    # @param paginate_params [JSON] [Hash containing pagination attributes]
    #
    # @return [Array] [Array of all matched entries]
    #
    def get_user_timeline(timeline_args)
      pagination_params = timeline_args[:pagination_params]
      user = timeline_args[:user]

      pagination_params = pagination_params.merge({
        sort_by: 'created_at',
        order: 'ASC'
        })
      get_paginated_data(user.streamed_feed, UsersModule::Userpost, pagination_params)
    end

    #
    # Create the post for a user
    #
    # @param args [hash] userpost model arguments
    #
    # @return [Model]
    #
    # @error [InvalidArgumentsError] if it fails to create
    #
    def create_user_post(user_post_params)
      user = user_post_params[:user]
      content = user_post_params[:content]
      begin
        user.userposts.create!(content: content)
      rescue ActiveRecord::RecordInvalid => e
        raise CUSTOM_ERROR_UTIL::InvalidDataError.new('Post Creation failed!, ' + e.message)
      end
    end

    #
    # Create the following for a user
    #
    # @param args [hash] relationship model arguments
    #
    # @return [Model]
    #
    # @error [InvalidArgumentsError] if it fails to create
    #
    def create_user_relationship(user_relationship_params)
      requesting_user = user_relationship_params[:user]
      another_user = user_relationship_params[:following]
      begin
        requesting_user.follow(another_user)
      rescue ActiveRecord::RecordNotUnique => e
        raise CUSTOM_ERROR_UTIL::InvalidDataError.new('Relationship already exists!')
      end
    end

  end
end
