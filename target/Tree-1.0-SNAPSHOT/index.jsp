<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Тестовое приложение</title>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="content-type" content="text/html;charset=UTF-8"/>

    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.0.3/jquery.min.js"></script>
    <script type="text/javascript" src="https://netdna.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.3.0/css/font-awesome.min.css"
          rel="stylesheet" type="text/css">
    <link href="https://pingendo.github.io/pingendo-bootstrap/themes/default/bootstrap.css"
          rel="stylesheet" type="text/css">

    <link href="//fonts.googleapis.com/css?family=Roboto:300,400,500,700" rel="stylesheet" type="text/css">

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>

    <link rel="stylesheet" type="text/css" href="css/main.css">

    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>

    <script src="js/script.js"></script>



</head>

<body>
<div class="section">
    <div class="task__content Root"  onclick="tree_toggle(arguments[0])">
        <div class="task__actions">
          <!--  <i class="fa fa-eye"></i>
           <i class="fa fa-edit"></i>
            <i class="fa fa-times"></i>-->
        </div>
        <div class="MainNode">Root</div>
        <ul class="Container">
            <li class="Node IsRoot ExpandClosed">
                <div class="Expand"></div>
                <!--oncontextmenu="alert('Клик!')"-->
                <div class="Content">Item 1</div>
                <ul class="Container">
                    <li class="Node ExpandClosed">
                        <div class="Expand"></div>
                        <div class="Content">Item 1.1</div>
                        <ul class="Container">
                            <li class="Node ExpandLeaf IsLast">
                                <div class="Expand"></div>
                                <div id="Item1_1_2" class="Content">Item 1.1.2</div>
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
                <ul class="Container">
                    <li class="Node ExpandLeaf IsLast">
                        <div class="Expand"></div>
                        <div onclick="tryget()" class="Content">Item 2.1</div>
                    </li>
                </ul>
            </li>
            <li class="Node ExpandOpen IsRoot IsLast">
                <div class="Expand"></div>
                <div class="Content">Item 3</div>
                <ul class="Container">
                    <li class="Node ExpandLeaf IsLast">
                        <div class="Expand"></div>
                        <div class="Content">Что ты на это скажешь</div>
                    </li>
                </ul>
            </li>
        </ul>

    </div>
</div>


 <!--   <div class="container">
        <div class="row">
            <div class="col-md-3">
                <a class="btn btn-primary" onclick="showAllNames()">Показать все имена</a>

                <div class="border">
                    <div>
                        <a class="btn btn-primary" onclick="addName()">Добавить имя</a>

                        <div class="modal-body" style="text-align: center;">
                            <input class="form-control" id="NewNameInput"
                                   placeholder="Enter some name">
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <table class="table">
                    <tbody id="table_names">
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

-->
<nav id="context-menu" class="context-menu">
    <ul class="context-menu__items">
        <li class="context-menu__item">
            <a href="#" class="context-menu__link" data-action="View"><i class="fa fa-eye"></i> View Task</a>
        </li>
        <li class="context-menu__item">
            <a href="#" class="context-menu__link" data-action="Edit"><i class="fa fa-edit"></i> Edit Task</a>
        </li>
        <li class="context-menu__item">
            <a href="#" class="context-menu__link" data-action="Delete"><i class="fa fa-times"></i> Delete Task</a>
        </li>
    </ul>
</nav>


</body>

</html>

