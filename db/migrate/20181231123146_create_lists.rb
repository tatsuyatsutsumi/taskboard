class CreateLists < ActiveRecord::Migration[5.2]
  def change
    create_table :lists do |t|

      # ==========ここから編集する==========
      t.string :title, null: false, limit: 255
      t.references :user, null: false
      # ==========ここまで編集する==========

      t.timestamps
    end
  end
end