class Table
    HEIGHT = 5
    WIDTH = 5

    def valid_position?(x, y)
        x.between?(0, WIDTH - 1) && y.between?(0, HEIGHT - 1)
    end
end