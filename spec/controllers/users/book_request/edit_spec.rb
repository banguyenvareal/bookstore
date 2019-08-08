require 'rails_helper'
RSpec.describe Users::BookRequestsController, type: :controller do
  let(:random_id) { rand(1..20) }
  describe '#edit' do
    context 'before log in' do
      before do
        get :edit, params: { user_id: random_id, id: random_id }
      end

      it 'return flash page not found' do
        expect(flash.count).to equal(1)
        expect(flash[:danger]).to eql(I18n.t('not_found'))
      end

      it 'redirect to root page' do
        expect(subject).to redirect_to(root_url)
      end
    end

    context 'book request not belong to current user' do
      include_context 'logged in'
      let(:book_request) { create(:book_request) }
      before do
        get :edit, params: { user_id: current_user.id, id: book_request.id }
      end

      it 'return flash page not found' do
        expect(flash.count).to equal(1)
        expect(flash[:danger]).to eql(I18n.t('not_found'))
      end

      it 'redirect to root page' do
        expect(subject).to redirect_to(root_url)
      end
    end

    context 'book request belong to current user' do
      include_context 'logged in'
      let(:book_request) { create(:book_request, user_id: current_user.id) }
      before do
        get :edit, params: { user_id: current_user.id, id: book_request.id }
      end

      it 'return correct book_request' do
        expect(assigns(:book_request).attributes)
          .to eql(book_request.attributes)
      end
    end
  end
end
