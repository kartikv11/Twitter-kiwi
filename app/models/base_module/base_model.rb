module BaseModule
  class BaseModel < ActiveRecord::Base

    self.abstract_class = true

  end
end
