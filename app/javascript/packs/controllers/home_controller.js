import { Controller } from 'stimulus'

class HomeController extends Controller {
  static targets = [
    'name'
  ]

  enter() {
    const name = this.nameTarget.value
    document.location.href = `/chats/${name}`
  }
}

export default HomeController
