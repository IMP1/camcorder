class Frame

    attr_reader :width
    attr_reader :height
    attr_reader :data

    def initialize(width, height)
        @width = width
        @height = height
        @data = [0] * @height * @width # Array of 32 bit integers in RGBA format (8 bits per channel)
    end

    def self.load_from_file(filepath)
        # TODO: Use a png library to load the data
        image_width = 0
        image_height = 0
        image_data = []
        frame = Frame.new(image_width, image_height)
        frame.instance_variable_set(:data, image_data)
        return frame
    end

    def to_string(format=:ARGB)
        case format
        when :RGBA
            return @data.map { |c| [c[24..31], c[16..23], c[8..15], c[0..7]].pack('C*') }.join("")
        when :ARGB
            return @data.map { |c| [ c[0..7], c[24..31], c[16..23], c[8..15]].pack('C*') }.join("")
        end
        return ""
    end

    def duplicate
        copy = Frame.new(width, height)
        copy.instance_variable_set(:data, data.clone)
        return copy
    end

    def []=(x, y, colour)
        c = Colour.to_rgba(colour)
        i = y * width + x
        @data[i] = c
    end

    def [](x, y)
        return @data[y * width + x]
    end

    def include_xy?(x, y)
        return y >= 0 && y < height && x >= 0 && x < width
    end

    def include_y?(y)
        return y >= 0 && y < height
    end

    def include_x?(x)
        return x >= 0 && x < width
    end

    #
    # Drawing Methods
    #

    def fill(colour)
        c = Colour.to_rgba(colour)
        @data = [c] * height * width
    end

    def fill_rect(rect, colour)
        c = Colour.to_rgba(colour)
        x_min = [rect.x, 0].max
        x_max = [rect.x + rect.width, width].min
        size = x_max - x_min
        rect.y.upto(rect.y + rect.height) do |j|
            next unless include_y?(j)
            n_from = j * width + x_min
            n_to = j * width + x_max
            @data[n_from...n_to] = [c] * size
        end
    end

    # Copies src_rect from src image to this image at coordinates dst, clipped accordingly to both image bounds.
    def copy_rect(source_data, source_rect, target_position)

    end

    # Alpha-blends src_rect from src image to this image at coordinates dst, clipped accordingly to both image bounds.
    def blend_rect(source_data, source_rect, target_position)

    end

    # TODO: Look up the Godot Image class (and the one in LOVE too) for methods to incorporate

end