<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Тестовое приложение</title>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="content-type" content="text/html;charset=UTF-8"/>

    <script src="js/lib.js"></script>
    <script src="js/DragManager.js"></script>
    <script src="js/DragAvatar.js"></script>
    <script src="js/DragZone.js"></script>
    <script src="js/DropTarget.js"></script>
    <script src="js/ShowForm.js"></script>
    <script src="https://cdn.polyfill.io/v1/polyfill.js?features=Element.prototype.closest"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.0.3/jquery.min.js"></script>
    <script type="text/javascript" src="https://netdna.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>

    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.3.0/css/font-awesome.min.css"
          rel="stylesheet" type="text/css">
    <link href="https://pingendo.github.io/pingendo-bootstrap/themes/default/bootstrap.css"
          rel="stylesheet" type="text/css">
    <link rel="stylesheet" type="text/css" href="./css/dragTree.css">
    <link rel="stylesheet" type="text/css" href="./css/form.css">
    <link rel="stylesheet" type="text/css" href="./css/treeUI.css">

    <link href="//fonts.googleapis.com/css?family=Roboto:300,400,500,700" rel="stylesheet" type="text/css">

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>

    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>




</head>

<body>
<div id="prompt-form-container">
    <form id="prompt-form">
        <div id="prompt-message"></div>
        <input name="text" type="text" autocomplete="off">
        <input type="submit" value="Ок">
        <input type="button" name="cancel" value="Отмена">
    </form>
</div>

<div id="tree" class="section">
    <div class="task__content Root"  onclick="tree_toggle(arguments[0])">
        <div class="MainNode">Root</div>
        <ul class="Container ">
            <li class="Node IsRoot ExpandClosed">
                <div class="Expand"></div>
                <div class="Content">Item 1</div>
                <ul class="Container">
                    <li class="Node ExpandClosed">
                        <div class="Expand"></div>
                        <div class="Content">Item 1.1</div>
                        <ul class=" Container">
                            <li class="Node ExpandLeaf IsLast">
                                <div class="Expand"></div>
                                <div class="Content">Item 1.1.2</div>
                            </li>
                        </ul>
                    </li>
                    <li class="Node ExpandLeaf IsLast">
                        <div class="Expand"></div>
                        <div class="Content">Item 1.2</div>
                    </li>
                </ul>
            </li>
            <li class="Node IsRoot ExpandClosed">
                <div class="Expand"></div>
                <div class="Content">Item 2<br/>title long yeah</div>
                <ul class=" Container ">
                    <li class="Node ExpandLeaf IsLast">
                        <div class="Expand"></div>
                        <div class="Content">Item 2.1</div>
                    </li>
                </ul>
            </li>
            <li class="Node ExpandOpen IsRoot IsLast">
                <div class="Expand"></div>
                <div class="Content">Item 3</div>
                <ul class=" Container ">
                    <li class="Node ExpandLeaf IsLast">
                        <div class="Expand"></div>
                        <div class="Content" >Item 3.1</div>
                    </li>
                </ul>
            </li>
        </ul>

    </div>
</div>


<nav id="context-menu" class="context-menu">
    <ul class="context-menu__items">
        <li class="context-menu__item">
            <a href="#" class="context-menu__link" data-action="add"><i class="fa fa-eye"></i> Add child</a>
        </li>
        <li class="context-menu__item">
            <a href="#" class="context-menu__link" data-action="edit"><i class="fa fa-edit"></i> Edit </a>
        </li>
        <li class="context-menu__item">
            <a href="#" class="context-menu__link" data-action="delete"><i class="fa fa-times"></i> Delete</a>
        </li>
    </ul>
</nav>


</body>

</html>

