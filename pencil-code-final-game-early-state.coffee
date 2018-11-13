##########################
# GAME LEVEL DEFINITIONS #
##########################

speed Infinity

level1 =
  draw: () ->
    # draw the platform:
    pen up
    moveto -278, -80
    rt 90
    pen red, 10
    fd 200
    lt 90
    fd 50
    rt 90
    fd 100
    rt 90
    fd 50
    lt 90
    fd 200

    # draw level goal
    pen green, 5
    drawFinishLine(0, 50)

    # move into starting position position:
    turnto 0
    moveto -200, 100


###############################################################################
# TO DO:
# 1. Change level1. Make it a bit more challenging or interesting.
#    Hint: The code for level one is indented under the "draw: () ->"
#    function of the "window.level1" object
# 2. Add a third level. Hint: copy the code for level1 or leve2, and call it
#    level3. change level3 a bit so its not identical to the previous levels!
#
#    *Important: change the `nextLevel` function of level2 to return level3!
# 3. Remember some drawing you made in previous classes? add one of those into
#    one of the levels
# 4. Change the shape of the "bump" by changing the code of the
#    function `window.drawBump`
# 5. make the levels draw instantly. Hint: change the 'speed' level
# 6. Change the colors the turtle interacts with. Hint: look for all instances
#    of "red", or "green" in ALL the code.
# 7. Add another color that the turtle interacts with. (for example, When the
#    turtle touches that color, make a sound). Hint: look at the proper place
#    in the "updateTurtle" function to add this new color behavior.
###############################################################################

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
  #setupBackground()
  #setupTurtle()

  wear "white", 30

drawFinishLine = (angle, length) ->
  pen green, 5
  turnto angle
  fd length
  pen up

updateTurtle = () ->
  window.velocity -= window.gravity
  slide 0, window.velocity
  if turtle.touches green
    write 'hooray'
    home
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
  forever ->
    updateTurtle()

###############
# LAUNCH GAME #
###############

setupGame()
currentLevel.draw()
activateControls()
