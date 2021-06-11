require 'rails_helper'

describe Admin do
  it { should_not allow_value('admin@hotmail.com.br').for(:email).with_message('não é válido') }
  it { should allow_value('admin@paynow.com.br').for(:email) }
end
