
function DropTarget(elem) {
    elem.dropTarget = this;
    this._elem = elem;

    this._targetElem = null;
}


DropTarget.prototype._getTargetElem = function(avatar, event) {
    var target = avatar.getTargetElem();
    if (target.tagName != 'DIV') {
        return;
    }

    
    var elemToMove = avatar.getDragInfo(event).dragZoneElem.parentNode;

    var elem = target;
    while (elem) {
        if (elem == elemToMove) return; 
        elem = elem.parentNode;
    }

    return target;

   
};


DropTarget.prototype._showHoverIndication = function() {
    this._targetElem && this._targetElem.classList.add('hover');
};

DropTarget.prototype._hideHoverIndication = function() {
    this._targetElem && this._targetElem.classList.remove('hover');
};


DropTarget.prototype.onDragMove = function(avatar, event) {

    var newTargetElem = this._getTargetElem(avatar, event);

    if (this._targetElem != newTargetElem) {

        this._hideHoverIndication(avatar);
        this._targetElem = newTargetElem;
        this._showHoverIndication(avatar);
    }
};

DropTarget.prototype.onDragEnd = function(avatar, event) {
    if (!this._targetElem) {
        
        avatar.onDragCancel();
        return;
    }

    this._hideHoverIndication();

    var avatarInfo = avatar.getDragInfo(event);

    avatar.onDragEnd(); 

   
    var elemToMove = avatarInfo.dragZoneElem.parentNode; // <LI>
    var ul = this._targetElem.parentNode.getElementsByTagName('UL')[0];


    var title = avatarInfo.dragZoneElem.innerHTML; // переносимый заголовок

    
    if (!ul) { 
        ul = document.createElement('UL');
        ul.classList.add("Container");
        this._targetElem.parentNode.appendChild(ul);
    }

    if (elemToMove.classList.contains("IsRoot")&&!ul.parentNode.classList.contains("Root"))
        elemToMove.classList.remove("IsRoot");
    if (!elemToMove.classList.contains("IsRoot")&&ul.parentNode.classList.contains("Root"))
        elemToMove.classList.add("IsRoot");


    var li = null;
    for (var i = 0; i < ul.children.length; i++) {
        li = ul.children[i];
        var childTitle = li.children[0].innerHTML;
        if (childTitle > title) {
            break;
        }
        li = null;
    }


    if (elemToMove.parentNode.parentNode!=ul.parentNode) {
        if (elemToMove.parentNode.firstElementChild == elemToMove.parentNode.lastElementChild) {
            elemToMove.parentNode.parentNode.classList.remove("ExpandOpen");
            elemToMove.parentNode.parentNode.classList.add("ExpandLeaf");
            console.log("azazaz");
        }
        else {
            if (elemToMove.parentNode.lastElementChild == elemToMove)
                elemToMove.parentNode.children[elemToMove.parentNode.children.length - 2].classList.add("IsLast");
            //else  elemToMove.parentNode.children[elemToMove.parentNode.children.length-2].classList.add("IsLast");
            console.log("переделаем изласт");
            console.log(elemToMove.parentNode.children.length);
            console.log(elemToMove.parentNode.children[elemToMove.parentNode.children.length - 1].classList.toString());
        }
    }

    if (ul.parentNode.classList.contains("ExpandLeaf")) {
        ul.parentNode.classList.remove("ExpandLeaf");
        ul.parentNode.classList.add("ExpandOpen");
    }

    if(ul.lastElementChild) ul.lastElementChild.classList.remove("IsLast");
    ul.insertBefore(elemToMove, li);
    ul.lastElementChild.classList.add("IsLast");

    this._targetElem = null;
};

DropTarget.prototype.onDragEnter = function(fromDropTarget, avatar, event) {};

DropTarget.prototype.onDragLeave = function(toDropTarget, avatar, event) {
    this._hideHoverIndication();
    this._targetElem = null;
};