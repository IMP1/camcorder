module Animator

    def self.lerp(start, finish, weight)
        return start * (1.0 - weight) + finish * weight
    end

    # TODO: Other tweens

end
