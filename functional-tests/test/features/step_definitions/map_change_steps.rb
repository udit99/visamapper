Given /^I go to the Visamapper Site$/ do
  visit('')
end

When /^I choose (\w+) on the countries dropdown$/ do |country|
  select(country, :from => 'countries')
end

Then /^the map of (\w+) should be highlighted in blue$/ do |country|
  country_code = CountryCodeMapping::MAPPING[country]
  page.should have_css("#jvectormap1_#{country_code}[fill='#{HighlightedColors::HOME_COUNTRY}']")
end

