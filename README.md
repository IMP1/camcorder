# Camcorder 📹

Inspired by projects like [Manim](https://www.manim.community/), and [Motion Canvas](https://motioncanvas.io/), *Camcorder* is a project for generating videos through code.
  
Currently **VERY** barebones, it can use ffmpeg to create a video file, and can make coloured squared in each frame.

Ideally this project will (soon?) include features like:

  - some alpha blending capability
  - loading images from the filesystem and copying them (or parts of them) onto frames
  - rendering some geometry like lines and shapes
  - an animation library for tweens and things changing over time
  - using fonts to write text


# Example

This initial example demonstrates the entry point for generating your own video. It just makes a 2 second video that is half blue, and then half red.
The `frame_at` method is where you draw to the current frame. It is passed the current time through the video, and the last frame.

```ruby
require_relative 'src/camcorder'

class MyVideo < VideoGenerator
    def frame_at(time, last_frame)
        if time < @duration
            last_frame.fill(Colour::BLUE)
        else
            last_frame.fill(Colour::RED)
        end
        return last_frame
    end
end

begin    
    VideoGenerator.set_ffmpeg_path("my/path/to/ffmpeg")
    width = 640
    height = 480
    duration = 2.0 
    fps = 12
    output_filepath = "my_first_video.mp4"
    vid = MyVideo.new(width, height, duration, fps)
    vid.save(output_filepath)
end
```
