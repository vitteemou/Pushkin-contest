class RegistrationController < ApplicationController 
   skip_before_filter :verify_authenticity_token, :only => [:answer]
   ANSWER = 'снежные'
  
   def answer 
       data = {answer: ANSWER}
       mary_token = Token.create my_token: params[:token].to_s
       mary_token.save
       render json: data
   end
end
