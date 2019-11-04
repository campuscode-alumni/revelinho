class MessageDecorator < Draper::Decorator
  delegate_all
  include Draper::LazyHelpers

  def avatar
    return message.sendable.avatar if sendable.avatar.attached?

    'https://github.com/identicons/jasonlong.png'
  end

  def message_sendable
    return '' unless as_chat?

    content_tag(:div, image_tag(avatar, class: 'avatar-50') +
                content_tag(:h5, sendable.name),
                class: 'flex')
  end

  def card_style
    message_type + (as_chat? ? '' : ' notification-card')
  end

  def as_chat?
    chat? || new_offer? || new_interview?
  end
end
