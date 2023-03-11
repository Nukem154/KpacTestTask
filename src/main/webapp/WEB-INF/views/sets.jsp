<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Set List</title>

    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/dhtmlx/grid.css">
    <script src="${pageContext.request.contextPath}/dhtmlx/grid.js"></script>


</head>
<body>

<h1>Set List</h1>

<label for="filterSelect"></label>
<select id="filterSelect" name="filterSelect">
    <option value="title">Title</option>
</select>
<label for="filterInput">Filter</label>
<input id="filterInput" name="filterInput">

<button class="dhx_sample-btn dhx_sample-btn--flat" onclick="applyFilter()">Apply filter</button>

<div id="setGrid" style="width: 100%; height: 400px;"></div>

<form id="addSetForm">
    <label for="title">Title:</label>
    <input type="text" id="title" name="title"><br>

    <input type="submit" value="Add Set">
</form>

<script>
    const setGrid = new dhx.Grid("setGrid", {
        columns: [
            {id: "id", header: [{text: "ID"}]},
            {id: "title", header: [{text: "Title"}]},
            {
                id: "Delete",
                htmlEnable: true,
                header: [{text: ""}],
                align: "center",
                template: function (value, row) {
                    return "<button class='dxi dxi-delete' onclick='deleteSet(" + row.id + ")'>Delete</button>";
                }
            }
        ],
        autoHeight: true,
        autoWidth: true,
        selection: "row",
        data: ${sets},
        css: "grid",
    });

    setGrid.events.on("cellDblClick", (row) => {
        console.log("Row double-clicked: " + row.id);
        window.location.href = "${pageContext.request.contextPath}/set/" + row.id;
    });

    const deleteSet = (id) => {
        if (confirm("Are you sure you want to delete this set?")) {
            const xhttp = new XMLHttpRequest();
            xhttp.onreadystatechange = function () {
                if (this.readyState === 4 && this.status === 200) {
                    setGrid.data.remove(id);
                }
            };
            xhttp.open("DELETE", "${pageContext.request.contextPath}/sets/" + id, true);
            xhttp.send();
        }
    }

    document.getElementById("addSetForm").addEventListener("submit", function (event) {
        event.preventDefault();

        const formData = new FormData(event.target);

        const xhttp = new XMLHttpRequest();
        xhttp.onreadystatechange = function () {
            if (this.readyState === 4 && this.status === 200) {
                setGrid.data.add(JSON.parse(this.response));
            } else if (this.readyState === 4) {
                console.error("Error adding Set");
            }
        };
        xhttp.open("POST", "${pageContext.request.contextPath}/sets", true);
        xhttp.setRequestHeader("Content-Type", "application/json");
        xhttp.send(JSON.stringify({title: formData.get("title")}));
    });

    const applyFilter = () => {
        setGrid.data.filter(
            {
                by: document.getElementById("filterSelect").value,
                match: document.getElementById("filterInput").value,
                compare: (value, match) => value.toString().toLowerCase().indexOf(match.toLowerCase()) !== -1,
            });
    }

</script>
</body>
</html>
