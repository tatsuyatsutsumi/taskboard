class Card < ApplicationRecord
  belongs_to :list
  # ここに追加する
  validates :title, length: { in: 1..255 }
end