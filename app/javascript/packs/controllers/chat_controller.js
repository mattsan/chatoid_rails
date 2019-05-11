import { Controller } from 'stimulus'
import ChatChannel from '../channels/chat_channel'

class ChatController extends Controller {
  static targets = [
    'line',
    'items'
  ]

  get line() { return this.lineTarget.value }
  set line(l) { this.lineTarget.value = l }

  initialize() {
    this.channel = new ChatChannel(this, this.data.get('user'))
  }

  post() {
    this.channel.post(this.line)
    this.line = ''
  }

  onPost(payload) {
    const item = document.createElement('li')
    item.textContent = `${payload.name}: ${payload.line}`
    this.itemsTarget.prepend(item)
  }
}

export default ChatController
