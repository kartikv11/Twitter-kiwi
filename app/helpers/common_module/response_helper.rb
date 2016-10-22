#
# Module for storing mapping between ResponseCodes (from service layer)
# to StatusCodes (from controller layer to user)
# @author [kartik] <kartx111@gmail.com>
#
module CommonModule
  module ResponseHelper
    # Define utils globally with versioning
    RESPONSE_CODES_UTIL = CommonModule::ResponseCodes
    STATUS_CODES_UTIL = CommonModule::StatusCodes

    RESPONSE_STATUS_MAP = {
      RESPONSE_CODES_UTIL::SUCCESS => STATUS_CODES_UTIL::SUCCESS,
      RESPONSE_CODES_UTIL::NO_CONTENT => STATUS_CODES_UTIL::NO_CONTENT,
      RESPONSE_CODES_UTIL::BAD_REQUEST => STATUS_CODES_UTIL::BAD_REQUEST,
      RESPONSE_CODES_UTIL::UN_AUTHORIZED => STATUS_CODES_UTIL::UN_AUTHORIZED,
      RESPONSE_CODES_UTIL::FORBIDDEN => STATUS_CODES_UTIL::FORBIDDEN,
      RESPONSE_CODES_UTIL::NOT_FOUND => STATUS_CODES_UTIL::NOT_FOUND,
      RESPONSE_CODES_UTIL::AUTHENTICATION_TIMEOUT => STATUS_CODES_UTIL::AUTHENTICATION_TIMEOUT,
      RESPONSE_CODES_UTIL::UNPROCESSABLE_ENTITY => STATUS_CODES_UTIL::UNPROCESSABLE_ENTITY,
      RESPONSE_CODES_UTIL::PRE_CONDITION_REQUIRED => STATUS_CODES_UTIL::PRE_CONDITION_REQUIRED,
      RESPONSE_CODES_UTIL::TOO_MANY_REQUESTS => STATUS_CODES_UTIL::TOO_MANY_REQUESTS,
      RESPONSE_CODES_UTIL::INTERNAL_SERVER_ERROR => STATUS_CODES_UTIL::INTERNAL_SERVER_ERROR,
      RESPONSE_CODES_UTIL::PRE_CONDITION_FAILED => STATUS_CODES_UTIL::PRE_CONDITION_FAILED,
      RESPONSE_CODES_UTIL::CONFLICT_IN_STATE => STATUS_CODES_UTIL::CONFLICT_IN_STATE
    }

    #
    # Get status code corresponding to response code
    # @param response_code [String] response code
    #
    # @return [String] corresponding status code
    def self.get_status_code(response_code)
      return nil if response_code.blank?
      RESPONSE_STATUS_MAP[response_code]
    end
  end
end
