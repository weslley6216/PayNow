require 'rails_helper'

describe Pix do
  it { should validate_presence_of(:bank_number) }
  it { should validate_length_of(:bank_number).is_equal_to(3) }
  it { should validate_presence_of(:pix_key) }
  it { should validate_length_of(:pix_key).is_equal_to(20) }
end