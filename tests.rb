require_relative 'lib/minicolor'
require 'test/unit'

class TestColor < Test::Unit::TestCase
  def test_complementary
    c1 = Minicolor::Color.new('cc0000')
    c2 = c1.complementary[1]
    assert_equal(c2.hex, '00cccc')
  end
  
  def test_analogous
    c = Minicolor::Color.new('cc0000')
    c1, c2, c3 = c.analogous(3)
    assert_equal(c1.hex, 'cc00cc')
    assert_equal(c2.hex, 'cc0000')
    assert_equal(c3.hex, 'cccc00')
  end
  
  def test_luminance
    c = Minicolor::Color.new('fff')
    white = c.luminance
    c = Minicolor::Color.new('000')
    black = c.luminance
    
    # TODO add some intermediate values

    assert_equal(1.0, white)
    assert_equal(0.0, black)
  end
end
