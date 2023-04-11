class SendMessageJob < ApplicationJob
  queue_as :default

  def perform(message)
    # CommentsController.renderer.new(warden: warden).render(...)

    mine = ApplicationController.render(
      partial: 'messages/mine',
      locals: {
        message: message,
        current_user: message.user
      }
    )

    other = ApplicationController.render(
      partial: 'messages/other',
      locals: {
        message: message,
        current_user: message.user
      }
    )
    
    # current_user = User.find(message.user)

    ActionCable.server.broadcast "room_channel_#{message.room_id}", {mine: mine, other: other, current_user: message.user}
    
  end
end
