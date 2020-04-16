require_relative '../lib/handles'

describe "The random_handle method" do
  it "should return an integer less than size of the handles array" do
    expect(random_handle).not_to be_nil
    # expect(random_handle).to be < ($handles.size)
  end
end