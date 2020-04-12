require 'test_helper'

class EventTest < ActiveSupport::TestCase

  test "validates name is valid activity" do
    assert(build(:event, name: 'yoga').valid?)
    assert(build(:event, name: 'yogb').invalid?)
  end

end
