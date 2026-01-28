-- constant variables that are based on what the unit is
UNIT = 32
WINDOW_LENGTH = UNIT*10
WINDOW_HEIGHT = UNIT*10
GRAVITY = UNIT*4
JUMP = UNIT/4
SPEED = UNIT
ACCELERATION = SPEED/4

-- paths to the assets
CITY = "assets/tile-city.png"
WIND = "assets/tile-wind.png"
FINISH = "assets/tile-finish.png"
BACKGROUND = "assets/background.png"

return {
    UNIT = UNIT,
    WINDOW_LENGTH = WINDOW_LENGTH,
    WINDOW_HEIGHT = WINDOW_HEIGHT,
    GRAVITY = GRAVITY,
    JUMP = JUMP,
    SPEED = SPEED,
    ACCELERATION = ACCELERATION,
    CITY = CITY,
    WIND = WIND,
    BACKGROUND = BACKGROUND,
    FINISH = FINISH
}