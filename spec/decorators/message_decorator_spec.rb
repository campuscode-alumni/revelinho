require 'rails_helper'

RSpec.describe MessageDecorator do
  context '#avatar' do
    it 'shows the employee\'s avatar when it is their message' do
      company = create(:company, name: 'Revelo', url_domain: 'revelo.com.br')
      company.company_profile = create(:company_profile)
      candidate = create(:candidate, status: :published)
      employee = create(:employee, company: company)
      employee.avatar.attach(
        io: File.open(Rails.root.join('spec',
                                      'support',
                                      'images',
                                      'gatinho.jpg')),
        filename: 'gatinho.jpg'
      )
      position = create(:position, company: company)
      invite = create(:invite, candidate: candidate, position: position,
                               status: :pending)

      invite.create_selection_process
      invite.selection_process.messages << create(
        :message,
        text: 'teste',
        sendable: employee,
        selection_process: invite.selection_process
      )

      message_decorator = MessageDecorator.new(Message.last)
      expect(message_decorator.avatar.blob.filename).to(
        eq employee.avatar.blob.filename
      )
    end

    it 'shows candidate\'s avatar when it is their message' do
      company = create(:company, name: 'Revelo', url_domain: 'revelo.com.br')
      company.company_profile = create(:company_profile)
      candidate = create(:candidate, status: :published)
      candidate_profile = create(:candidate_profile, candidate: candidate)
      candidate_profile.avatar.attach(
        io: File.open(Rails.root.join('spec', 'support', 'images',
                                      'gatinho.jpg')),
        filename: 'gatinho.jpg'
      )
      position = create(:position, company: company)
      invite = create(:invite, candidate: candidate, position: position,
                               status: :pending)
      invite.create_selection_process
      invite.selection_process.messages << create(
        :message,
        text: 'teste',
        sendable: candidate,
        selection_process: invite.selection_process
      )

      message_decorator = MessageDecorator.new(Message.last)
      expect(message_decorator.avatar.blob.filename).to(
        eq candidate.avatar.blob.filename
      )
    end

    it 'shows the place holder when there is no avatar' do
      company = create(:company, name: 'Revelo', url_domain: 'revelo.com.br')
      company.company_profile = create(:company_profile)
      candidate = create(:candidate, status: :published)
      employee = create(:employee, :without_avatar, company: company)
      position = create(:position, company: company)
      invite = create(:invite, candidate: candidate, position: position,
                               status: :pending)

      invite.create_selection_process
      invite.selection_process.messages << create(
        :message,
        text: 'teste',
        sendable: employee,
        selection_process: invite.selection_process
      )

      message_decorator = MessageDecorator.new(Message.last)
      expect(message_decorator.avatar).to(
        eq 'https://github.com/identicons/jasonlong.png'
      )
    end
  end
end
