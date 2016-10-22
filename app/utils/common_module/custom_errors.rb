# Module to contain all kind of custom errors raised/rescued
# during the operation
module CommonModule
  module CustomErrors
    class UnAuthorizedUserError < BaseModule::BaseErrors
      attr_accessor :failed_action, :message
      def initialize(message="")
        @failed_action = UnAuthorizedUserError
        @message = message
      end
    end

    class UnAuthenticatedUserError < BaseModule::BaseErrors
      attr_accessor :failed_action, :message
      def initialize(message="")
        @failed_action = UnAuthenticatedUserError
        @message = message
      end
    end

    class InsufficientDataError < BaseModule::BaseErrors
      attr_accessor :failed_action, :message
      def initialize(message="")
        @failed_action = InsufficientDataError
        @message = message
      end
    end

    class InvalidDataError < BaseModule::BaseErrors
      attr_accessor :failed_action, :message
      def initialize(message="")
        @failed_action = InvalidDataError
        @message = message
      end
    end

    class RunTimeError < BaseModule::BaseErrors
      attr_accessor :failed_action, :message
      def initialize(message="")
        @failed_action = RunTimeError
        @message = message
      end
    end

    class ExistingUserError < BaseModule::BaseErrors
      attr_accessor :failed_action, :message
      def initialize(message="")
        @failed_action = ExistingUserError
        @message = message
      end
    end

    class WrongOtpError < BaseModule::BaseErrors
      attr_accessor :failed_action, :message
      def initialize(message="")
        @failed_action = WrongOtpError
        @message = message
      end
    end

    class AuthenticationTimeoutError < BaseModule::BaseErrors
      attr_accessor :failed_action, :message
      def initialize(message="")
        @failed_action = AuthenticationTimeoutError
        @message = message
      end
    end

    class ResourceNotFoundError < BaseModule::BaseErrors
      attr_accessor :failed_action, :message
      def initialize(message="")
        @failed_action = ResourceNotFoundError
        @message = message
      end
    end

    class WrongPasswordError < BaseModule::BaseErrors
      attr_accessor :failed_action, :message
      def initialize(message="")
        @failed_action = WrongPasswordError
        @message = message
      end
    end

    class ReachedMaximumLimitError < BaseModule::BaseErrors
      attr_accessor :failed_action, :message
      def initialize(message="")
        @failed_action = ReachedMaximumLimitError
        @message = message
      end
    end

    class WrongReferralCodeError < BaseModule::BaseErrors
      attr_accessor :failed_action, :message
      def initialize(message="")
        @failed_action = WrongReferralCodeError
        @message = message
      end
    end

    class PreConditionRequiredError < BaseModule::BaseErrors
      attr_accessor :failed_action, :message
      def initialize(message="")
        @failed_action = PreConditionRequiredError
        @message = message
      end
    end

    class InvalidArgumentsError < BaseModule::BaseErrors
      attr_accessor :failed_action, :message
      def initialize(message="")
        @failed_action = InvalidArgumentsError
        @message = message
      end
    end

    class RecordNotFoundError < BaseModule::BaseErrors
      attr_accessor :failed_action, :message
      def initialize(message="")
        @failed_action = RecordNotFoundError
        @message = message
      end
    end

    class RecordAlreadyExistsError < BaseModule::BaseErrors
      attr_accessor :failed_action, :message
      def initialize(message="")
        @failed_action = RecordAlreadyExistsError
        @message = message
      end
    end

    class UserNotFoundError < StandardError
      attr_accessor :failed_action, :message
      def initialize(message="")
        @failed_action = UserNotFoundError
        @message = message
      end
    end

    class EmailNotFoundError < StandardError
      attr_accessor :failed_action, :message
      def initialize(message="")
        @failed_action = EmailNotFoundError
        @message = message
      end
    end

  end
end
