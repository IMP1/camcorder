module Painter

    def self.lerp(start, finish, weight)
        return start * (1.0 - weight) + finish * weight
    end

    def self.fill(frame, colour)
        frame.fill_colour(colour)
    end

    def self.line(frame, start_pos, end_pos, colour)
        raise "Not yet implemented"
    end

    # TODO: Circle, Square, etc.

end