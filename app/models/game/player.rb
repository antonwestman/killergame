module Game
  class Player < ApplicationRecord
    include Workflow

    belongs_to :user
    belongs_to :round
    has_one :mission, autosave: true, inverse_of: :player

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
  end
end
