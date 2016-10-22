#
# Common Module which caters common functionality
#
module CommonModule
  #
  # Class pagination to apply filter based on page, per_page & other filters
  #
  class Pagination

    # if no page_no is specified
    PAGE_NO = 1

    # if length of page is not specified
    PER_PAGE = 20

    # sort object based on which attribute
    SORT_BY = 'created_at'

    # default sort order Ascending/Descending
    ORDER = 'ASC'

    # Default values
    DEFAULT_PAGE_NO = 1
    DEFAULT_PER_PAGE = 20
    DEFAULT_SORT_BY = 'id'
    DEFAULT_ORDER = 'DESC'
    # Infinited number of per page results (Value of 2**32)
    INFINITE_PER_PAGE = 2**32
    INFINITE_PAGE_NO = 1
    # allowed orders
    ALLOWED_ORDERS = %w(ASC, DESC)

  end
end
