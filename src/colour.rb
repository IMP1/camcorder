class Colour
    
    attr_reader :r
    attr_reader :g
    attr_reader :b
    attr_reader :a

    def initialize(r, g, b, a=1.0)
        @r = r.to_f.clamp(0.0, 1.0)
        @g = g.to_f.clamp(0.0, 1.0)
        @b = b.to_f.clamp(0.0, 1.0)
        @a = a.to_f.clamp(0.0, 1.0)
    end

    def self.to_rgba(colour)
        c = ((colour.r * 255).to_i << 24) + 
            ((colour.g * 255).to_i << 16) + 
            ((colour.b * 255).to_i << 8) +
            ((colour.a * 255).to_i << 0)
        # Not sure whether to multiple 256 which gives more intuitive results for eg 0.5 -> 80, 
        # but then requires awkwardly clamping
        # c = ((colour.a * 255).to_i << 24) + 
        #     ((colour.r * 255).to_i << 16) + 
        #     ((colour.g * 255).to_i << 8) +
        #     ((colour.b * 255).to_i << 0)
        return c
    end

    def self.from_rgba(c)
        r = c[24..31].to_f / 255.0
        g = c[16..23].to_f / 255.0
        b = c[8..15].to_f / 255.0
        a = c[0..7].to_f / 255.0
        return Colour.new(r, g, b, a)
    end
    
    def +(other)
        return Colour.new(r + other.r, g + other.g, b + other.b, a)
    end

    def blend(other)
        new_a = 1.0 - (1.0 - other.a) * (1.0 - self.a)
        new_r = other.r * other.a / new_a + self.r * self.a * (1 - other.a) / new_a
        new_g = other.g * other.a / new_a + self.g * self.a * (1 - other.a) / new_a
        new_b = other.b * other.a / new_a + self.b * self.a * (1 - other.a) / new_a
        
        # https://stackoverflow.com/questions/726549/algorithm-for-additive-color-mixing-for-rgb-values
        # https://sighack.com/post/averaging-rgb-colors-the-right-way

        new_a = 1 - (1 - self.a) * (1 - other.a)
        s = other.a * (1.0 - self.a) / new_a
        new_r = (1.0 - s) * self.r + s * other.r
        new_g = (1.0 - s) * self.g + s * other.g
        new_b = (1.0 - s) * self.b + s * other.b

        return Colour.new(new_r, new_g, new_b, new_a)
    end

    def mix(other, weight, gamma=2.2)
        if gamma == 1.0 || gamma.nil?
            new_r = (1.0 - t) * self.r + t * other.r
            new_g = (1.0 - t) * self.g + t * other.g
            new_b = (1.0 - t) * self.b + t * other.b
            new_a = (1.0 - t) * self.a + t * other.a
        else
            new_r = Math.pow((1.0-t) * self.r ** gamma + t * other.r ** gamma, 1.0 / gamma)
            new_g = Math.pow((1.0-t) * self.g ** gamma + t * other.g ** gamma, 1.0 / gamma)
            new_b = Math.pow((1.0-t) * self.b ** gamma + t * other.b ** gamma, 1.0 / gamma)
            new_a = (1.0 - t) * self.a + t * other.a
        end
        return Colour.new(new_r, new_g, new_b, new_a)
    end

    def -(other)
        return Colour.new(r-other.r, g-other.g, b-other.b, a)
    end

    def *(factor)
        return Colour.new(r*factor, g*factor, b*factor, a)
    end

    WHITE = Colour.new(1.0, 1.0, 1.0)
    BLACK = Colour.new(0.0, 0.0, 0.0)
    RED = Colour.new(1.0, 0.0, 0.0)
    GREEN = Colour.new(0.0, 1.0, 0.0)
    BLUE = Colour.new(0.0, 0.0, 1.0)
    # TODO: Add more here

end