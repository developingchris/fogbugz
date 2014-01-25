require 'minitest/autorun'
require 'fogbugz'

class TestProject < Minitest::Unit::TestCase

  def setup
    @api = Fogbugz::Api.new("switchbox","key")
  end

  def test_version
    assert @api.supported_version?
  end
end
