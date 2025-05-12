# frozen_string_literal: true

class ProcessPayoutJob < ApplicationJob
  queue_as :default

  include ActionView::RecordIdentifier

  def perform(payout_id)
    payout = Payout.find(payout_id)
    creator = payout.creator
    sleep(1)

    payout.update(status: :paid, paid_at: Time.current)
    Rails.logger.info "Broadcasting update to #{dom_id(payout)} and #{dom_id(creator, :stats)}_wrapper"
    broadcast_payout(payout)
    broadcast_stats(creator)
  end

  private

  def broadcast_payout(payout)
    Turbo::StreamsChannel.broadcast_replace_to(
      payout.creator,
      target: dom_id(payout),
      partial: 'payouts/payout',
      locals: { payout: payout, creator: payout.creator }
    )
  end

  def broadcast_stats(creator)
    Turbo::StreamsChannel.broadcast_replace_to(
      "creator_#{creator.id}_stats",
      target: "#{dom_id(creator, :stats)}_wrapper",
      partial: 'creators/stats',
      locals: { creator: creator }
    )
  end
end
