def on(element, event, &block)
  element.addEventListener(event, block) if element
end

on(Native(`window`), 'load') do
  enter_button = Native(`document`).getElementById('enter-button')

  on(enter_button, 'click') do
    name = Native(`document`).getElementById('name').value
    Native(`document`).location.href = "/chats/#{name}"
  end
end
