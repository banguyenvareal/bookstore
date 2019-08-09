FactoryBot.define do
  factory :book_request_image do
    file { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/support/default-book-cover.jpg')) }
    book_request
  end
end