<script>

    var lastClickedLi = null;

    // --- обработчики ---

    document.body.onclick = function(event) {
        var target = event.target;

        // возможно, клик был внутри списка UL, но вне элементов LI
        if (target.className != "Content") return;

        // для Mac проверяем Cmd, т.к. Ctrl + click там контекстное меню
        //if (event.metaKey || event.ctrlKey) {
        //    toggleSelect(target);
        //} else if (event.shiftKey) {
       //     selectFromLast(target);
       // } else {
            selectSingle(target);
        //}

        lastClickedLi = target;
    }

    document.body.onmousedown = function() {
        return false;
    };

    // --- функции для выделения ---

   /* function toggleSelect(li) {
        li.classList.toggle('selected');
    }*/

    /*function selectFromLast(target) {
        var startElem = lastClickedLi || ul.children[0];

        var isLastClickedBefore = startElem.compareDocumentPosition(target) & 4;

        if (isLastClickedBefore) {
            for (var elem = startElem; elem != target; elem = elem.nextElementSibling) {
                elem.classList.add('selected');
            }
        } else {
            for (var elem = startElem; elem != target; elem = elem.previousElementSibling) {
                elem.classList.add('selected');
            }
        }
        elem.classList.add('selected');
    }*/




    function deselectAll() {
        for (var i = 0; i < ul.children.length; i++) {
            document.body.children[i].classList.remove('selected');
        }
    }

    function selectSingle(li) {
        console.log("привки");
        deselectAll();
        li.classList.add('selected');
    }




    var currentElem = null;

    document.body.onmouseover = function(event) {
        if (currentElem) {
            return;
        }

        var target = event.target;

        //console.log(target.classList.toString());
        while (target != this) {
            if (target.classList.contains('Content')||target.classList.contains('MainNode')) break;
            target = target.parentNode;
        }
        if (target == this) return;

        currentElem = target;
        target.style.background = 'pink';
        //console.log(event.type + ': ' + 'target=' + str(event.target));
    };



    document.body.onmouseout = function(event) {
        if (!currentElem) return;

        var relatedTarget = event.relatedTarget;
        if (relatedTarget) {
            while (relatedTarget) {
                if (relatedTarget == currentElem) return;
                relatedTarget = relatedTarget.parentNode;
            }
        }

        currentElem.style.background = '';
        currentElem = null;
    };

    (function() {

        "use strict";

        function clickInsideElement( e, className ) {
            var el = e.srcElement || e.target;
            var el2 = e.srcElement || e.target;
            console.log(className+" !!!! "+el.getAttribute("class"));
            if ( el.classList.contains(className) ) {
                return el2;
            } else {
                while ( el = el.parentNode ) {
                    //console.log(className+" !!!! "+el.getAttribute("class"));
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
                console.log(clickeElIsLink+" ffff");

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
            console.log("Мы тут");

            if (taskItemInContext.nextElementSibling) {
                var el = taskItemInContext.nextElementSibling;
                var lastChild = el.lastElementChild;
                lastChild.classList.remove("IsLast");
                var newLi = document.createElement('li');
                newLi.className = "Node ExpandLeaf IsLast";
                if (taskItemInContext.classList.contains("MainNode")) newLi.className = "Node ExpandLeaf IsRoot IsLast";

                var child = document.createElement('div');
                child.className = "Expand";
                newLi.appendChild(child);
                child = document.createElement('div');
                child.className = "Content";
                child.innerHTML = "New Item";
                newLi.appendChild(child);

                el.appendChild(newLi);
            }

            else {
                var el = taskItemInContext.parentNode;
                el.classList.remove("ExpandLeaf");
                el.classList.add("ExpandOpen");
                var newUl = document.createElement('ul');
                newUl.className="Container";

                //el append <ul class="Container">
                newLi = document.createElement('li');
                newLi.className = "Node ExpandLeaf IsLast";
                if (taskItemInContext.classList.contains("MainNode")) newLi.className = "Node ExpandLeaf IsRoot IsLast";

                var child = document.createElement('div');
                child.className = "Expand";
                newLi.appendChild(child);
                child = document.createElement('div');
                child.className = "Content";
                child.innerHTML = "New Item in empty";
                newLi.appendChild(child);

                newUl.appendChild(newLi);
                el.appendChild(newUl);
            }
            //console.log(el.getAttribute("class"));
            console.log( "Task ID - " + taskItemInContext.getAttribute("class") + ", Task action - " + link.getAttribute("data-action"));
            toggleMenuOff();
        }

        init();

    })();



    function tryget() {

        var jsonData = new Object();
        jsonData.command = "2";

        var serverHostName = window.location.hostname;

        var serverProtocolName = window.location.protocol;

        var portName = window.location.port;
        serverPath = serverProtocolName + "//" + serverHostName + ":" + portName;
        console.log(serverPath);

        $.ajax({
            url: serverPath + "/",
            type: 'POST',
            data: JSON.stringify(jsonData),

            dataType: 'json',
            async: true,

            success: function (event) {
                switch (event["answer"])
                {
                    case "ok":
                        alert("success");
                        break;

                    case "children":
                        var keysList = event["list"].replace("[", ""). replace("]", "").split(",");
                        $("#Item1_1_2").after("<ul class='Container'>"+"<li class='Node ExpandLeaf IsLast'>"+
                        "<div class='Expand'></div>"+
                        "<div class='Content'>Item 1.1.2.1</div>"+
                    "</li>"+"</ul>");
                        console.log("что-то работает");
                        keysList.forEach(function(item, i, arr) {
                            console.log(item);
                       });

                        break;
                }
            },
            error: function (xhr, status, error) {
                alert(error);
                console.log("запрос не посылается");
            }
        });
    }

    function tree_toggle(event) {

        event = event || window.event
        var clickedElem = event.target || event.srcElement

        if (!hasClass(clickedElem, 'Expand')) {
            return // клик не там
        }

        // Node, на который кликнули
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
            }, 3000);


        //!!!!!!!!!!!!
        //tryget();
    }


    function hasClass(elem, className) {
        return new RegExp("(^|\\s)"+className+"(\\s|$)").test(elem.className)
    }
</script>



<style>

    .selected {
        background: #8a80ff;
    }

    .btn
    {
        margin: 10px;
    }

    .border
    {
        margin: 10px;
        border-size:1px;
        border-style:solid;
        border-color:lightgray;
    }



    .Container {
        padding: 0;
        margin: 0;
    }

    .Container li {
        list-style-type: none;
    }

    .Node {
        background-image : url(/img/i.gif);
        background-position : top left;
        background-repeat : repeat-y;
        margin-left: 18px;
        zoom: 1;
    }

    .IsRoot {
        margin-left: 0;
    }


    /* left vertical line (grid) for all nodes */
    .IsLast {
        background-image: url(img/i_half.gif);
        background-repeat : no-repeat;
    }

    .ExpandOpen .Expand {
        background-image: url(img/expand_minus.gif);
    }

    /* closed is higher priority than open */
    .ExpandClosed .Expand {
        background-image: url(img/expand_plus.gif);
    }

    /* highest priority */
    .ExpandLeaf .Expand {
        background-image: url(img/expand_leaf.gif);
    }

    .Content {
        min-height: 18px;
        margin-left:18px;
    }

    * html  .Content {
        height: 18px;
    }

    .Expand {
        width: 18px;
        height: 18px;
        float: left;
    }

    .ExpandOpen .Container {
        display: block;
    }

    .ExpandClosed .Container {
        display: none;
    }

    .ExpandOpen .Expand, .ExpandClosed .Expand {
        cursor: pointer;
    }
    .ExpandLeaf .Expand {
        cursor: auto;
    }

    .ExpandLoading   {
        width: 18px;
        height: 18px;
        float: left;
        background-image: url(img/expand_loading.gif);
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
        color: #0066aa;
        text-decoration: none;
    }

    .context-menu__link:hover {
        color: #fff;
        background-color: #0066aa;
    }


</style>