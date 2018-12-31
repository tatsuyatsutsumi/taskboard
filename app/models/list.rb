class List < ApplicationRecord
  belongs_to :user
  # ここに追加する
  validates :title, length: { in: 1..255 }
end