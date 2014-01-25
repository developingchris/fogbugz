require 'minitest/autorun'
require 'fogbugz'
require 'ox'

class TestProject < Minitest::Unit::TestCase

  def setup
    @api = Fogbugz::Api.new("switchbox","key")
  end

  def test_ha
    assert_equal "key", @api.key
  end

end
