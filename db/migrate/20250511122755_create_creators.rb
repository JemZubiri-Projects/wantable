# frozen_string_literal: true

class CreateCreators < ActiveRecord::Migration[7.1]
  def change
    create_enum :creator_status, %i[active inactive]
    create_table :creators do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.enum :status, enum_type: :creator_status, null: false, default: :active

      t.timestamps
    end
  end
end
