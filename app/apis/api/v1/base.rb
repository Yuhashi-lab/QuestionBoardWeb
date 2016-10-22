module API
  module V1
    class Base < Grape::API
      format :json
      default_format :json

      formatter :json, Grape::Formatter::Jbuilder

      prefix :api
      version 'v1', using: :path

      helpers do
            def authenticate_error!
              # 認証が失敗したときのエラー
              h = {'Access-Control-Allow-Origin' => "*",
                   'Access-Control-Request-Method' => %w{GET POST OPTIONS}.join(",")}
              error!('You need to log in to use the app.', 401, h)
            end

            def authenticate_user!
              # header から認証に必要な情報を取得
              uid = request.headers['Uid']
              token = request.headers['Access-Token']
              client = request.headers['Client']
              @user = User.find_by_uid(uid)
      
              # 認証に失敗したらエラー
              unless @user && @user.valid_token?(token, client)
                authenticate_error!
              end
            end
      end

      mount V1::Question
      mount V1::User

    end
  end
end
