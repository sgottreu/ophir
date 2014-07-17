
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
  
  tiles[index] = new Tile { id: index, role: tmpRoles[roleIndex-1], adjacent: adjacent }
  
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

setBarrier = (id) ->
  el = document.getElementById(id)

  id = id.replace("side", "", "gi")

  sideAdj = []
  tmpSides = []

  sides[id].forEach (value, i) ->
    tmpSides.push(value)
    sideAdj.push(tiles[value].adjacent.slice())
    addBarrierStyle(id, value)


  console.log(sideAdj)

  sideAdj[1].forEach (tile, i) ->
    console.log('tile: '+tile+' i: '+i)
    if tmpSides[0] == tile
      tiles[tile].adjacent.splice(i, 1)

  sideAdj[0].forEach (tile, i) ->
    console.log('tile: '+tile+' i: '+i)
    if tmpSides[1] == tile
      tiles[tile].adjacent.splice(i, 1)

  return true


  # sides[id].forEach (border, index) ->
  #   tmpId = id
  #   sideAdj.forEach (b, i) ->
  #     el = document.getElementById("side"+tmpId)
  #     console.log el.checked
  #     if el.checked
  #       b.forEach ( side, j) ->
  #         if side == border
  #           tiles[i].adjacent.splice(j, 1)
  #     else
  #       tiles[i].adjacent = adjacent[i]
  #       el = document.getElementById("tile"+tmpId)
  #       className = el.className
  #       strReplace = ' side'+tmpId+ ' '
  #       className = className.replace(strReplace, "")
  #       el.className = className

  # sides[id].forEach (border, index) ->
  #   newAdj[border] = tiles[border].adjacent
  #   el = document.getElementById('tile'+border)
  #   className = el.className
  #   el.className = className+' side'+id+ ' '

  # sides[id].forEach (border, index) ->
  #   tmpId = id
  #   newAdj.forEach (b, i) ->
  #     el = document.getElementById("side"+tmpId)
  #     console.log el.checked
  #     if el.checked
  #       b.forEach ( side, j) ->
  #         if side == border
  #           tiles[i].adjacent.splice(j, 1)
  #     else
  #       tiles[i].adjacent = adjacent[i]
  #       el = document.getElementById("tile"+tmpId)
  #       className = el.className
  #       strReplace = ' side'+tmpId+ ' '
  #       className = className.replace(strReplace, "")
  #       el.className = className

