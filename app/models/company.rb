class Company
  include Mongoid::Document
  include Mongoid::Timestamps

  field :cnpj, type: String
  field :name, type: String
  field :decisor, type: Hash

  belongs_to :user

  validates :cnpj, presence: true
  validates :name, presence: true
end
