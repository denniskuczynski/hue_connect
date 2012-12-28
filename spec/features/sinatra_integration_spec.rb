require 'spec_helper'

describe "SinatraIntegration", :type => :request do
  
  before :all do
    Capybara.app = BeanstalkdView::Server.new
  end
  
  it_behaves_like "web_dashboard" do
    let(:site_root) { '/' }
  end
end