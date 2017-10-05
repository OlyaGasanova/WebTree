
function DragZone(elem) {
    elem.dragZone = this;
    this._elem = elem;
}

DragZone.prototype._makeAvatar = function() {
    return new DragAvatar(this, this._elem);
};


DragZone.prototype.onDragStart = function(downX, downY, event) {

    var avatar = this._makeAvatar();

    if (!avatar.initFromEvent(downX, downY, event)) {
        return false;
    }

    return avatar;
};