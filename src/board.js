var Side, Tile, addBarrierStyle, adjacent, clickTile, resetHover, roles, setBarrier, showAdjacent, sides, tiles, tmpRoles;

Tile = (function() {
  function Tile(data) {
    var key, value, _ref;
    this.data = data;
    this.id = false;
    this.adjacent = [];
    this.role = [];
    _ref = this.data;
    for (key in _ref) {
      value = _ref[key];
      this[key] = value;
    }
    this.data = null;
  }

  Tile.prototype.set = function(data) {
    var key, value, _ref;
    _ref = this.data;
    for (key in _ref) {
      value = _ref[key];
      this[key] = value;
    }
    return this.data = null;
  };

  return Tile;

})();

Side = (function() {
  function Side(data) {
    var key, value, _ref;
    this.data = data;
    this.id = false;
    this.adjacent = [];
    this.barrier = false;
    _ref = this.data;
    for (key in _ref) {
      value = _ref[key];
      this[key] = value;
    }
    this.data = null;
  }

  Side.prototype.set = function(data) {
    var key, value, _ref;
    _ref = this.data;
    for (key in _ref) {
      value = _ref[key];
      this[key] = value;
    }
    return this.data = null;
  };

  return Side;

})();

roles = ['Stone', 'Gems', 'Cloth', 'Wood', 'Temple', 'Market', 'Metals'];

sides = [];

sides[1] = [1, 2];

sides[2] = [1, 3];

sides[3] = [1, 4];

sides[4] = [2, 4];

sides[5] = [2, 5];

sides[6] = [3, 4];

sides[7] = [4, 5];

sides[8] = [3, 6];

sides[9] = [4, 6];

sides[10] = [4, 7];

sides[11] = [5, 7];

sides[12] = [6, 7];

adjacent = [];

adjacent[1] = [2, 3, 4];

adjacent[2] = [1, 4, 5];

adjacent[3] = [1, 4, 6];

adjacent[4] = [1, 2, 3, 5, 6, 7];

adjacent[5] = [2, 4, 7];

adjacent[6] = [3, 4, 7];

adjacent[7] = [4, 5, 6];

tiles = [];

tmpRoles = roles.slice();

adjacent.forEach(function(adjacent, index) {
  var el, roleIndex;
  roleIndex = Math.floor(Math.random() * (tmpRoles.length - 1)) + 1;
  tiles[index] = new Tile({
    id: index,
    role: tmpRoles[roleIndex - 1],
    adjacent: adjacent
  });
  el = document.getElementById("label" + index);
  el.className = el.className + ' ' + tmpRoles[roleIndex - 1].toLowerCase();
  el.innerHTML = tiles[index].role;
  return tmpRoles.splice(roleIndex - 1, 1);
});

showAdjacent = function(id) {
  id = id.replace("tile", "", "gi");
  return tiles[id].adjacent.forEach(function(adjacent, index) {
    var el;
    el = document.getElementById("tile" + adjacent);
    return el.className += ' available';
  });
};

resetHover = function() {
  return adjacent.forEach(function(adjacent, index) {
    var className, el;
    el = document.getElementById("tile" + index);
    className = el.className;
    className = className.replace(" available", "");
    className = className.replace(" current", "");
    return el.className = className;
  });
};

clickTile = function(tile) {
  var el;
  resetHover();
  showAdjacent(tile.id);
  el = document.getElementById(tile.id);
  return el.className += ' current';
};

addBarrierStyle = function(sideId, tileId) {
  var className, el;
  el = document.getElementById('tile' + tileId);
  className = el.className;
  return el.className = className + ' side' + sideId + ' ';
};

setBarrier = function(id) {
  var el, sideAdj, tmpSides;
  el = document.getElementById(id);
  id = id.replace("side", "", "gi");
  sideAdj = [];
  tmpSides = [];
  sides[id].forEach(function(value, i) {
    tmpSides.push(value);
    sideAdj.push(tiles[value].adjacent.slice());
    return addBarrierStyle(id, value);
  });
  console.log(sideAdj);
  sideAdj[1].forEach(function(tile, i) {
    console.log('tile: ' + tile + ' i: ' + i);
    if (tmpSides[0] === tile) {
      return tiles[tile].adjacent.splice(i, 1);
    }
  });
  sideAdj[0].forEach(function(tile, i) {
    console.log('tile: ' + tile + ' i: ' + i);
    if (tmpSides[1] === tile) {
      return tiles[tile].adjacent.splice(i, 1);
    }
  });
  return true;
};
