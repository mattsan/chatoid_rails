class ChatChannel
  class Handler
    def connected
    end

    def disconnected
    end

    def received(_)
    end
  end


  def initialize(handler)
    @handler = handler
    @chat = Native(`App`).cable.subscriptions.create('ChatChannel', {
      connected: -> () { @handler.connected },
      disconnected: -> () { @handler.disconnected },
      received: -> (data) { @handler.received(data) }
    })
  end

  def post(name, line)
    @chat.perform('post', name: name, line: line)
  end
end
