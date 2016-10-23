module API
  module V1
    class User < Grape::API

      resource :users do # resourceで一括でusersのapiフォルダを指定(url)

        # GET /api/questions
        desc 'Return all user.' # desc内は説明
        get '', jbuilder: 'api/v1/user/index' do # api/v1/user/indexの.jbuilderを指定し
          @users = ::User.all
        end

        # GET /api/v1/question/{:id}
        desc 'Return a user.'
          params do
            requires :id, type: Integer, desc: 'user id.'
        end
        get :id , jbuilder: 'api/v1/user/index' do # resourceでURL末尾userを指定し、更にその後ろでid(int型)が入っている際の動作
        @users = ::User.find(params[:id]) # こちらでuser内を検索し、@user内に値を格納
        end
# :idではなくすることで赤画面のエラーは回避可能

      end
    end
  end
end
