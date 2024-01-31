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
        c = ((colour.r * 256).to_i.clamp(0, 255) << 24) + 
            ((colour.g * 256).to_i.clamp(0, 255) << 16) + 
            ((colour.b * 256).to_i.clamp(0, 255) << 8) +
            ((colour.a * 256).to_i.clamp(0, 255) << 0)
        # Not sure whether to multiple 256 which gives more intuitive results for eg 0.5 -> 80, 
        # but then requires awkwardly clamping
        # c = ((colour.a * 255).to_i << 24) + 
        #     ((colour.r * 255).to_i << 16) + 
        #     ((colour.g * 255).to_i << 8) +
        #     ((colour.b * 255).to_i << 0)
        return c
    end
    
    def +(other)
        return Colour.new(r+other.r, g+other.g, b+other.b, a)
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