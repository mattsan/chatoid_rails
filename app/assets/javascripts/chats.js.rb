require 'ovto'

Document = Native(`document`)

class ChatApp < Ovto::App
  def setup
    name = Document.getElementById('user').dataset.userName
    actions.set_name(value: name)
  end

  class State < Ovto::State
    item :name, default: ''
    item :line, default: ''
    item :items, default: []
  end

  class Actions < Ovto::Actions
    def set_name(state:, value:)
      return {name: value}
    end

    def set_line(state:, value:)
      return {line: value}
    end

    def prepend_item(state:)
      return {items: [{name: state.name, line: state.line}] + state.items, line: ''}
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
