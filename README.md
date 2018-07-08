# Pusher ChatApp

#### 작성중

*Gemfile*

```ruby
gem 'pusher'
gem 'figaro'
gem 'devise'
```

```shell
$ bundle install
```

*config/initializers/pusher.rb*

```ruby
require 'pusher'

Pusher.app_id = ENV["pusher_app_id"]
Pusher.key = ENV["pusher_key"]
Pusher.secret = ENV["pusher_secret"]
Pusher.cluster = ENV["pusher_cluster"]
Pusher.logger = Rails.logger
Pusher.encrypted = true
```

-  [Pusher](https://dashboard.pusher.com/) 에 가서 가입 후 대시보드 생성

```shell
$ figaro install
```

*config/application.yml*

```yml
development:
  pusher_app_id: 
  pusher_key: 
  pusher_secret: 
  pusher_cluster: 

```

*app/models/chat_room.rb*

```ruby
after_commit :create_notify_pusher, on: :create
after_commit :destroy_notify_pusher, on: :destroy
after_commit :update_notify_pusher, on: :update

def create_notify_pusher
  Pusher.trigger('chat_room', 'create', self.as_json)
end

def destroy_notify_pusher
  Pusher.trigger('chat_room', 'destroy', self.as_json)
end

def update_notify_pusher
  Pusher.trigger('chat_room', 'update', self.as_json)
end

# Pusher.trigger('channel name', 'event name', data)
```

*app/views/layout/application.html.erb*

```erb
<script src="https://js.pusher.com/4.1/pusher.min.js"></script>
```

*app/views/chat_rooms/index.html.erb*

```erb
// Pusher 객체 생성
var pusher = new Pusher('<%= ENV["pusher_key"] %>', {
  cluster: '<%= ENV["pusher_cluster"] %>',
  encrypted: true
});

// 현재 페이지에서 subscribe할 channel name과, 채널에서 event가 발생할 경우 해당 이벤트를 처리할 function 생성
var channel = pusher.subscribe('chat_room');
  channel.bind('create', function(data) {
  new_chat_room(data);
});
```

