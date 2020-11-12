## A TIX clock in Nim using SDL2

import sdl2, random, times

let update_interval = 4   # update interval in seconds

discard sdl2.init(INIT_EVERYTHING)

var
  window: WindowPtr
  render: RendererPtr

window = createWindow("tix", 100, 100, 1200, 300, SDL_WINDOW_SHOWN)
render = createRenderer(window, -1, Renderer_Accelerated or
    Renderer_PresentVsync or Renderer_TargetTexture)

randomize()

var
  evt = sdl2.defaultEvent
  runGame = true
  r: Rect
  a3 = [0, 1, 2]
  a6 = [0, 1, 2, 3, 4, 5]
  a9 = [0, 1, 2, 3, 4, 5, 6, 7, 8]
  last = -1

while runGame:
  let
    n = now()
    d = n.format("hhmm")
    s = n.second div update_interval
  while pollEvent(evt):
    if evt.kind == QuitEvent:
      runGame = false
      break
  if s == last:
    render.present
    delay(100)
    continue
  else:
    last = s

  render.setDrawColor 0, 0, 0, 255
  render.clear
  r.w = 80
  r.h = 80

  render.setDrawColor 255, 0, 0, 255
  shuffle(a3)
  for i in 0..int(d[0])-49:
    r.x = 10
    r.y = 10 + 100 * cast[cint](a3[i])
    render.fillRect(r)

  render.setDrawColor 0, 255, 0, 255
  shuffle(a9)
  for i in 0..int(d[1])-49:
    r.x = 210 + 100 * cast[cint](a9[i] mod 3)
    r.y = 10 + 100 * cast[cint](a9[i] div 3)
    render.fillRect(r)

  render.setDrawColor 0, 0, 255, 255
  shuffle(a6)
  for i in 0..int(d[2])-49:
    r.x = 610 + 100 * cast[cint](a6[i] mod 2)
    r.y = 10 + 100 * cast[cint](a6[i] div 2)
    render.fillRect(r)

  render.setDrawColor 255, 0, 0, 255
  shuffle(a9)
  for i in 0..int(d[3])-49:
    r.x = 910 + 100 * cast[cint](a9[i] mod 3)
    r.y = 10 + 100 * cast[cint](a9[i] div 3)
    render.fillRect(r)

  render.present
  delay(100)

destroy render
destroy window

