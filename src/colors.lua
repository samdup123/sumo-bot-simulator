local color = function(r,g,b) return function() return r,g,b end end

return {
  blue = color(.1, .3, .8),
  black = color(0, 0, 0),
  red = color(.6, 0, 0),
  white = color(1, 1, 1),
  green = color(0, .6, 0),

  orange = color(1, .5, 0),
  yellow = color(1, .8, .5),
  light_purple = color(.8, .5, 1),
  pink = color(1, .5, .8),

  brown = color(.5, .3, .1),
}
