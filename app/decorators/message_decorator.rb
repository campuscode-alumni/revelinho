class MessageDecorator < Draper::Decorator
  delegate_all
  include Draper::LazyHelpers

  def avatar
    return avatar_img if sendable.avatar.attached?

    img_place_holder
  end

  private

  def avatar_img
    image_tag(message.sendable.avatar,
              class: 'avatar-50 float-left mr-3 auto')
  end

  def img_place_holder
    image_tag('https://github.com/identicons/jasonlong.png',
              class: 'image avatar-50 float-left mr-3 auto')
  end
end
