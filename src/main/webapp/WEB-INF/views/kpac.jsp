<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>K-PAC List</title>

    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/dhtmlx/grid.css">
    <script src="${pageContext.request.contextPath}/dhtmlx/grid.js"></script>


</head>
<body>

<h1>K-PAC List</h1>

<label for="filterSelect"></label>
<select id="filterSelect" name="filterSelect">
    <option value="title">Title</option>
    <option value="description">Description</option>
    <option value="creationDate">Creation Date</option>
</select>
<label for="filterInput">Filter</label>
<input id="filterInput" name="filterInput">

<button class="dhx_sample-btn dhx_sample-btn--flat" onclick="applyFilter()">Apply filter</button>

<div id="kpacGrid" style="width: 100%; height: 400px;"></div>

<form id="addKpacForm">
    <label for="title">Title:</label>
    <input type="text" id="title" name="title"><br>

    <label for="description">Description:</label>
    <textarea id="description" name="description"></textarea><br>

    <input type="submit" value="Add KPAC">
</form>

<script>

    const kpacGrid = new dhx.Grid("kpacGrid", {
        columns: [
            {id: "id", header: [{text: "ID"}]},
            {id: "title", header: [{text: "Title"}]},
            {id: "description", header: [{text: "Description"}]},
            {id: "creationDate", header: [{text: "Creation Date"}]},
            {
                id: "Delete",
                htmlEnable: true,
                header: [{text: ""}],
                align: "center",
                template: (value, row) => {
                    return "<button class='dxi dxi-delete' onclick='deleteKpac(" + row.id + ")'>Delete</button>";
                }
            }
        ],
        autoHeight: true,
        autoWidth: true,
        resizable: true,
        selection: "row",
        data: ${kpacs},
        css: "grid",
    });

    const deleteKpac = (id) => {
        if (confirm("Are you sure you want to delete this K-PAC?")) {
            const xhttp = new XMLHttpRequest();
            xhttp.onreadystatechange = function () {
                if (this.readyState === 4 && this.status === 200) {
                    kpacGrid.data.remove(id);
                }
            };
            xhttp.open("DELETE", "${pageContext.request.contextPath}/kpac/" + id, true);
            xhttp.send();
        }
    }

    const applyFilter = () => {
        kpacGrid.data.filter(
            {
                by: document.getElementById("filterSelect").value,
                match: document.getElementById("filterInput").value,
                compare: (value, match) => value.toString().toLowerCase().indexOf(match.toLowerCase()) !== -1,
            });
    }

    document.getElementById("addKpacForm").addEventListener("submit", function (event) {
        event.preventDefault();

        const formData = new FormData(event.target);
        const kpac = {};
        for (let pair of formData.entries()) {
            kpac[pair[0]] = pair[1];
        }

        const xhttp = new XMLHttpRequest();
        xhttp.onreadystatechange = function () {
            if (this.readyState === 4 && this.status === 200) {
                kpacGrid.data.add(JSON.parse(this.response));
            } else if (this.readyState === 4) {
                console.error("Error adding KPAC");
            }
        };
        xhttp.open("POST", "${pageContext.request.contextPath}/kpac", true);
        xhttp.setRequestHeader("Content-Type", "application/json");
        xhttp.send(JSON.stringify(kpac));
    });
</script>
</body>
</html>
