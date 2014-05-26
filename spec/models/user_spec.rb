require 'spec_helper'

describe User do
  let(:user) { User.new }

  context 'Erros de validação em português' do
    it { should_not be_valid }
  end
end
