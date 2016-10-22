#
# Module to handle all the functionalities related to Dao
#
module BaseModule
  #
  # Base module to inject generic utils
  #
  class BaseDao

    CUSTOM_ERROR_UTIL = CommonModule::CustomErrors
    PAGINATION_UTIL = CommonModule::Pagination
    CONTENT = CommonModule::Content

    def initialize(params='')
    end

    #
    # get the mode by id
    #
    # @param id [Integer] model id
    # @param model [Model] model
    #
    # @return [Model]  model if model exists else return nil
    #
    def get_model_by_id(model, id)
      model.find_by(id: id)
    end

    #
    # get the model by field
    #
    # @param field [String] field value
    # @param model [Model] model
    # @param field_name String] field name
    #
    # @return [Model]  model if model exists else return nil
    #
    def get_model_by_field(model, field_name, field_value)
      model_instance = model.find_by(field_name => field_value)
      return model_instance
    end

    #
    # get paginated data
    #
    # @param model [Class] [Model Class]
    # @param data [Array] [ActiveRecord Array of model object elements]
    # @param pagination_params = {} [JSON] [Hash of paginated properties]
    # 
    # @return [Array] array of data object
    #
    def get_paginated_data(data, model, pagination_params = {})
      set_pagination_properties(pagination_params, model)
      page_count = (data.count / @per_page).ceil
      data = data.limit(@per_page).offset((@page_no - 1) * @per_page)
      return {elements: data, page_count: page_count}
    end

    #
    # this function only permit attributes required for the table
    #
    # @return [Hash] filterd params
    #
    def model_params(args, model)
      args = ActionController::Parameters.new(args)
      args.permit(model.attribute_names)
    end

    #
    # setting pagination parameters for the model instance
    #
    def set_pagination_properties(pagination_params, model)
      @per_page = (pagination_params[:per_page] || PAGINATION_UTIL::PER_PAGE).to_f
      @page_no = (pagination_params[:page_no] || PAGINATION_UTIL::PAGE_NO).to_f
      sort_by = pagination_params[:sort_by] || PAGINATION_UTIL::SORT_BY
      order = pagination_params[:order] || PAGINATION_UTIL::ORDER

      if @per_page < 0
        @per_page = PAGINATION_UTIL::INFINITE_PER_PAGE.to_f
      elsif @per_page == 0
        @per_page = PAGINATION_UTIL::PER_PAGE.to_f
      end

      @page_no = PAGINATION_UTIL::PAGE_NO.to_f if @page_no <= 0

      sort_by = PAGINATION_UTIL::SORT_BY unless model.attribute_names.include?(sort_by)
      order = PAGINATION_UTIL::ORDER unless PAGINATION_UTIL::ALLOWED_ORDERS.include?(order)

      @sort_order = sort_by + ' ' + order
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
    def create_model(args, model, message='')
      message = 'Model ' if message.blank?
      new_model = model.new(model_params(args, model))

      begin
        new_model.save!
        return new_model
      rescue ActiveRecord::RecordInvalid => e
        raise CUSTOM_ERROR_UTIL::InvalidArgumentsError.new('Not able to create ' + message + ', ' + e.message)
      end
    end

    #
    # Update the given model
    #
    # @param args [hash] arguments to update
    # @param model [Model] model
    #
    # @return [Model] updated model
    #
    # @error [InvalidArgumentsError] if unable to update the model
    #
    def update_model(args, record, message = '')
      message = 'Model' if message.blank?
      raise CUSTOM_ERROR_UTIL::InvalidArgumentsError.new(message +  ' not found') if record.nil? || args.nil?
      begin
        record.update_attributes!(model_params(args, record))
        return record
      rescue ActiveRecord::RecordInvalid => e
        raise CUSTOM_ERROR_UTIL::InvalidArgumentsError.new('Not able to update ' + message + ', '+ e.message)
      end
    end

  end
end
