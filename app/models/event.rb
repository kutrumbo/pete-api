class Event < ApplicationRecord

  ACTIVITIES = {
    mindfulness: { title: 'Mindfulness', icon: 'happy' },
    running: { title: 'Running', icon: 'walk' },
    sports: { title: 'Sports', icon: 'basketball' },
    surfing: { title: 'Surfing', icon: 'analytics' },
    yoga: { title: 'Yoga', icon: 'body' },
    reading: { title: 'Book', icon: 'book' },
    cycling: { title: 'Cycle', icon: 'bicycle' },
  }.freeze

  validates :name, inclusion: { in: ACTIVITIES.keys.map(&:to_s) }

end
