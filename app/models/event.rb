class Event < ApplicationRecord

  ACTIVITIES = {
    cycling: { title: 'Cycle', icon: 'bicycle' },
    mindfulness: { title: 'Mindfulness', icon: 'happy' },
    reading: { title: 'Book', icon: 'book' },
    running: { title: 'Running', icon: 'walk' },
    sports: { title: 'Sports', icon: 'basketball' },
    surfing: { title: 'Surfing', icon: 'water' },
    swim: { title: 'Swim', icon: 'help-buoy' },
    yoga: { title: 'Yoga', icon: 'body' },
  }.freeze

  validates :name, inclusion: { in: ACTIVITIES.keys.map(&:to_s) }

end
