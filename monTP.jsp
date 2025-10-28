<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Mon TP made by Christophe MURA</title>
    <style>
        table {
            border-collapse: collapse;
            width: 80%;
            margin-top: 20px;
        }
        th, td {
            border: 1px solid #333;
            padding: 8px;
            text-align: center;
        }
        th {
            background-color: #f2f2f2;
        }
    </style>
    <script>
        function toggleTable() {
            const table = document.getElementById("maTable");
            const btn = document.getElementById("toggleBtn");
            if (table.style.display === "none") {
                table.style.display = "table";
                btn.textContent = "Cacher le tableau";
            } else {
                table.style.display = "none";
                btn.textContent = "Afficher le tableau";
            }
        }
    </script>
</head>
<body bgcolor="white">
    <h1>To do list du futur</h1>

    <!-- Formulaire pour ajouter une tâche -->
    <form action="monTP.jsp" method="post">
        <p>Veuillez entrer une tâche à effectuer : 
            <input type="text" id="inputValeur" name="tache">
        </p>
        <p><input type="submit" value="Ajouter"></p>
    </form>

    <!-- Bouton pour afficher/cacher le tableau -->
    <button id="toggleBtn" type="button" onclick="toggleTable()">Afficher le tableau</button>

    <!-- Tableau initialement caché -->
    <table id="maTable" style="display:none">
        <tr>
            <th>Colonne 1</th>
            <th>Colonne 2</th>
            <th>Colonne 3</th>
            <th>Colonne 4</th>
            <th>Colonne 5</th>
        </tr>
        <%
            // Exemple d'utilisation côté serveur : afficher des lignes dynamiquement
            String tache = request.getParameter("tache");
            if (tache != null && !tache.isEmpty()) {
        %>
        <tr>
            <td><%= tache %></td>
            <td>Valeur 2</td>
            <td>Valeur 3</td>
            <td>Valeur 4</td>
            <td>Valeur 5</td>
        </tr>
        <% } %>
    </table>
</body>
</html>
