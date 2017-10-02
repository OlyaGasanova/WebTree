function TreeDropTarget(elem) {
  TreeDropTarget.parent.constructor.apply(this, arguments);
}

extend(TreeDropTarget, DropTarget);

TreeDropTarget.prototype._showHoverIndication = function() {
  this._targetElem && this._targetElem.classList.add('hover');
};

TreeDropTarget.prototype._hideHoverIndication = function() {
  this._targetElem && this._targetElem.classList.remove('hover');
};

TreeDropTarget.prototype._getTargetElem = function(avatar, event) {
  var target = avatar.getTargetElem();
  if (target.tagName != 'DIV') {
    return;
  }

  // проверить, может быть перенос узла внутрь самого себя или в себя?
  var elemToMove = avatar.getDragInfo(event).dragZoneElem.parentNode;

  var elem = target;
  while (elem) {
    if (elem == elemToMove) return; // попытка перенести родителя в потомка
    elem = elem.parentNode;
  }

  return target;
};

TreeDropTarget.prototype.onDragEnd = function(avatar, event) {

  if (!this._targetElem) {
    // перенос закончился вне подходящей точки приземления
    avatar.onDragCancel();
    return;
  }

  this._hideHoverIndication();

  // получить информацию об объекте переноса
  var avatarInfo = avatar.getDragInfo(event);

  avatar.onDragEnd(); // аватар больше не нужен, перенос успешен

  // вставить элемент в детей в отсортированном порядке
  var elemToMove = avatarInfo.dragZoneElem.parentNode; // <LI>
  var ul = this._targetElem.parentNode.getElementsByTagName('UL')[0];


  var title = avatarInfo.dragZoneElem.innerHTML; // переносимый заголовок

  // получить контейнер для узлов дерева, соответствующий точке преземления
  if (!ul) { // нет детей, создадим контейнер
    ul = document.createElement('UL');
    ul.classList.add("Container");
    this._targetElem.parentNode.appendChild(ul);
  }

    if (elemToMove.classList.contains("IsRoot")&&!ul.parentNode.classList.contains("Root"))
        elemToMove.classList.remove("IsRoot");
    if (!elemToMove.classList.contains("IsRoot")&&ul.parentNode.classList.contains("Root"))
        elemToMove.classList.add("IsRoot");
    if (ul.parentNode.classList.contains("ExpandLeaf")) {
        ul.parentNode.classList.remove("ExpandLeaf");
        ul.parentNode.classList.add("ExpandOpen");
    }

  // вставить новый узел в нужное место среди потомков, в алфавитном порядке
  var li = null;
  for (var i = 0; i < ul.children.length; i++) {
    li = ul.children[i];
    var childTitle = li.children[0].innerHTML;
    if (childTitle > title) {
      break;
    }
    li = null;
  }


    console.log(elemToMove.parentNode.parentNode.classList.toString());

    if(elemToMove.parentNode.firstElementChild==elemToMove.parentNode.lastElementChild) {
    elemToMove.parentNode.parentNode.classList.remove("ExpandOpen");
      elemToMove.parentNode.parentNode.classList.add("ExpandLeaf");
        console.log("azazaz");
    }
    else {
      elemToMove.parentNode.children[elemToMove.parentNode.children.length-2].classList.add("IsLast");
        console.log("переделаем изласт");
        console.log(elemToMove.parentNode.children.length);
        console.log(elemToMove.parentNode.children[elemToMove.parentNode.children.length-2].classList.toString());
    }

    console.log(elemToMove.parentNode.parentNode.classList.toString());
  if(ul.lastElementChild) ul.lastElementChild.classList.remove("IsLast");
  ul.insertBefore(elemToMove, li);
  ul.lastElementChild.classList.add("IsLast");

  this._targetElem = null;
};