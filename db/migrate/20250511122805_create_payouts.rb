# frozen_string_literal: true

class CreatePayouts < ActiveRecord::Migration[7.1]
  def change
    create_enum :payout_status, %i[pending paid]

    create_table :payouts do |t|
      t.references :creator, null: false, foreign_key: true
      t.decimal :amount
      t.enum :status, enum_type: :payout_status, null: false, default: :pending
      t.datetime :paid_at

      t.timestamps
    end
  end
end
