
module Magick

    def self.image_info(filepath)
        image_info = `magick identify #{filepath}`
        return nil if image_info.empty?

        filename, img_format, size, _, bit_depth, colourspace, *other_stuff = image_info.split(" ")
        width, height = size.split("x").map { |n| n.to_i }

        return {
            "width" => width, 
            "height" => height, 
            "bit_depth" => bit_depth, 
            "colourspace" => colourspace
        }
    end

    def self.load_from_file(filepath, width, height, depth=8, format=:RGBA)
        # TODO: Check for valid format
        stream_data = `magick #{filepath.to_s} -size #{width.to_i}x#{height.to_i} -depth 8 #{format.to_s}:-`
        # TODO: Perform some checks on stream_data?
        return stream_data
    end

end
