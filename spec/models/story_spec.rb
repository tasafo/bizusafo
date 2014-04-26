require 'spec_helper'

describe Story do
  context "Dados válidos" do
    it { should_not allow_value("nao é uma url").for :url }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:url) }
  end
end
