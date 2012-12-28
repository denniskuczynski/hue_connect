require 'spec_helper'

describe "RailsIntegration", :type => :feature do
  
  before(:all) do
    # Configure Capybara for Rails
    require "capybara/rails"
  end
  
  it_behaves_like "web_dashboard" do
    let(:site_root) { '/hue/' }
  end
end