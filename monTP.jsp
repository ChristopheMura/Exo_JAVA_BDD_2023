<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Mon TP made by Christophe MURA</title>
    <style>
        table {
            border-collapse: collapse;
            width: 70%;
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
        input[type=text] {
            width: 300px;
        }
    </style>
</head>
<body bgcolor="white">
<h1>To do list du futur</h1>

<%! 
// Classe simple pour représenter une tâche avec titre et description
public class Tache {
    private String titre;
    private String description;

    public Tache(String titre, String description) {
        this.titre = titre;
        this.description = description;
    }

    public String getTitre() {
        return titre;
    }

    public String getDescription() {
        return description;
    }
}
%>

<%
    // Récupérer la liste des tâches depuis la session
    List<Tache> listeTaches = (List<Tache>) session.getAttribute("listeTaches");
    if (listeTaches == null) {
        listeTaches = new ArrayList<>();
        session.setAttribute("listeTaches", listeTaches);
    }

    // Récupérer les données du formulaire
    String titre = request.getParameter("titre");
    String description = request.getParameter("description");
    if (titre != null && !titre.trim().isEmpty() && description != null) {
        listeTaches.add(new Tache(titre.trim(), description.trim()));
    }
%>

<!-- Formulaire pour ajouter une tâche -->
<form action="monTP.jsp" method="post">
    <p>
        Titre de la tâche : 
        <input type="text" name="titre" required>
    </p>
    <p>
        Description de la tâche : 
        <input type="text" name="description">
    </p>
    <p><input type="submit" value="Ajouter"></p>
</form>

<!-- Tableau affichant toutes les tâches -->
<table id="maTable">
    <tr>
        <th>Titre</th>
        <th>Description</th>
    </tr>
    <%
        for(Tache t : listeTaches){
    %>
    <tr>
        <td><%= t.getTitre() %></td>
        <td><%= t.getDescription() %></td>
    </tr>
    <% } %>
</table>

</body>
</html>
