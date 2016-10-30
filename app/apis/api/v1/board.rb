module API
  module V1
    class Board < Grape::API

          resource :boards do

            # GET /api/boards/:id
            desc 'Return board.'
            get ':id', jbuilder: 'api/v1/board/show' do
                @board = ::Board.find(params[:id])
            end

            # POST /api/v1/boards
            desc 'Create a board.'
            params do
                requires :name ,    type: String, desc: 'name'
                requires :detail ,  type: String, desc: 'detail'
            end

            post '' , jbuilder: 'api/v1/board/create' do
              authenticate_user!
              board = ::Board.create({name:     params[:name],
                                      detail:   params[:detail],
                                      user_id:  @user.id,})
                if board.save
                  @result = "succes"
                  else
                  @result = "failed"
                end
            end

            # GET /api/v1/boards/search
            desc 'Return search result.'
            params do
              requires :search_word, type: String
            end
            get '/search/:search_word', jbuilder: 'api/v1/board/search' do
              @results = ::Board.where("name like '%" + params[:search_word] + "%'")
            end

            # GET /api/v1/boards/index
            desc 'Return user board index.'
            get '', jbuilder: 'api/v1/board/index' do
              authenticate_user!
              @results = ::Board.where(user_id:  @user.id)
            end

          end

    end
  end
end
