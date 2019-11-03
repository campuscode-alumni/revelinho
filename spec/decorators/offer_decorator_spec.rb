require 'rails_helper'

RSpec.describe SelectionProcessDecorator do
  context '#format_date' do
    it 'show start date as locale style' do
      offer = create(:offer, start_date: '2019-10-30').decorate

      expect(offer.format_date).to eq '30/10/2019'
    end
  end
end
