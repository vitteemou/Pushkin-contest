class QuizController < ApplicationController
   
   skip_before_filter :verify_authenticity_token, :only => [:question]
   USER_TOKEN = 'bd91b8966fa67bd6de091c7c091f6fea'

   def question    
      my_task_id = params[:id]
      quest = params[:question]
      my_level = params[:level]
	 
      case my_level
      when 1
	my_answer = Line.find_by(:some_line => quest).poem.title
      when 2
	 quest = quest.split("%WORD%")
	 q1 = quest.first
	 q2 = quest.last

	 my_answer = Line.all.select { |m| (m.some_line.include? q1) && (m.some_line.include? q2) }
	 my_answer = my_answer.first.some_line
	 my_answer.delete q1, q2
	 
       when 3
	 quest = quest.split("\n")
	 s1 = quest.first
	 s2 = quest.last
	 
       when 4
	 quest = quest.split("\n")
	 s1 = quest[0]
	 s2 = quest[1]
	 s3 = quest[2]

      render nothing: true
      uri = URI("http://pushkin-contest.ror.by/quiz")
      parameters = {
	answer: my_answer,
	token: USER_TOKEN,
	task_id: my_task_id
      }
      Net::HTTP.post_form(uri, parameters)
   end
end

