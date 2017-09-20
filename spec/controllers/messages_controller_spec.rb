require 'rails_helper'

describe MessagesController, type: :controller do
  let(:user) { create(:user) }
  let(:group) { create(:group) }
  let(:message) { create(:message) }
  let(:params) { { group_id: group.id } }

  #ログイン時にmessageコントローラのindexアクションが動く挙動
  describe 'GET #index, if_user_login' do
    before do
      login_user user
      get :index, params: { group_id: group.id}
    end
    #@messageがMessageクラスの未保存インスタンスであることを確認
    it "confirm message as still not registerd" do
      expect(assigns(:message)).to be_a_new(Message)
    end

    #@groupがgroupsのレコードであることを確認
    it "confirm group is extracted from groups" do
      expect(assigns(:group)).to match(group)
    end

    it "renders the :index template" do
      expect(response).to render_template :index
    end
  end

  #未ログイン時の挙動
  describe 'GET #index, if user_not_login' do
    before do
      get :index, params
    end
    #未ログインの場合ログイン画面へ遷移するか確認
    it "before_action user should login" do
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  #ログイン時にmessageコントローラのcreateアクションの動く挙動
  describe 'POST #create, if_user_login' do
    before do
      login_user user
      post :create, group_id: group, message: attributes_for(:message)
    end
    #バリデーションを通り新しいメッセージがsaveされること
    it "valid new message can be saved" do
      expect{post :create, group_id: group, message: attributes_for(:message)}.to change(Message, :count).by(1)
    end

    #メッセージが保存された時、リダイレクトされること
    it "message is valid, and redirect_to" do
      expect(response).to redirect_to(group_messages_path)
    end

    #バリデーションによりsaveされないこと
    it "invalid new message can't be saved" do
      expect{post :create, group_id: group, message: attributes_for(:message, body: nil, image: nil)}.not_to change(Message, :count)
    end

    # #バリデーションにより保存されなかった時、renderでindexに飛ぶこと
    it "message is invalid, then render_template_index" do
      post :create, group_id: group, message: attributes_for(:message, body: nil, image: nil)
      expect(response).to render_template(:index)
    end
  end
end
