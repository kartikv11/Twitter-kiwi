module BaseModule
  class ApplicationController < ActionController::Base
    # Prevent CSRF attacks by raising an exception.
    # For APIs, you may want to use :null_session instead.
    protect_from_forgery with: :null_session

    # Rescue ParameterMissing Error (due to Strong Parameters mismatch) and call corresponding
    # action to send response back to the user
    rescue_from ActionController::ParameterMissing, with: :send_parameter_missing_error

    # Applying arround filter to perform jobs before and after
    # each action call
    # around_filter do |controller, action|
    #   # around_filter jobs go here
    # end

    # Define utils globally with versioning
    # Kept them as global constants, so that they are specific
    # to this class only
    STATUS_CODES_UTIL = CommonModule::StatusCodes
    CONTENT_UTIL = CommonModule::Content
    RESPONSE_HELPER = CommonModule::ResponseHelper

    #
    # Send response as Parameters missing Error
    # This response is sent to the customer when required parameters (Strong Parameters)
    # for a request were missing. [ Error thrown from params.require(...).permit(...) ]
    #
    def send_parameter_missing_error
      response = {
        error: { message: CONTENT_UTIL::PARAMETER_MISSING },
        status_code: STATUS_CODES_UTIL::BAD_REQUEST
      }
      send_response(response)
    end

    #
    # Send response back to user
    # Proper format of args::
    #   * payload => Data to behttps://github.com/airbnb/ruby#classes send back as message format
    #   * meta => Any meta-data need to be send
    #   * error => Error stack/code
    #   * response => Response code send by service
    #   * status_code => Status code of the response (For compatability)
    #
    # Response will contain only the attributes sent in args.
    # For all the args, if not present empty json is sent
    # except status_code, which is by default as '200 OK SUCCESS'
    #
    # ******** Response Format ************
    # json:
    #   {
    #     payload: {},
    #     meta: {},
    #     error: {}
    #   }
    # status: '<status_code>'
    # *************************************
    #
    # @param args [Json] json array containing attributes to send
    #
    # @return [response] render proper responses based on args
    def send_response(args)
      if args.nil?
        send_default_response
        return
      end
      @response_data = {}
      @response_data[:payload] = args[:payload].present? ? args[:payload] : {}
      @response_data[:meta] = args[:meta].present? ? args[:meta] : {}
      @response_data[:error] = args[:error].present? ? args[:error] : {}
      if args[:response]
        @status_code = RESPONSE_HELPER.get_status_code(args[:response])
      else
        # For compatability, if status_code is sent in args, then use that
        # or else send SUCCESS response
        @status_code = args[:status_code].present? ? args[:status_code] : STATUS_CODES_UTIL::SUCCESS
      end

      render json: @response_data, status: @status_code
      return
    end

    #
    # Send default response to user as '500 Internal Error'
    #
    # @return [response] render default empty response
    def send_default_response
      @response_data = {
        :payload => {},
        :meta => {},
        :error => {}
      }
      @status_code = STATUS_CODES_UTIL::INTERNAL_SERVER_ERROR
      render json: @response_data, status: @status_code
    end

    def send_redirect
      # TO-DO , Can be a generic function for sending redirects
    end

  end
end
