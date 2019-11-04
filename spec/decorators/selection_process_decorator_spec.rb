require 'rails_helper'

RSpec.describe SelectionProcessDecorator do
  context '#p_print_hiring_scheme' do
    it 'show resume of invite contract' do
      selection_process = create(:selection_process).decorate

      expect(selection_process.p_print_hiring_scheme).to(
        eq '<p class="mb-0">Regime de contratação: CLT</p>'
      )
    end
  end

  context '#p_print_office_hours' do
    it 'show resume of invite contract' do
      selection_process = create(:selection_process).decorate

      expect(selection_process.p_print_office_hours).to(
        eq '<p class="mb-0">Horário de expediente: Integral</p>'
      )
    end
  end

  context '#p_print_salary' do
    it 'show resume of invite contract' do
      selection_process = create(:selection_process).decorate

      expect(selection_process.p_print_salary).to(
        eq '<p class="mb-0">Salário: R$ 4.500,00 à R$ 5.500,00</p>'
      )
    end

    it 'employee sees candidate avatar when it exists' do
      candidate = create(:candidate, status: :published)
      create(:candidate_profile, candidate: candidate)
      invite = create(:invite, candidate: candidate)
      selection_process = create(:selection_process, invite: invite).decorate

      expect(selection_process.image_logo.blob.filename).to(
        eq selection_process.image_logo.blob.filename
      )
    end

    it 'shows a image place holder when candidate avatar does not exists' do
      candidate = create(:candidate, status: :published)
      create(:candidate_profile, :without_avatar, candidate: candidate)
      invite = create(:invite, candidate: candidate)
      selection_process = create(:selection_process, invite: invite).decorate

      expect(selection_process.image_logo).to include 'placeholder'
    end
  end
end
