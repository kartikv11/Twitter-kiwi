# Module contain all common functionalities
module CommonModule
  # This class contain all the regex utilities
  class RegexUtil < BaseModule::BaseUtil

    #Regex to validate a generic email id
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  end
end
