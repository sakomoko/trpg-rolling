require 'spec_helper'

describe CommentsController do

  let(:user) { FactoryGirl.create :user }
  let(:session) { FactoryGirl.create :session }
  let(:valid_attributes) { FactoryGirl.build(:comment).attributes.symbolize_keys}

  describe "POST 'create'" do
    context 'logged in' do
      before do
        sign_in user
      end

      it "returns http success" do
        post 'create', { :session_id => session.id}
        response.should be_success
      end

      context "valid param" do
        before do
          post :create, { :session_id => session.id, :comment => valid_attributes }
        end
        subject { assigns(:comment) }
        it { should_not be_new_record }
        its(:commentable) { should eq session }
        its(:user) { should eq user}
        it { controller.should respond_with(:success) }
      end

      context "invalid param" do
        before do
          post :create, { :session_id => session.id, :comment => { } }
        end
        subject { assigns(:comment) }
        it { should be_new_record }
        it { controller.should respond_with(:success) }
      end
    end

    context "not login" do
      before do
        post :create, { :session_id => session.id, :comment => valid_attributes }
      end
      it { should respond_with(:redirect) }
      it { response.should redirect_to(new_user_session_path) }
    end
  end

end
