class MessageDecorator < Draper::Decorator
  delegate_all
  include Draper::LazyHelpers

  def avatar
    return message.sendable.avatar if sendable.avatar.attached?

    'https://github.com/identicons/jasonlong.png'
  end

  def message_sendable
    return '' unless chat?

    content_tag(:div, image_tag(avatar, class: 'avatar-50 mr-3') +
                content_tag(:h5, sendable.name, class: 'm-0'),
                class: 'flex mb-3')
  end

  def card_style
    message_type + (chat? ? '' : ' notification-card my-4')
  end
end
