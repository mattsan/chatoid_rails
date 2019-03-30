require 'ovto'

Document = Native(`document`)

class ChatApp < Ovto::App
  class Handler < ChatChannel::Handler
    def initialize(app)
      @app = app
    end

    def connected
      puts 'connected'
    end

    def received(data)
      puts 'received'
      d = Native(`data`)
      name = d[:name]
      line = d[:line]
      puts line
      @app.actions.receive_item(value: {name: name, line: line})
    end
  end

  def setup
    handler = Handler.new(self)
    channel = ChatChannel.new(handler)
    name = Document.getElementById('user').dataset.userName

    actions.set_channel(value: channel)
    actions.set_name(value: name)
  end

  class State < Ovto::State
    item :channel, default: nil
    item :name, default: ''
    item :line, default: ''
    item :items, default: []
  end

  class Actions < Ovto::Actions
    def set_channel(state:, value:)
      return {channel: value}
    end

    def set_name(state:, value:)
      return {name: value}
    end

    def set_line(state:, value:)
      return {line: value}
    end

    def prepend_item(state:)
      state.channel.post(state.name, state.line)
      return {line: ''}
    end

    def receive_item(state:, value:)
      return {items: [{name: value[:name], line: value[:line]}] + state.items}
    end
  end

  class MainComponent < Ovto::Component
    def render(state:)
      o 'div' do
        o 'div', class: 'row' do
          o 'input', {
            type: 'text',
            onchange: -> (event) { actions.set_line(value: event.target.value) },
            value: state.line
          }
          o 'button', {
            onclick: -> (_) { actions.prepend_item }
          } do
            o 'text', 'POST'
          end
        end
        o 'ul' do
          state.items.each do |item|
            o 'li' do
              o 'text', "#{item[:name]}: #{item[:line]}"
            end
          end
        end
      end
    end
  end
end

ChatApp.run(id: 'ovto')
