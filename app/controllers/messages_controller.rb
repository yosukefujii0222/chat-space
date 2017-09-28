class MessagesController < ApplicationController

  def index
    @message = Message.new
    @group = Group.find(params[:group_id])
    @messages = @group.messages
    respond_to do |format|
      format.html
      format.json
    end
  end

  def create
    @message = Message.new(message_params)
    if @message.save
      respond_to do |format|
        format.html { redirect_to group_messages_url, notice: "メッセージを送信しました" }
        format.json
      end
    else
      flash.now[:alert] = "メッセージを入力してください"
      render :index
    end
  end
  private
  def message_params
    params.require(:message).permit(:user_name, :body, :image).merge(user_id: current_user.id, group_id: params[:group_id])
  end

end

