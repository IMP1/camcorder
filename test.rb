# TODO:
#
#   - [ ] Read through [this project](https://github.com/wvanbergen/chunky_png/blob/master/lib/chunky_png/canvas.rb)
#   - [ ] Give this a readme
#   - [ ] Work on some shape rendering
#   - [ ] Work on some alpha blending
#   - [ ] Image loading
#   - [ ] Font handling? Or just use bitmap fonts?
#   - [ ] Have a look at other projects involving CPU rendering, which it feels like this is
#


require_relative 'src/camcorder'

class MyVideo < VideoGenerator
    def setup(first_frame)
        @state.fade = false
        first_frame.fill(Colour::RED)
        first_frame.fill_rect(Rect.new(0, 0, 128, 96), Colour::BLUE)
    end
    def frame_at(time, last_frame)
        if time >= @duration / 2 and not @state.fade
            @state.fade = true
        end

        if @state.fade
            t = (time - @duration / 2) * 2
            c = Animator.lerp(Colour::RED, Colour::BLUE, t)
            last_frame.fill(c)
            last_frame.fill_rect(Rect.new(0, 0, 128, 96), Colour::BLUE)
        end

        return last_frame
    end
end


begin    
    width = 640
    height = 480
    duration = 2.0 
    fps = 12
    output_filepath = "my_test.mp4"
    vid = MyVideo.new(width, height, duration, fps)
    vid.save(output_filepath)
end
