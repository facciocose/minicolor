# minicolor

Minimal color management gem

	require 'minicolor'

    # random color
    color = Minicolor::Color.new
    
    # white (short hex notation)
    color = Minicolor::Color.new('fff')
    
    # red (long hex notation)
    color = Minicolor::Color.new('ff0000')
    
    # get complementary of "c" color
    c1, c2 = c.complementary
    
    # get two analogous colors of "c" color
    c1, c2 = c.analogous(2)

minicolor is the heart of [whatcolor](http://whatcolor.heroku.com/) and it's released under MIT license (see the LICENSE file).