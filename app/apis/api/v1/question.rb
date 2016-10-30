module API
  module V1
    class Question < Grape::API

      resource :boards do #モデルの指定
        route_param :board_id do #変数名としてboard_id
          resource :questions do # resourceで一括でquestionsのapiフォルダを指定(url)

            # GET /api/questions
            desc 'Return all question.' # desc内は説明
            get '', jbuilder: 'api/v1/question/index' do
              empathy_questions = ::Question.find_by_sql(['SELECT questions.id, questions.content, questions.questioner, questions.answer, COUNT(*) AS empathy_count
                                                    FROM questions INNER JOIN questions_users ON questions.id = questions_users.question_id
                                                    WHERE questions.board_id = :board_id
                                                    GROUP BY questions.id, questions.content, questions.questioner, questions.answer',{:board_id => params[:board_id]}])
              no_empathy_questions = ::Question.find_by_sql(['SELECT questions.id, questions.content, questions.questioner, questions.answer
                                                    FROM questions LEFT JOIN questions_users ON questions.id = questions_users.question_id
                                                    WHERE questions.board_id = :board_id
                                                    AND questions_users.id IS NULL
                                                    GROUP BY questions.id, questions.content, questions.questioner, questions.answer',{:board_id => params[:board_id]}])

              @questions = empathy_questions.concat(no_empathy_questions)

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
          get ':id' , jbuilder: 'api/v1/question/show' do
            @question       = ::Question.find(params[:id])
            @empathy_count  = ::Question.find_by_sql(['SELECT COUNT(questions_users) AS empathy_count
                                                  FROM questions_users
                                                  WHERE questions_users.question_id = :question_id
                                                ',{:question_id => params[:id]}]).first

          end

          # PUT /api/v1/questions/{:id}
          desc 'answer for a question.'
            params do
              requires :answer, type: String,    desc: 'answer text.'
            end
          put ':id' , jbuilder: 'api/v1/question/upDate' do
            question = ::Question.find(params[:id])
            if  question.update(answer: params[:answer])
              @result = "success"
            else
              @result = "failed"
            end
          end

          # POST /api/v1/questions
          desc 'Create a question.'
            params do
              requires :questioner ,type: String, desc: 'name'
              requires :content ,   type: String, desc: 'content'
              requires :board_id ,  type: Integer, desc: 'board_id'
            end
          post '' , jbuilder: 'api/v1/question/create' do
            question = ::Question.create({questioner: params[:questioner],
                                          content: params[:content],
                                          board_id: params[:board_id],})
            if question.save
              @result = "succes"
              else
              @result = "failed"
            end
          end

          # POST /api/v1/questions/{:id}/empathy
          desc 'make a empathy.'
          post '/:id/empathy' , jbuilder: 'api/v1/question/create_empathy' do
            authenticate_user!
            #TODO 
            question = ::Question.find_by_sql(['INSERT INTO questions_users(user_id, question_id) VALUES(:user_param, :question_param)', {:user_param => @user.id, :question_param => params[:id]}])

            @result = "succes"
          end

      end
    end
  end
end
