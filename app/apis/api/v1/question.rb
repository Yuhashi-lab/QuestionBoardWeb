module API
  module V1
    class Question < Grape::API

      resource :questions do

        # GET /api/questions
        desc 'Return all question.'
        get '', jbuilder: 'api/v1/question/index' do
          @questions = ::Question.all
        end

      end
    end
  end
end
