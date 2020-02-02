require "ruby2d"

set background: "navy"
set fps_cap:  20
# width = 640 /20 = 32
# height = 480 / 20 = 24

GRID_SIZE = 20 # Breaking up the screen into grid lines

class Snake
    attr_accessor :direction
    def initialize
        @positions = [[2, 0], [2, 1], [2, 2], [2, 3]] # Snake starting position on the grid
        @direction = "down"
    end

    def draw # Draw the snake with each method
        @positions.each do |position|
            Square.new(x:position[0] * GRID_SIZE, y: position[1] * GRID_SIZE, size: GRID_SIZE - 2, color: "white") 
        end
    end

    def move # Snake's movements with directions
        @positions.shift # remove last array from @positions to imitate movement
        case @direction
        when "down"
            @positions.push([head[0], head[1] + 1]) # Increment Y - for down movement
        when "up"
            @positions.push([head[0], head[1] - 1]) # Decrenent Y - for up movement
        when "left"
            @positions.push([head[0] -1, head[1]]) # Decrement X - for left movement
        when "right"
            @positions.push([head[0] +1, head[1]]) # Increment X - for right movement
        end
    end

    private

    def head
        @positions.last
    end
end

snake = Snake.new

update do # it will run for each frame / endless /
    clear # create a new screan each time to remove the squares

    snake.move
    snake.draw
end

on :key_down do |event| # Adding event listener to keyboard key press down
    if ["up", "down", "left", "right"].include?(event.key) #these are the cursor arrows
        snake.direction = event.key #the snake's direction will change to the value of the pressed cursor arrow
    end
end

show