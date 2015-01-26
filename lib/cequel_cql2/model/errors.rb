module CequelCQL2

  module Model

    Error = Class.new(CequelCQL2::Error)
    RecordNotFound = Class.new(Error)
    RecordInvalid = Class.new(Error)
    MissingKey = Class.new(Error)
    InvalidQuery = Class.new(Error)

  end

end
