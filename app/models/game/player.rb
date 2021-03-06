module Game
  class Player < ApplicationRecord
    include Workflow

    belongs_to :user
    belongs_to :round
    has_many :missions, autosave: true, inverse_of: :player, dependent: :destroy
    has_one :contract_on_own_head, class_name: Mission,
                                   autosave: true,
                                   foreign_key: :target_id,
                                   dependent: :destroy

    has_one :death, -> { where.not(status: 'opposed') }, class_name: Kill,
                                                         foreign_key: :victim_id,
                                                         dependent: :destroy

    has_many :kills, foreign_key: :killer_id, dependent: :destroy

    scope :alive, -> { where.not(status: 'dead') }
    scope :dead, -> { where(status: 'dead') }

    validates_associated :mission

    workflow_column :status
    workflow do
      state :alive do
        event :mark_as_killed, transitions_to: :marked_as_killed
      end
      state :marked_as_killed do
        event :confirm_kill, transitions_to: :dead
        event :oppose_kill, transitions_to: :alive
      end
      state :dead
    end

    delegate :email, to: :user
    delegate :target, to: :mission

    def username_or_email
      player_name || user.username || user.email
    end

    def mission
      missions.order('created_at DESC').first
    end

    def commit_suicide
      kills.create(victim: self, round: round)
    end

    def confirm_kill
      contract_on_own_head.player
                          .missions
                          .create(mission.attributes
                                         .slice('target_id', 'weapon_id', 'place_id'))
    end
  end
end
