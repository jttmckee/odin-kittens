class Kitten < ApplicationRecord
  validates :name, length: {in: 3..255}
  validates :age, numericality: {only_integer: true,
    greater_than: 0}
  validates :cuteness, numericality: {only_integer: true,
    greater_than: 0}
  validates :softness, numericality: {only_integer: true,
    greater_than: 0}
end
