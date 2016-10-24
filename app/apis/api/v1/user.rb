module API
  module V1
    class User < Grape::API

      resource :users do # resourceで一括でusersのapiフォルダを指定(url)

        # GET /api/v1/users/
        desc 'Return a user.'
        get '/show' , jbuilder: 'api/v1/user/show' do # resourceでURL末尾userを指定し、更にその後ろでid(int型)が入っている際の動作
          authenticate_user!
        @user
        end


        # PUT /api/v1/users/
        desc 'Ask for a question.'

        put '' , jbuilder: 'api/v1/user/upDate' do
          authenticate_user!
          find = ::User.find(@user.id)
          if  find.update(is_company: true)
            @result = "success"
          else
            @result = "failed"
          end
        end

      end
    end
  end
end
