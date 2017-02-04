module Game
  class Kill < ApplicationRecord
    include Workflow

    belongs_to :killer, class_name: Game::Player
    belongs_to :victim, class_name: Game::Player
    belongs_to :round

    validates :killer,
              :victim,
              :round, presence: true

    validate :validate_rounds

    alias_attribute :target_id, :victim_id

    workflow_column :status
    workflow do
      state :unconfirmed do
        event :confirm, transitions_to: :confirmed
        event :oppose, transitions_to: :confirmed
      end
      state :confirmed
      state :opposed
    end

    after_create :mark_victim_as_killed

    def confirm
      victim.confirm_kill!
    end

    def oppose
      victim.oppose_kill!
    end

    private

    def mark_victim_as_killed
      victim.mark_as_killed!
      confirm! if victim == killer
    end

    def validate_rounds
      return if [killer&.round, victim&.round].all?(&round.method(:==))
      errors[:round] << 'must be same in killer, victim and kill'
    end
  end
end
