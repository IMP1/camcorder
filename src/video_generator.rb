require "ostruct"

class VideoGenerator

    FFPMEG_PATH = "C:/Users/Huw/bin/ffmpeg-6.1.1-full_build/bin/ffmpeg.exe"

    def initialize(width, height, duration, fps)
        @width = width.to_i
        @height = height.to_i
        @duration = duration.to_f # (seconds)
        @fps = fps.to_f
        @state = OpenStruct.new
    end

    def setup(first_frame)
    end

    def frame_at(time, last_frame)
        return last_frame
    end

    def generate_frames
        seconds_per_frame = 1.0 / @fps
        total_frames = (@fps * @duration).ceil.to_i + 1
        frame = Frame.new(@width, @height)
        setup(frame)
        total_frames.times do |frame_index|
            frame = frame_at(frame_index.to_f * seconds_per_frame, frame)
            yield frame
        end
    end

    def save(output_filepath)
        command_string = [FFPMEG_PATH, # path to ffpmeg
            '-y', '-r', "#{@fps}", # fps
            '-s', "#{@width}x#{@height}", # size
            '-pix_fmt', 'argb', # format
            '-f', 'rawvideo',  '-i', '-', # tell ffmpeg to expect raw video from the pipe
            '-vcodec', 'mpeg4', output_filepath # output encoding
        ]
        IO.popen(command_string, "r+") do |pipe|
            generate_frames do |frame|
                frame_data = frame.to_string(:ARGB)
                pipe.write(frame_data)
            end
        end

    end

end
