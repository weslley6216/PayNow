require 'rails_helper'

describe Product do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:price) }
  it { should validate_numericality_of(:price).is_greater_than_or_equal_to(0) }
  it { should validate_numericality_of(:bank_slip_discount).is_greater_than_or_equal_to(0) }
  it { should validate_numericality_of(:credit_card_discount).is_greater_than_or_equal_to(0) }
  it { should validate_numericality_of(:pix_discount).is_greater_than_or_equal_to(0) }

end