require 'rails_helper'

describe MessagesController, type: :controller do
  let(:user) { create(:user) }
  let(:group) { create(:group) }
  let(:message) { create(:message) }
  let(:params) { { group_id: group.id } }

  #messageコントローラのindexアクションの挙動について
  describe 'GET #index' do

    context "ログイン時" do
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

    context "未ログイン時" do
      before do
        get :index, params
      end
      #未ログインの場合ログイン画面へ遷移するか確認
      it "before_action user should login" do
        expect(response).to redirect_to(new_user_session_path)
      end
    end

  end

  #messageコントローラのcreateアクションの挙動について
  describe 'POST #create' do

    context "ログイン時" do
      before do
        login_user user
      end

      context "save成功の挙動" do
        subject { post :create, group_id: group, message: attributes_for(:message) }
        #バリデーションを通り新しいメッセージがsaveされること
        it "valid new message can be saved" do
          expect{ subject }.to change(Message, :count).by(1)
        end

        #メッセージが保存された時、リダイレクトされること
        it "message is valid, and redirect_to" do
          subject
          expect(response).to redirect_to(group_messages_path)
        end
      end

      context "save失敗の挙動" do
        subject { post :create, group_id: group, message: attributes_for(:message, body: nil, image: nil) }
        #バリデーションによりsaveされないこと
        it "invalid new message can't be saved" do
          expect{ subject }.not_to change(Message, :count)
        end

        # #バリデーションにより保存されなかった時、renderでindexに飛ぶこと
        it "message is invalid, then render_template_index" do
          subject
          expect(response).to render_template(:index)
        end
      end

    end

    context "未ログイン時" do
      before do
        get :index, params
      end
      #未ログインの場合ログイン画面へ遷移するか確認
      it "before_action user should login" do
        expect(response).to redirect_to(new_user_session_path)
      end
    end

  end

end
