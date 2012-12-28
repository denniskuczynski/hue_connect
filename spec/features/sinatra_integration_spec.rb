require 'spec_helper'

describe "SinatraIntegration", :type => :feature do
  
  before :all do
    Capybara.app = HueConnect::Server.new
  end
  
  it_behaves_like "web_dashboard" do
    let(:site_root) { '/' }
  end
end