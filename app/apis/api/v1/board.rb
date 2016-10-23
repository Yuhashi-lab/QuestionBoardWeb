module API
  module V1
    class Board < Grape::API

        resource :users do
          route_param :user_id do
            resource :boards do
            # GET /api/boards/:board_id
                desc 'Return all boards.' # desc内は説明
                  get '', jbuilder: 'api/v1/board/index' do # api/v1/board/indexの.jbuilderを指定し
                    @boards = ::Board.where(user_id: params[:user_id])
                  end
            end
          end
        end

  resource :boards do #モデルの指定

          # POST /api/v1/boards
        desc 'Create a board.'
            params do
              requires :name ,type: String, desc: 'name'
              requires :category ,type: String, desc: 'category'
              requires :detail ,type: String, desc: 'detail'
            end

        post '' , jbuilder: 'api/v1/board/create' do # resourceでURL末尾questionを指定し、更にその後ろでid(int型)が入っている際の動作
        ##  authenticate_user!
        board = ::Board.create({name:     params[:name],
                                category: params[:category],
                                detail:   params[:detail],
                                user_id:  @user.id,}) # こちらでquestion内を検索し、@question内に値を格納
            if board.save
              @result = "succes"
              else
              @result = "failed"
            end
        end


  end

    end
  end
end
