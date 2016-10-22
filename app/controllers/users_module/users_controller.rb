module UsersModule
  class UsersController < BaseModule::ApplicationController


    ##################################################################################
    #                                  signup API                                    #
    ##################################################################################
    # POST users/signup/
    #
    # API to signup user
    #
    # Request::
    #    * user_name unique user_name
    #    * name user's name
    #    * email_id unique email_id of the user
    #    * password
    #    * password_confirmation
    #
    # Response::
    #    * 200 ok: if user state changed successfully
    #
    def signup
      user_signup_api = UsersModule::UserSignupApi.new
      response = user_signup_api.enact(user_params)
      send_response(response)
    end


    ##################################################################################
    #                            user_post API                                       #
    ##################################################################################
    # POST users/post/
    #
    # API to submit a user post
    #
    # Request::
    #    * id unique id of user who is posting the post (from path)
    #    * content content of post
    #
    # Response::
    #    * 200 ok: if user is able to post successfully
    #
    def user_post
      user_post_api = UsersModule::UserPostApi.new
      response = user_post_api.enact({
        id: params[:id],
        user: user_post_params
        })
      send_response(response)
    end

    ##################################################################################
    #                               follow API                                       #
    ##################################################################################
    # POST users/:id/follow
    #
    # API to follow another user
    #
    # Request::
    #    * id unique user_id of user who is requesting (from path)
    #    * follower_id user_id of the user to be followed
    #
    # Response::
    #    * 200 ok: if user is able to follow the requested user successfully
    #
    def follow
      follow_user_api = UsersModule::FollowUserApi.new
      response = follow_user_api.enact({
        id: params[:id],
        user: follow_user_params
        })
      send_response(response)
    end

    ##################################################################################
    #                               timeline API                                     #
    ##################################################################################
    # GET users/:id/timeline
    #
    # API to get user's timeline
    #
    # Request::
    #    * id unique user_id of user who is requesting (from path)
    #
    # Response::
    #    * posts: [Array] containing posts and their author users
    #    * 200 ok: if user is able to follow the requested user successfully
    #
    def timeline
      user_timeline_api = UsersModule::UserTimelineApi.new
      response = user_timeline_api.enact({
        id: params[:id],
        pagination_params: pagination_params
      })
      send_response(response)
    end

    ###############################
    #       Private Functions     #
    ###############################

    private

    def user_params
      params.require(:user).permit(:user_name, :name, :email_id, :password,
                                   :password_confirmation)
    end

    def user_post_params
      params.require(:user).permit(:content)
    end

    def follow_user_params
      params.require(:user).permit(:following_id)
    end

    #
    # White list params for get_all_users API
    # :sort_by and :order is also supported but not exposing it as timeline will always be
    # sorted via 'ASC' on 'created_at'
    #
    def pagination_params
      params.permit(:page_no, :per_page)
    end

  end
end
