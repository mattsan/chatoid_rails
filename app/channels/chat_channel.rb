class ChatChannel < ApplicationCable::Channel
  def subscribed
    stream_for 'any_channel'
  end

  def unsubscribed
  end

  def post(data)
    pp data
    ChatChannel.broadcast_to('any_channel', name: data['name'], line: data['line'])
  end
end
