module Minicolor
  class Color
    def initialize(color = nil)
      if color =~ /^([a-fA-F0-9]{3}){1,2}$/
        if color.size == 3
          @hex = ''
          color.each_char { |c| @hex << c * 2 }
        else
          @hex = color
        end
      elsif color.is_a? Array
        if color.size == 3 && color.max <= 255 && color.min >= 0
          @rgb = color
          @hex = to_hex
        end
      elsif color.nil?
        @rgb = []
        3.times { @rgb << rand(256) }
        @hex = to_hex
      end
      @rgb = to_rgb
      @hsl = to_hsl
    end

    def to_rgb
      @hex.scan(/[a-fA-F0-9]{2}/).collect { |x| x.hex }
    end

    def to_hex
      output = ''
      @rgb.each do |x|
        if x < 16
          output << '0'
        end
        output << x.to_s(16)
      end
      output
    end

    def complementary(n = 2)
      h, s, l = @hsl
      hi = 1.0 / n
      output = [Color.new(hsl_to_rgb(h, s, l))]
      (n - 1).times do |i|
        ht = h + hi * (i + 1)
        ht -= 1 if ht > 1
        output << Color.new(hsl_to_rgb(ht, s, l))
      end
      output
    end

    def analogous(n)
      h, s, l = @hsl
      hd = 1.0 / 3.0
      hi = hd / (n - 1)
      hl = h - 1.0 / 6.0
      output = []
      n.times do |i|
        hh = hl + hi * i
        hh -= 1 if hh > 1
        hh += 1 if hh < 0
        p hh
        output << Color.new(hsl_to_rgb(hh, s, l))
      end
      output
    end

    def luminance
      r, g, b = @rgb.collect do |x|
        x /= 255.0
        if x <= 0.03928
          x /= 12.92
        else
          x = ((x + 0.055) / 1.055) ** 2.4
        end
      end
      0.2126 * r + 0.7152 * g + 0.0722 * b
    end

    private

    def to_hsl
      # normalized rgb
      rgb = @rgb.collect { |x| x / 255.0 }
      min = rgb.min
      max = rgb.max
      delta = max - min
      l = (max + min) / 2.0
      if delta == 0
        h = 0
        s = 0
      else
        if l < 0.5
          s = delta / (max + min)
        else
          s = delta / (2 - max - min)
        end
        delta_rgb = rgb.collect do |x|
          ((max - x) / 6.0 + delta / 2.0) / delta
        end
        if rgb[0] == max
          h = delta_rgb[2] - delta_rgb[1]
        elsif rgb[1] == max
          h = (1.0 / 3.0) + delta_rgb[0] - delta_rgb[2]
        elsif rgb[2] == max
          h = (2.0 / 3.0) + delta_rgb[1] - delta_rgb[0]
        end
        h += 1 if h < 0
        h -= 1 if h > 1
      end
      [h, s, l]
    end

    def hsl_to_rgb(h, s, l)
      if s == 0
        r, g, b = l * 255, l * 255, l * 255
      else
        if l < 0.5
          v2 = l * (1 + s)
        else
          v2 = l + s - l * s
        end
        v1 = 2 * l - v2
        r = 255 * hue_rgb(v1, v2, h + 1.0 / 3.0) 
        g = 255 * hue_rgb(v1, v2, h)
        b = 255 * hue_rgb(v1, v2, h - 1.0 / 3.0)
      end
      [r.round, g.round, b.round]
    end

    def hue_rgb(v1, v2, vh)
      vh += 1 if vh < 0
      vh -= 1 if vh > 1
      return v1 + (v2 - v1) * 6 * vh if (6 * vh) < 1
      return v2 if (2 * vh) < 1
      return v1 + (v2 - v1) * ((2.0 / 3.0) - vh) * 6 if (3 * vh) < 2
      return v1
    end
  end
end
