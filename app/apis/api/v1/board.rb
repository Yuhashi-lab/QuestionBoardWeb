module API
  module V1
    class Board < Grape::API

          resource :boards do
            # GET /api/boards/:board_id
            desc 'Return all boards.' # desc内は説明
            get '', jbuilder: 'api/v1/board/index' do # api/v1/board/indexの.jbuilderを指定し
                authenticate_user!
                @boards = ::Board.where(user_id:  @user.id)
            end

            # POST /api/v1/boards
            desc 'Create a board.'
            params do
                requires :name ,    type: String, desc: 'name'
                requires :detail ,  type: String, desc: 'detail'
            end

            post '' , jbuilder: 'api/v1/board/create' do # resourceでURL末尾questionを指定し、更にその後ろでid(int型)が入っている際の動作
              authenticate_user!
              board = ::Board.create({name:     params[:name],
                                      detail:   params[:detail],
                                      user_id:  @user.id,}) # こちらでquestion内を検索し、@question内に値を格納
                if board.save
                  @result = "succes"
                  else
                  @result = "failed"
                end
            end

            # GET /api/v1/boards/search
            desc 'Return search result.'
            params do
                requires :word , type: String, desc: 'word'
            end
            post '/search', jbuilder: 'api/v1/board/search' do # api/v1/board/search.jbuilderを指定し
              @results = ::Board.where("name like '%" + params[:word] + "%'")
            end


          end

    end
  end
end
