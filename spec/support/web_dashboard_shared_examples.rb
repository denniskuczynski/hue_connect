shared_examples 'web_dashboard' do

  it "should show the overview at: /" do
    visit site_root
    body.should have_content "Hue Connect"
  end

end