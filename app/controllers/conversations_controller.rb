class ConversationsController < ApplicationController
  def create
    @conversation = Conversation.get(current_user.id, params[:user_id])
    
    add_to_conversations unless conversated?

    respond_to do |format|
      format.js
    end
  end

  def close
    @conversation = Conversation.find(params[:id])
 
    session[:conversations].delete(@conversation.id)
 
    respond_to do |format|
      format.js
    end
  end

  def index
    @user = current_user
    session[:conversations] ||= []
    if @user
      if current_user.role == "superadmin"
        @users = User.all.where.not(id: current_user)
        @conversations = Conversation.includes(:recipient, :messages)
                       .find(session[:conversations])
      elsif current_user.role == "homeowner"
        @admin = User.find_by(role: "superadmin")
        @conversations = Conversation.get(current_user.id, @admin.id)
      end
    end
  end
  
  private

  def add_to_conversations
    session[:conversations] ||= []
    session[:conversations] << @conversation.id
  end

  def conversated?
    session[:conversations].include?(@conversation.id)
  end
end