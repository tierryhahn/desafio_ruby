class Automation
  include Mongoid::Document
  include Mongoid::Timestamps

  field :tipo, type: String
  field :message, type: String
  field :programmed_to, type: DateTime
  field :sent_at, type: DateTime

  belongs_to :company

  validates :tipo, presence: true
  validates :message, presence: true
  validates :programmed_to, presence: true
end
