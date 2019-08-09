require 'rails_helper'
RSpec.describe Users::BookRequestsController, type: :controller do
  include_context 'logged in'

  let!(:book_request) { create(:book_request, user_id: current_user.id) }

  describe '#destroy' do
    context 'delete success' do
      subject { delete :destroy, params: { user_id: current_user.id, id: book_request.id } }
      it 'total book request reduce 1' do
        expect { subject }.to change(BookRequest, :count).by(-1)
      end

      it 'redirect to user book requests index' do
        subject
        expect(flash.count).to equal(1)
        expect(flash[:success]).to eql(I18n.t('book_requests.delete.success'))
      end

      it 'all images of book request deleted' do 
        # expect { subject }.to change(BookRequestImage, :count).by(book_request.book_request_images.count)
      end
    end
  end
end
