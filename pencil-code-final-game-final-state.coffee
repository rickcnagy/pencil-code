##########################
# GAME LEVEL DEFINITIONS #
##########################

level1 =
  draw: () ->
    this.drawBackground()
    # draw the platform:
    pen up
    moveto -278, -80
    rt 90
    pen red, 10
    fd 100
    drawBump()
    drawLadder(3)
    fd 300

    # draw level goal
    pen green, 5
    drawFinishLine(0, 50)

    # move into starting position position:
    turnto 0
    moveto -200, 100
  drawBackground: () ->
    drawPyramid()
  nextLevel: ()  ->
    level2

level2 =
  draw: () ->
    this.drawBackground()
    # draw the platform:
    pen up
    moveto -325, -100
    rt 90
    pen red, 10
    drawBump()
    fd 40
    drawStairs(4,65)
    pen up
    moveto -130, -200
    pen red, 10
    drawStairs(4,70)
    pen up

    # draw level goal
    moveto -200, -200
    drawFinishLine(90, 100)

    # move into starting position position:
    turnto 0
    moveto -250, 10
  drawBackground: () ->
    drawPyramid()
  nextLevel: () ->
    level3

level3 =
  draw: () ->
    this.drawBackground()

    # draw the platform:
    pen up
    moveto -325, -100
    rt 90
    pen red, 10
    drawBump()
    fd 100
    pen up

    # draw level goal
    moveto -400, -200
    drawFinishLine(0, 300)

    # move into starting position position:
    turnto 0
    moveto -250, 10
  drawBackground: () ->
    drawPyramid()
  nextLevel: () ->
    level4

level4 =
  draw: () ->
    this.drawBackground()
    # draw the platform:
    pen down
    moveto -325, -101
    rt 70
    pen red, 10
    drawBump()
    fd 200
    pen up

    # draw level goal
    drawFinishLine(-20, 50)

    # move into starting position position:
    turnto 0
    moveto -250, 10
  drawBackground: () ->
    drawPyramid()
  nextLevel: () ->
    level1


#####################
# Drawing functions #
#####################
drawBump = () ->
    lt 90
    fd 50
    rt 90
    fd 100
    rt 90
    fd 50
    lt 90

drawPyramid = () ->
  speed Infinity
  dot 2500, white
  moveto 300, 300
  dot 250, yellow
  drawTriangle(-400, -150, 350, "tan", "burlywood")
  drawTriangle(-150, -150, 550, "tan", "burlywood")
  drawTriangle(150, -150, 350, "tan", "burlywood")
  home()
  speed window.turtleSpeed

drawLadder = (stepsNumber) ->
  stepSize = 70
  height = 80
  turnto 90
  fd stepSize * 2
  for [1..stepsNumber]
    lt 90
    pen up
    fd height
    lt 90
    pen red, 10
    fd stepSize
    rt 180
    pen up
    fd stepSize
  pen red, 10

drawStairs = (number, size) ->
  fd size
  for [1..number]
    lt 90
    fd size
    rt 90
    fd size

#####################
# GAME CONTROL CODE #
#####################

setupGame = () ->
  window.currentLevel = level1
  window.velocity = 0
  window.gravity = 0.5
  window.inAir = false
  window.turtleSpeed = 15
  window.pauseControls = false

drawTriangle = (x, y, length, color, color2) ->
  turnto 0
  moveto x, y
  pen color, 5
  pd()
  rt 30
  fd length
  rt 120
  fd length
  rt 120
  fd length
  fill color2
  pu()

setupTurtle = () ->
  wear "white", 30

setupCharacter = () ->
  wear "http://newsupermariobros2.nintendo.com/_ui/img/about-the-game/carousel/jump.png", 60


drawFinishLine = (angle, length) ->
  pen green, 5
  turnto angle
  fd length
  pen up

launchNextLevel = () ->
  window.currentLevel = window.currentLevel.nextLevel()
  setupTurtle()
  cg()
  speed window.turtleSpeed
  window.currentLevel.draw()
  setupCharacter()
  speed Infinity

updateTurtle = () ->
  window.velocity -= window.gravity
  slide 0, window.velocity
  if turtle.touches green
    launchNextLevel()
  if turtle.touches red
    window.inAir = false
    while turtle.touches red
      fd 1
    window.velocity = 0
  if pressed 'left'
    slide -5, 0
    if (turtle.touches red)
      slide 5, 0
  if pressed 'right'
    slide 5, 0
    if (turtle.touches red)
      slide -5, 0
  if pressed 'up'
    if not window.inAir
      window.velocity += 8
      window.inAir = true

# startup the game by allowing keyboard control of the turtle
activateControls = () ->
  speed Infinity
  forever ->
    updateTurtle()

###############
# LAUNCH GAME #
###############

setupGame()
currentLevel.draw()
setupCharacter()
activateControls()


