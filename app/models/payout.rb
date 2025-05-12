# frozen_string_literal: true

# app/models/payout.rb
class Payout < ApplicationRecord
  belongs_to :creator

  scope :paid, -> { where(status: :paid) }
  scope :pending, -> { where(status: :pending) }

  def mark_as_paid!
    ProcessPayoutJob.perform_later(id)
  end
end
