require 'rails_helper'

RSpec.describe SelectionProcessDecorator do
  context '#contract_type' do
    it 'show range of ' do
      invite = create(:invite).decorate
      expect(invite.invite_links).to eq ''
    end
  end
end
