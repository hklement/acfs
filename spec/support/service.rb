
Acfs.configure do
  locate :user_service, 'http://users.example.org'
  locate :comment_service, 'http://comments.example.org'
end

class UserService < Acfs::Service
  use Acfs::Middleware::MessagePackDecoder
  use Acfs::Middleware::JsonDecoder
  use Acfs::Middleware::JsonEncoder
end

class CommentService < Acfs::Service
  use Acfs::Middleware::JsonDecoder
end

class MyUser
  include Acfs::Model
  service UserService, path: 'users'

  attribute :id, :integer
  attribute :name, :string, default: 'Anon'
  attribute :age, :integer
end

class Session
  include Acfs::Model
  service UserService

  attribute :id, :string
  attribute :user, :integer
end

class Comment
  include Acfs::Model
  service CommentService

  attribute :id, :integer
  attribute :text, :string
end
