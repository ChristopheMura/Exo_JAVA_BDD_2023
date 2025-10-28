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
            width: 50%;
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
</head>
<body bgcolor="white">
<h1>To do list du futur</h1>

<%! 
// Classe simple pour représenter une tâche
public class Tache {
    private String nom;

    public Tache(String nom) {
        this.nom = nom;
    }

    public String getNom() {
        return nom;
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

    // Récupérer la nouvelle tâche depuis le formulaire
    String nouvelleTache = request.getParameter("tache");
    if (nouvelleTache != null && !nouvelleTache.trim().isEmpty()) {
        listeTaches.add(new Tache(nouvelleTache.trim()));
    }
%>

<!-- Formulaire pour ajouter une tâche -->
<form action="monTP.jsp" method="post">
    <p>Veuillez entrer une tâche à effectuer : 
        <input type="text" id="inputValeur" name="tache" required>
    </p>
    <p><input type="submit" value="Ajouter"></p>
</form>

<!-- Tableau toujours visible -->
<table id="maTable">
    <tr>
        <th>Tâches à faire</th>
    </tr>
    <%
        for(Tache t : listeTaches){
    %>
    <tr>
        <td><%= t.getNom() %></td>
    </tr>
    <% } %>
</table>

</body>
</html>
