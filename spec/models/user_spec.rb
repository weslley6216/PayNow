require 'rails_helper'

describe User do
  it { should_not allow_value('user@yahoo.com.br').for(:email).with_message('não é válido') }
  it { should_not allow_value('user@hotmail.com').for(:email).with_message('não é válido') }
  it { should_not allow_value('user@gmail.com').for(:email).with_message('não é válido') }
  it { should allow_value('user@codeplay.com.br').for(:email) }
end
