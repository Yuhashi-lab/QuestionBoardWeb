module API
  module V1
    class Question < Grape::API

      resource :boards do #モデルの指定
        route_param :board_id do #変数名としてboard_id
          resource :questions do # resourceで一括でquestionsのapiフォルダを指定(url)

            # GET /api/questions
            desc 'Return all question.' # desc内は説明
            get '', jbuilder: 'api/v1/question/index' do # api/v1/question/indexの.jbuilderを指定し
              @questions = ::Question.where(board_id: params[:board_id])
            end

          end
        end
      end

      resource :questions do # resourceで一括でquestionsのapiフォルダを指定(url)

          # GET /api/v1/questions/{:id}
          desc 'Return a question.'
            params do
              requires :id, type: Integer, desc: 'Person id.'
            end
          get ':id' , jbuilder: 'api/v1/question/show' do # resourceでURL末尾questionを指定し、更にその後ろでid(int型)が入っている際の動作
            @question = ::Question.find(params[:id]) # こちらでquestion内を検索し、@question内に値を格納
          end

          # POST /api/v1/questions
          desc 'Create a question.'
            params do
              requires :questioner ,type: String, desc: 'name'
              requires :content ,type: String, desc: 'content'
              requires :board_id ,type: Integer, desc: 'board_id'
            end
          post '' , jbuilder: 'api/v1/question/create' do # resourceでURL末尾questionを指定し、更にその後ろでid(int型)が入っている際の動作
            question = ::Question.create({questioner: params[:questioner],
                                          content: params[:content],
                                          board_id: params[:board_id],}) # こちらでquestion内を検索し、@question内に値を格納
            if question.save
              @result = "succes"
              else
              @result = "failed"
            end
          end

      end
    end
  end
end
