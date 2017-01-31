module Game
  class Player < ApplicationRecord
    include Workflow

    belongs_to :user
    belongs_to :round
    has_one :mission, autosave: true, inverse_of: :player, dependent: :destroy
    has_one :target, through: :mission
    has_one :contract_on_own_head, class_name: Mission,
                                   autosave: true,
                                   foreign_key: :target_id,
                                   dependent: :destroy

    has_one :death, class_name: Kill, foreign_key: :victim_id, dependent: :destroy
    has_many :kills, foreign_key: :killer_id, dependent: :destroy

    scope :alive, -> { where.not(status: 'dead') }
    scope :dead, -> { where(status: 'dead') }

    validates_associated :mission

    workflow_column :status
    workflow do
      state :alive do
        event :mark_as_killed, transitions_to: :marked_as_killed
        event :commit_suicide, transitions_to: :dead
      end
      state :marked_as_killed do
        event :accept_kill, transitions_to: :dead
        event :oppose_kill, transitions_to: :alive
      end
      state :dead
    end

    delegate :email, to: :user

    def accept_kill!(kill)
      kill.confirm
    end
  end
end
