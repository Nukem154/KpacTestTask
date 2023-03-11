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

<h1>K-PACs attached to Set</h1>

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

<script>

    const kpacGrid = new dhx.Grid("kpacGrid", {
        columns: [
            {id: "id", width: 100, header: [{text: "ID"}]},
            {id: "title", width: 200, header: [{text: "Title"}]},
            {id: "description", width: 400, header: [{text: "Description"}]},
            {id: "creationDate", width: 150, header: [{text: "Creation Date", align: "center"}]},
        ],
        autoHeight: true,
        autoWidth: true,
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

</script>
</body>
</html>