<script>
    var tree = document.getElementById('tree');
    new DragZone(tree);
    new DropTarget(tree);



    var lastClickedLi = null;

    // --- обработчики ---

    document.body.onclick = function(event) {
        var target = event.target;

        if (!target.classList.contains("Content")) return;
        selectSingle(target);
        lastClickedLi = target;
    }


    function deselectAll() {
        var arraychilds = document.body.getElementsByTagName('*');
        for (var i = 0; i < arraychilds.length; i++) {
            arraychilds[i].classList.remove('selected');

        }
    }

    function selectSingle(li) {
        deselectAll();
        if (li.previousElementSibling) li.previousElementSibling.classList.add('selected');
    }


    var currentElem = null;



    function tree_toggle(event) {

        event = event || window.event
        var clickedElem = event.target || event.srcElement

        if (!hasClass(clickedElem, 'Expand')) {
            return // клик не там
        }

        // Node, на который кликнули
        selectSingle(clickedElem.nextElementSibling);
        var node = clickedElem.parentNode
        if (hasClass(node, 'ExpandLeaf')) {
            return // клик на листе
        }

        // определить новый класс для узла
        var newClass = hasClass(node, 'Expand') ? 'ExpandLoading' : 'Expand'
        // заменить текущий класс на newClass
        var re =  /(^|\s)(Expand|ExpandLoading)(\s|$)/
        node.firstElementChild.className = node.firstElementChild.className.replace("Expand", 'ExpandLoading');

        setTimeout(function() {

            var newClass = hasClass(node, 'Expand') ? 'ExpandLoading' : 'Expand'
            // заменить текущий класс на newClass
            var re =  /(^|\s)(Expand|ExpandLoading)(\s|$)/
            node.firstElementChild.className = node.firstElementChild.className.replace('ExpandLoading',"Expand");

            newClass = hasClass(node, 'ExpandOpen') ? 'ExpandClosed' : 'ExpandOpen'
            // заменить текущий класс на newClass
            re =  /(^|\s)(ExpandOpen|ExpandClosed)(\s|$)/
            node.className = node.className.replace(re, '$1'+newClass+'$3');
        }, 2000);


        //!!!!!!!!!!!!
        //tryget();
    }


    function hasClass(elem, className) {
        return new RegExp("(^|\\s)"+className+"(\\s|$)").test(elem.className)
    }




    (function() {

        "use strict";

        function clickInsideElement( e, className ) {
            var el = e.srcElement || e.target;
            var el2 = e.srcElement || e.target;
            if ( el.classList.contains(className) ) {
                return el2;
            } else {
                while ( el = el.parentNode ) {
                    console.log(el.classList);
                    if ( el.classList && el.classList.contains(className) ) {
                        return el2;
                    }
                }
            }

            return false;
        }

        function getPosition(e) {
            var posx = 0;
            var posy = 0;

            if (!e) var e = window.event;

            if (e.pageX || e.pageY) {
                posx = e.pageX;
                posy = e.pageY;
            } else if (e.clientX || e.clientY) {
                posx = e.clientX + document.body.scrollLeft + document.documentElement.scrollLeft;
                posy = e.clientY + document.body.scrollTop + document.documentElement.scrollTop;
            }

            return {
                x: posx,
                y: posy
            }
        }

        var contextMenuClassName = "context-menu";
        var contextMenuItemClassName = "context-menu__item";
        var contextMenuLinkClassName = "context-menu__link";
        var contextMenuActive = "context-menu--active";

        var taskItemClassName = "Root";
        var taskItemInContext;

        var clickCoords;
        var clickCoordsX;
        var clickCoordsY;

        var menu = document.querySelector("#context-menu");
        var menuItems = menu.querySelectorAll(".context-menu__item");
        var menuState = 0;
        var menuWidth;
        var menuHeight;
        var menuPosition;
        var menuPositionX;
        var menuPositionY;

        var windowWidth;
        var windowHeight;

        function init() {
            contextListener();
            clickListener();
            keyupListener();
            resizeListener();
        }

        function contextListener() {
            document.addEventListener( "contextmenu", function(e) {
                taskItemInContext = clickInsideElement( e, taskItemClassName );
                // console.log(taskItemInContext.getAttribute("class")+" gggg");
                selectSingle(taskItemInContext);
                if ( taskItemInContext ) {
                    e.preventDefault();
                    toggleMenuOn();
                    positionMenu(e);
                } else {
                    taskItemInContext = null;
                    toggleMenuOff();
                }
            });
        }

        function clickListener() {
            document.addEventListener( "click", function(e) {
                var clickeElIsLink = clickInsideElement( e, contextMenuLinkClassName );
                // console.log(clickeElIsLink+" ffff");

                if ( clickeElIsLink ) {
                    e.preventDefault();
                    menuItemListener( clickeElIsLink );
                } else {
                    var button = e.which || e.button;
                    if ( button === 1 ) {
                        toggleMenuOff();
                    }
                }
            });
        }

        function keyupListener() {
            window.onkeyup = function(e) {
                if ( e.keyCode === 27 ) {
                    toggleMenuOff();
                }
            }
        }

        function resizeListener() {
            window.onresize = function(e) {
                toggleMenuOff();
            };
        }

        function toggleMenuOn() {
            if ( menuState !== 1 ) {
                menuState = 1;
                menu.classList.add( contextMenuActive );
            }
        }

        function toggleMenuOff() {
            if ( menuState !== 0 ) {
                menuState = 0;
                menu.classList.remove( contextMenuActive );
            }
        }

        function positionMenu(e) {
            clickCoords = getPosition(e);
            clickCoordsX = clickCoords.x;
            clickCoordsY = clickCoords.y;

            menuWidth = menu.offsetWidth + 4;
            menuHeight = menu.offsetHeight + 4;

            windowWidth = window.innerWidth;
            windowHeight = window.innerHeight;

            if ( (windowWidth - clickCoordsX) < menuWidth ) {
                menu.style.left = windowWidth - menuWidth + "px";
            } else {
                menu.style.left = clickCoordsX + "px";
            }

            if ( (windowHeight - clickCoordsY) < menuHeight ) {
                menu.style.top = windowHeight - menuHeight + "px";
            } else {
                menu.style.top = clickCoordsY + "px";
            }
        }

        function menuItemListener( link ) {

            selectSingle(taskItemInContext);

            if (link.getAttribute("data-action")=="add")
                showPrompt("Введите имя", function(value) {
                if (value==null) return;

                if (taskItemInContext.nextElementSibling) {
                    var el = taskItemInContext.parentNode;
                    el.classList.remove("ExpandLeaf");
                    el.classList.remove("ExpandClosed");
                    el.classList.add("ExpandOpen");
                    el = taskItemInContext.nextElementSibling;
                    if (el.firstElementChild) {
                        el.lastElementChild.classList.remove("IsLast");
                    }

                    var newLi = document.createElement('li');
                    newLi.className = "Node ExpandLeaf IsLast";
                    if (taskItemInContext.classList.contains("MainNode")) newLi.className = "Node ExpandLeaf IsRoot IsLast";

                    var child = document.createElement('div');
                    child.className = "Expand";
                    newLi.appendChild(child);
                    child = document.createElement('div');
                    child.className = "Content";
                    child.innerHTML = value;
                    newLi.appendChild(child);

                    el.appendChild(newLi);
                }

                else {
                    var el = taskItemInContext.parentNode;
                    el.classList.remove("ExpandLeaf");
                    el.classList.add("ExpandOpen");

                    var newUl = document.createElement('ul');
                    newUl.className="Container";

                    newLi = document.createElement('li');
                    newLi.className = "Node ExpandLeaf IsLast";
                    if (taskItemInContext.classList.contains("MainNode")) newLi.className = "Node ExpandLeaf IsRoot IsLast";

                    var child = document.createElement('div');
                    child.className = "Expand";
                    newLi.appendChild(child);
                    child = document.createElement('div');
                    child.className = "Content";
                    child.innerHTML = value;

                    newLi.appendChild(child);
                    newUl.appendChild(newLi);
                    el.appendChild(newUl);
                }

            });
            if (link.getAttribute("data-action")=="edit"){
                showPrompt("Введите новое имя", function(value) {
                    if (value == null) return;
                    taskItemInContext.innerHTML = value;
                });
            }

            if(link.getAttribute("data-action")=="delete") {

                var el = taskItemInContext.parentNode;
                if(el.parentNode.firstElementChild==el.parentNode.lastElementChild) {
                    el.parentNode.parentNode.classList.remove("ExpandOpen");
                    el.parentNode.parentNode.classList.add("ExpandLeaf");
                }
                else {
                    if (el.parentNode.lastElementChild == el)
                        el.parentNode.children[el.parentNode.children.length-2].classList.add("IsLast");
                }
                el.remove();
            }

            toggleMenuOff();
        }

        init();

    })();




