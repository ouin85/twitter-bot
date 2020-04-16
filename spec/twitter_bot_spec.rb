require_relative '../lib/twitter_bot'

# describe "The display_credencial method" do
#   it "should return a good credencial" do
#     expect(display_credencial).to eq("customer_key")
#   end
# end

describe "The twitter_login method"  do
  it "should return a client, and that is not nil" do
    expect(twitter_login).not_to be_nil
  end
end

describe "The tweet method" do
  it "should return something not nil" do
    expect(tweet('Hello world!')).not_to be_nil
  end
end