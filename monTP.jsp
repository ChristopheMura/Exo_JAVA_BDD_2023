<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.example.GestionnaireTache" %>
<%@ page import="java.util.List" %>
<%
    // Créer ou récupérer le gestionnaire de tâches depuis la session
    GestionnaireTache gestionnaire = (GestionnaireTache) session.getAttribute("gestionnaire");
    if (gestionnaire == null) {
        gestionnaire = new GestionnaireTache();
        session.setAttribute("gestionnaire", gestionnaire);
    }

    // Récupérer la tâche soumise
    String nouvelleTache = request.getParameter("chaine");
    if (nouvelleTache != null && !nouvelleTache.isEmpty()) {
        gestionnaire.ajouterTache(nouvelleTache);
    }

    List<String> listeTaches = gestionnaire.getTaches();
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Mon TP made by Christophe MURA</title>
    <style>
        table { border-collapse: collapse; width: 60%; margin-top: 20px; }
        th, td { border: 1px solid #333; padding: 8px; text-align: center; }
        th { background-color: #f2f2f2; }
    </style>
</head>
<body bgcolor="white">
    <h1>To do list du futur</h1>

    <form action="monTP.jsp" method="post">
        <p>Veuillez entrer une tâche à effectuer : 
            <input type="text" id="inputValeur" name="chaine">
        </p>
        <p><input type="submit" value="Ajouter"></p>
    </form>

    <!-- Tableau des tâches -->
    <table>
        <tr>
            <th>#</th>
            <th>Tâche</th>
        </tr>
        <%
            int compteur = 1;
            for (String tache : listeTaches) {
        %>
        <tr>
            <td><%= compteur++ %></td>
            <td><%= tache %></td>
        </tr>
        <% } %>
    </table>
</body>
</html>
