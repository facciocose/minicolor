require 'minicolor'
require 'test/unit'

class TestColor < Test::Unit::TestCase
  def test_complementary
    c1 = Minicolor::Color.new('cc0000')
    c2 = c1.complementary[1]
    assert_equal(c2.to_hex, '00cccc')
  end
  
  def test_analogous
    c = Minicolor::Color.new('cc0000')
    c1, c2, c3 = c.analogous(3)
    assert_equal(c1.to_hex, 'cc00cc')
    assert_equal(c2.to_hex, 'cc0000')
    assert_equal(c3.to_hex, 'cccc00')
  end
  
  def test_luminance
    c = Minicolor::Color.new('fff')
    white = c.luminance
    c = Minicolor::Color.new('000')
    black = c.luminance
    c = Minicolor::Color.new('808080')
    grey = c.luminance

    assert_equal(white, 1.0)
    assert_equal(black, 0.0)
    assert_equal(grey, 0.5)
  end
end
