module CommonModule
  class Content < BaseModule::BaseUtil
    # Model CRUD content
    OK_RESPONSE = 'Success'
    CREATED_SUCCESSFULLY = '%{model} created successfully'
    CREATION_FAILED = 'Failed to create %{model}'
    UPDATION_FAILED = 'Failed to update %{model}'
    # Access Control Content
    UNAUTHENTIC_USER = 'User not authenticated'
    UNAUTHORIZED_USER = 'Access Denied! Not authorized to access this API'
    INSUFFICIENT_DATA = 'Insufficient data passed'
    #When OTP or email token Expired
    AUTHENTICATION_TIMEOUT = 'Authentication request timeout'
    # when generic provider exists
    EXISTING_USER = 'User is already signed up'
    # InternalServerError
    RUN_TIME_ERROR = 'Internal server error occurred'
    # when resource not found
    NOT_FOUND = 'Resource not found'
    # when transaction status is invalid
    INVALID_STATUS = 'Invalid transaction status'
    # When password doesn't matches
    WRONG_PASSWORD = 'Wrong Password'
    # When too many requests
    TOO_MANY_REQUESTS = 'You have reached the maximum limit'
    # Page Not Found
    PAGE_NOT_FOUND = 'Page Not Found'
    # Parameter missing in POST/PUT requests
    PARAMETER_MISSING = "Request parameters missing"

    # When we are unable to process/find relevant information from the data passed by user
    INVALID_DATA_PASSED = 'Invalid data passed'

    # when invalid email is sent
    INVALID_EMAIL_ID = 'Not a valid Email ID'
    # Email id not found for authentication token
    EMAIL_NOT_FOUND = 'Email ID not registered'

    USER_NOT_FOUND = 'User not found'

    # when employee is already registered as a customer
    ALREADY_REGISTERED = 'You are already registered, please Login'

    # Field must present
    FIELD_MUST_PRESENT = "%{field} must be present"
    # Field has already been taken
    FIELD_ALREADY_TAKEN =  "%{field} has already been taken"

    # Password Mismatch
    PASSWORD_MISMATCH = "Password Mismatch"

    # Not found generic content
    RESOURCE_NOT_FOUND = "%{resource} not found"

    #Request blank
    REQUEST_BLANK = 'Request cannot be blank'

    # field not found
    REQUESTED_FIELD_NOT_FOUND = '%{field} not found'
    # when email id is already taken
    UNIQUE_EMAIL = 'Email ID has already been taken'
  end
end
