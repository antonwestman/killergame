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
      end
      state :confirmed
    end

    after_create :mark_victim_as_killed

    def confirm!
      victim.confirm_kill!
    end

    private

    def mark_victim_as_killed
      if victim == killer
        victim.commit_suicide
        confirm!
      else
        victim.mark_as_killed!
      end
    end

    def validate_rounds
      return if [killer&.round, victim&.round].all?(&round.method(:==))
      errors[:round] << 'must be same in killer, victim and kill'
    end
  end
end
