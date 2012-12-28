shared_examples 'web_dashboard' do

  it "should show the overview at: /" do
    visit site_root
    body.should have_content "Beanstalkd View"
    body.should have_content "Statistics"
    body.should have_content "Tubes"
  end

end