import { Application } from 'stimulus'
import HomeController from './controllers/home_controller'
import ChatController from './controllers/chat_controller'

const application = Application.start()
application.register('home', HomeController)
application.register('chat', ChatController)
