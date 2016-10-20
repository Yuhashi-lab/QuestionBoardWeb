module API
  module V1
    class Base < Grape::API
      format :json
      default_format :json

      formatter :json, Grape::Formatter::Jbuilder

      prefix :api
      version 'v1', using: :path

      mount V1::Question
      mount V1::User

    end
  end
end
