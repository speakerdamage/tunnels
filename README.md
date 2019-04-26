# tunnels
a collection of uncertain delays using norns softcut. 

## Base script (no engine)
plug an audio source into norns
- page 1: change tunnel mode
- page 2: change control mode
- K1 (hold): clear buffers
- K2: randomize voices 1 & 2 (manual mode)
- K3: randomize voices 3 & 4 (manual mode)

## Adding tunnels to existing scripts (NEEDS TO BE RE-WRITTEN)
Note: requires UI library
Add the following near the top of the existing script: 
```
local tn = include('tunnels/lib/tunnel')
local tunnelmode = 0
local printmode = "tunnels off"
local tunnelgroup
```

Add tunnels functions:
```
local function tunnels_pan()...
local function update_tunnels()...

```

Add to init():
```
tn.init()
```

Edit enc/key functions. (IMPORTANT: depending on the existing script, this might need to be done differently to avoid interference with existing UI):
```
-- Encoder input
function enc(n, d)
  if n == 1 then
    if tunnelmode == 0 then
        tunnelmode = 1
    elseif tunnelmode == 1 then
      tunnelmode = 2
    elseif tunnelmode == 2 then
      tunnelmode = 3
    elseif tunnelmode == 3 then
      tunnelmode = 4
    elseif tunnelmode == 4 then
      tunnelmode = 5
    elseif tunnelmode == 5 then
      tunnelmode = 6
    elseif tunnelmode == 6 then
      tunnelmode = 7
    elseif tunnelmode == 7 then
      tunnelmode = 0
    end
    softcut.buffer_clear()
    tunnelgroup = 1
    update_tunnels()
    tunnelgroup = 2
    update_tunnels()
    redraw()
  end
end
```
```
-- Key input
function key(n, z)
  if z == 1 then
    if n == 1 then
      softcut.buffer_clear()
    elseif n == 2 then
      tunnelgroup = 1
      update_tunnels()
      redraw()
    elseif n == 3 then
      tunnelgroup = 2
      update_tunnels()
      redraw()
    end
  end
end
```

To add mode to redraw():
```
if tunnelmode == 0 then
    printmode = "tunnels off"
  elseif tunnelmode == 1 then
    printmode = "fractal landscape"
  elseif tunnelmode == 2 then
    printmode = "disemboguement"
  elseif tunnelmode == 3 then
    printmode = "post-horizon"
  elseif tunnelmode == 4 then
    printmode = "coded air"
  elseif tunnelmode == 5 then
    printmode = "failing lantern"
  elseif tunnelmode == 6 then
    printmode = "blue cat"
  elseif tunnelmode == 7 then
    printmode = "crawler"
  end
  ```
  ```
  screen.font_size(12)
	screen.move(10,18)
	screen.text("tunnels")
	screen.move(10,36)
	screen.font_size(8)
	screen.text(printmode)
  ```
