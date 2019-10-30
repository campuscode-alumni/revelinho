class MessageDecorator < Draper::Decorator
  delegate_all
  include Draper::LazyHelpers

  def avatar
    return message.sendable.avatar if sendable.avatar.attached?

    'https://github.com/identicons/jasonlong.png'
  end
end
