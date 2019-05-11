import { createConsumer } from '@rails/actioncable'

class ChatChannel {
  constructor(listener, userName) {
    this.listener = listener
    this.userName = userName

    const consumer = createConsumer()
    this.subscription = consumer.subscriptions.create(
      { channel: 'ChatChannel' },
      { received: (data) => this.received(data) }
    )
  }

  post(line) {
    this.subscription.perform('post', { name: this.userName, line: line })
  }

  received(data) {
    this.listener.onPost(data)
  }
}

export default ChatChannel
