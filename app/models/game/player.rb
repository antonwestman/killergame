module Game
  class Player < ApplicationRecord
    include Workflow

    belongs_to :user
    belongs_to :round
    has_one :mission, autosave: true, inverse_of: :player
    has_one :death, class_name: Kill, foreign_key: :victim_id
    has_many :kills, foreign_key: :killer_id

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

    def accept_kill
      round.kills.find_by(victim: self).accept
    end

    def oppose_kill
      round.kills.find_by(victim: self).accept
    end

    def mark_as_killed(killer:)
      round.kills.create(killer: killer, victim: self)
    end

    def commit_suicide
      round.kills.create(killer: self, victim: self)
    end
  end
end
