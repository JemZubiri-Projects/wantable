# frozen_string_literal: true

# app/models/creator.rb
class Creator < ApplicationRecord
  has_many :payouts, dependent: :destroy

  def total_paid
    payouts.paid.sum(:amount) || 0
  end

  def pending_payouts_count
    payouts.pending.count || 0
  end
end
