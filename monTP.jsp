<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>TodoList Pro - by Christophe MURA</title>
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
public class Tache
{
    private String id;
    private String titre;
    private String description;
    private String priorite;
    private boolean complete;
    private Date dateCreation;

    public Tache(String titre, String description, String priorite)
    {
        this.id = UUID.randomUUID().toString();
        this.titre = titre;
        this.description = description;
        this.priorite = priorite;
        this.complete = false;
        this.dateCreation = new Date();
    }

    public String getId() { return id; }
    public String getTitre() { return titre; }
    public String getDescription() { return description; }
    public String getPriorite() { return priorite; }
    public boolean isComplete() { return complete; }
    public Date getDateCreation() { return dateCreation; }

    public void setComplete(boolean pComplete)
    {
        this.complete = pComplete;
    }

    public String getDateCreationFormate()
    {
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("dd/MM/yyy HH:mm");
        return simpleDateFormat.format(dateCreation);
    }
}
%>

<%
    // Récupérer la liste des tâches depuis la session
    List<Tache> listeTaches = (List<Tache>) session.getAttribute("listeTaches");
    // Est ce que c'est la premiere fois que je visite le site web ?
    if (listeTaches == null)
    {
        listeTaches = new ArrayList<>(); // On crée une nouvelle liste vide
        // On stocke cette liste dans la session pour la retrouver plus tard
        session.setAttribute("listeTaches", listeTaches);
    }

    // Gestion des actions
    String action = request.getParameter("action");

    // Ajouter une tâche
    if ("ajouter".equals(action))
    {
        String titre = request.getParameter("titre");
        String description = request.getParameter("description");
        String priorite = request.getParameter("priorite");

        if (titre != null && !titre.trim().isEmpty())
        {
            if (description == null)
            {
                description = "";
            }
            if (priorite == null)
            {
                priorite = "moyenne";
            }
            listeTaches.add(new Tache(titre.trim(), description.trim(), priorite));
        }
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