</script>



<style>


    div.Content:hover {
        font-weight: bold;
        cursor: pointer;
    }

    div.MainNode:hover {
        font-weight: bold;
        cursor: pointer;
    }

    .selected {
        background: rgba(0, 102, 170, 0.69);
    }

    .ExpandLoading   {
        width: 18px;
        height: 18px;
        float: left;
        background-image: url(img/expand_loading.gif);
    }


    .border
    {
        margin: 10px;
        border-size:1px;
        border-style:solid;
        border-color:lightgray;
    }




    .tasks {
        list-style: none;
        margin: 0;
        padding: 0;
    }

    .task {
        display: flex;
        justify-content: space-between;
        padding: 12px 0;
        border-bottom: solid 1px #dfdfdf;
    }

    .task:last-child {
        border-bottom: none;
    }

    /* context menu */

    .context-menu {
        display: none;
        position: absolute;
        z-index: 10;
        padding: 12px 0;
        width: 240px;
        background-color: #fff;
        border: solid 1px #dfdfdf;
        box-shadow: 1px 1px 2px #cfcfcf;
    }

    .context-menu--active {
        display: block;
    }

    .context-menu__items {
        list-style: none;
        margin: 0;
        padding: 0;
    }

    .context-menu__item {
        display: block;
        margin-bottom: 4px;
    }

    .context-menu__item:last-child {
        margin-bottom: 0;
    }

    .context-menu__link {
        display: block;
        padding: 4px 12px;
        color: rgb(0, 102, 170);
        text-decoration: none;
    }

    .context-menu__link:hover {
        color: #fff;
        background-color: #0066aa;
    }

    body{
        margin: 50px;
    }

</style>