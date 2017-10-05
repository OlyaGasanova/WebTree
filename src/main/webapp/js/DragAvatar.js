
function DragAvatar(dragZone, dragElem) {

    this._dragZone = dragZone;

    this._dragZoneElem = dragElem;


    this._elem = dragElem;
}

DragAvatar.prototype.initFromEvent = function(downX, downY, event) {
    if (event.target.tagName != 'DIV') return false;

    this._dragZoneElem = event.target;
    var elem = this._elem = this._dragZoneElem.cloneNode(true);
    elem.className = 'avatar';

    
    var coords = getCoords(this._dragZoneElem);
    this._shiftX = downX - coords.left;
    this._shiftY = downY - coords.top;

    
    document.body.appendChild(elem);
    elem.style.zIndex = 9999;
    elem.style.position = 'absolute';

    return true;
};


DragAvatar.prototype.getDragInfo = function(event) {
    
    return {
        elem: this._elem,
        dragZoneElem: this._dragZoneElem,
        dragZone: this._dragZone
    };
};


DragAvatar.prototype.getTargetElem = function() {
    return this._currentTargetElem;
};


DragAvatar.prototype.onDragMove = function(event) {
    this._elem.style.left = event.pageX - this._shiftX + 'px';
    this._elem.style.top = event.pageY - this._shiftY + 'px';

    this._currentTargetElem = getElementUnderClientXY(this._elem, event.clientX, event.clientY);
};

DragAvatar.prototype._destroy = function() {
    console.log(this._elem.classList.toString()+" yfxfkj "+"  f djn   "+this._elem.textContent);
    this._elem.parentNode.removeChild(this._elem);
};

DragAvatar.prototype.onDragCancel = function() {
    this._destroy();
};

DragAvatar.prototype.onDragEnd = function() {
    this._destroy();
};