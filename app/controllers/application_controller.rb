class ApplicationController < ActionController::API

    def is_integer(value)
        value.to_s == value.to_i.to_s
    end

end
