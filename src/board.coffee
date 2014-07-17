
class Tile
  constructor: (@data) ->
    @id=false
    @adjacent=[]
    @role=[]
    
    for key, value of @data
        this[key] = value
    @data = null
    
  set: (data) ->
    for key, value of @data
        this[key] = value
    @data = null
    


class Side
  constructor: (@data) ->
    @id=false
    @adjacent=[]
    @barrier = false
    
    for key, value of @data
        this[key] = value
    @data = null
    
  set: (data) ->
    for key, value of @data
        this[key] = value
    @data = null

roles = ['Stone', 'Gems', 'Cloth', 'Wood', 'Temple', 'Market', 'Metals']

sides = []
sides[1] = [1,2]
sides[2] = [1,3]
sides[3] = [1,4]
sides[4] = [2,4]
sides[5] = [2,5]
sides[6] = [3,4]
sides[7] = [4,5]
sides[8] = [3,6]
sides[9] = [4,6]
sides[10] = [4,7]
sides[11] = [5,7]
sides[12] = [6,7]


adjacent = []
adjacent[1] = [2,3,4]
adjacent[2] = [1,4,5]
adjacent[3] = [1,4,6]
adjacent[4] = [1,2,3,5,6,7]
adjacent[5] = [2,4,7]
adjacent[6] = [3,4,7]
adjacent[7] = [4,5,6]

tiles = []
tmpRoles = roles.slice()

adjacent.forEach (adjacent, index) ->
  roleIndex = Math.floor(Math.random() * (tmpRoles.length - 1)) + 1
  
  tiles[index] = new Tile { id: index, role: tmpRoles[roleIndex-1], adjacent: adjacent.slice() }
  
  el = document.getElementById("label"+index)

  el.className = el.className + ' ' + tmpRoles[roleIndex-1].toLowerCase() 

  el.innerHTML = tiles[index].role

  tmpRoles.splice(roleIndex-1, 1)

showAdjacent = (id) ->
  id = id.replace("tile", "", "gi")
  tiles[id].adjacent.forEach (adjacent, index) ->
    el = document.getElementById("tile"+adjacent)
    el.className += ' available'

resetHover = ->
  adjacent.forEach (adjacent, index) ->
    el = document.getElementById("tile"+index)
    className = el.className
    className = className.replace(" available", "")
    className = className.replace(" current", "")
    el.className = className


clickTile = (tile) ->
  resetHover()
  showAdjacent(tile.id)
  el = document.getElementById(tile.id)
  el.className += ' current'

addBarrierStyle = (sideId, tileId) ->
  el = document.getElementById('tile'+tileId)
  className = el.className
  el.className = className+' side'+sideId+ ' '

checkBarrierCount = () ->
  barriers = 0
  canContinue = true
  sides.forEach (value, i) ->
    el = document.getElementById("side"+i)
    if el.checked
      barriers++
  if barriers > 2
    alert('You have too many barriers.')
    canContinue = false

    
  return canContinue

setBarrier = (id) ->
  id = id.replace("side", "", "gi")

  sides[id].forEach (value, i) ->
    if !checkBarrierCount()
      el = document.getElementById("side"+id)
      el.checked = false
      return false

  el = document.getElementById(id)
  sideAdj = []
  tmpSides = []

  sides[id].forEach (value, i) ->
    tmpSides.push(value)
    sideAdj.push(tiles[value].adjacent.slice())
    addBarrierStyle(id, value)
    return true

  el = document.getElementById("side"+id)

  if el.checked
    sideAdj[1].forEach (tile, i) ->
      console.log('tile: '+tile+' i: '+i)
      if tmpSides[0] == tile
        tiles[tile].adjacent.splice(i, 1)
        return true

    sideAdj[0].forEach (tile, i) ->
      console.log('tile: '+tile+' i: '+i)
      if tmpSides[1] == tile
        tiles[tile].adjacent.splice(i, 1)
        return true
    return true
  else
    sides[id].forEach (value, i) ->
      tiles[value].adjacent = adjacent[value].slice()
      el = document.getElementById("tile"+value)
      re = new RegExp("/side"+id+"/", "gi")
      className = el.className
      className = className.replace("side"+id, "")
      className = className.replace("side"+id, "")
      el.className = className
      return true
    return true

  return true
