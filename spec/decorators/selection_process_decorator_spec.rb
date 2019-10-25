require 'rails_helper'

RSpec.describe SelectionProcessDecorator do
  context '#contract_resume' do
    it 'show resume of invite contract' do
      selection_process = create(:selection_process).decorate

      expect(selection_process.contract_resume).to eq '<p class="mb-0">Regime'\
                                                      ' de contratação: Integr'\
                                                      'al</p><p class="mb-0">S'\
                                                      'alário: R$ 4.500,00 à R'\
                                                      '$ 5.500,00</p>'
    end
  end
end
