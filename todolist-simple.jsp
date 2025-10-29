<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Ma TodoList - Christophe MURA</title>
<style>
    body {
        font-family: Arial, sans-serif;
        max-width: 700px;
        margin: 50px auto;
        padding: 20px;
        background-color: #f5f5f5;
    }
    
    h1 {
        color: #333;
        text-align: center;
    }
    
    .form-box {
        background: white;
        padding: 20px;
        border-radius: 8px;
        margin-bottom: 20px;
        box-shadow: 0 2px 4px rgba(0,0,0,0.1);
    }
    
    input[type="text"], textarea {
        width: 100%;
        padding: 10px;
        margin-bottom: 10px;
        border: 1px solid #ddd;
        border-radius: 4px;
        box-sizing: border-box;
    }
    
    textarea {
        min-height: 60px;
        resize: vertical;
    }
    
    button, input[type="submit"] {
        background-color: #4CAF50;
        color: white;
        padding: 10px 20px;
        border: none;
        border-radius: 4px;
        cursor: pointer;
        font-size: 14px;
    }
    
    button:hover, input[type="submit"]:hover {
        background-color: #45a049;
    }
    
    .task {
        background: white;
        padding: 15px;
        margin-bottom: 10px;
        border-radius: 4px;
        box-shadow: 0 1px 3px rgba(0,0,0,0.1);
        display: flex;
        justify-content: space-between;
        align-items: center;
    }
    
    .task.completed {
        background-color: #f0f0f0;
        opacity: 0.7;
    }
    
    .task-content {
        flex: 1;
    }
    
    .task-title {
        font-weight: bold;
        margin-bottom: 5px;
    }
    
    .task.completed .task-title {
        text-decoration: line-through;
        color: #999;
    }
    
    .task-description {
        color: #666;
        font-size: 14px;
    }
    
    .task-actions {
        display: flex;
        gap: 5px;
    }
    
    .btn-small {
        padding: 5px 10px;
        font-size: 12px;
    }
    
    .btn-delete {
        background-color: #f44336;
    }
    
    .btn-delete:hover {
        background-color: #da190b;
    }
    
    .stats {
        text-align: center;
        margin-bottom: 20px;
        color: #666;
    }
    
    .empty-message {
        text-align: center;
        padding: 40px;
        color: #999;
    }
</style>
</head>
<body>

<%! 
// Classe Tâche
public class Tache {
    private String id;
    private String titre;
    private String description;
    private boolean complete;
    
    public Tache(String titre, String description) {
        this.id = UUID.randomUUID().toString();
        this.titre = titre;
        this.description = description;
        this.complete = false;
    }
    
    public String getId() { return id; }
    public String getTitre() { return titre; }
    public String getDescription() { return description; }
    public boolean isComplete() { return complete; }
    public void setComplete(boolean complete) { this.complete = complete; }
}
%>

<%
    // Gestion de la liste des tâches
    List<Tache> listeTaches = (List<Tache>) session.getAttribute("listeTaches");
    if (listeTaches == null) {
        listeTaches = new ArrayList<>();
        session.setAttribute("listeTaches", listeTaches);
    }
    
    // Gestion des actions
    String action = request.getParameter("action");
    
    if ("ajouter".equals(action)) {
        String titre = request.getParameter("titre");
        String description = request.getParameter("description");
        if (titre != null && !titre.trim().isEmpty()) {
            if (description == null) description = "";
            listeTaches.add(new Tache(titre.trim(), description.trim()));
        }
    }
    else if ("supprimer".equals(action)) {
        String id = request.getParameter("id");
        listeTaches.removeIf(t -> t.getId().equals(id));
    }
    else if ("toggle".equals(action)) {
        String id = request.getParameter("id");
        for (Tache t : listeTaches) {
            if (t.getId().equals(id)) {
                t.setComplete(!t.isComplete());
                break;
            }
        }
    }
    else if ("toutSupprimer".equals(action)) {
        listeTaches.clear();
    }
    
    // Statistiques
    int total = listeTaches.size();
    int completes = 0;
    for (Tache t : listeTaches) {
        if (t.isComplete()) completes++;
    }
%>

<h1>📋 Ma TodoList</h1>

<div class="stats">
    <%= total %> tâche(s) - <%= completes %> terminée(s) - <%= total - completes %> en cours
</div>

<!-- Formulaire d'ajout -->
<div class="form-box">
    <form action="todolist-simple.jsp" method="post">
        <input type="hidden" name="action" value="ajouter">
        <input type="text" name="titre" placeholder="Titre de la tâche..." required>
        <textarea name="description" placeholder="Description (optionnelle)"></textarea>
        <input type="submit" value="Ajouter">
    </form>
</div>

<!-- Bouton tout supprimer -->
<% if (total > 0) { %>
    <div style="text-align: right; margin-bottom: 10px;">
        <form action="todolist-simple.jsp" method="post" style="display: inline;" 
              onsubmit="return confirm('Supprimer toutes les tâches ?');">
            <input type="hidden" name="action" value="toutSupprimer">
            <button type="submit" class="btn-small btn-delete">🗑️ Tout supprimer</button>
        </form>
    </div>
<% } %>

<!-- Liste des tâches -->
<% if (listeTaches.isEmpty()) { %>
    <div class="empty-message">
        <p>Aucune tâche pour le moment</p>
        <p>Ajoutez-en une ci-dessus ! 👆</p>
    </div>
<% } else { 
    for (Tache t : listeTaches) { 
%>
    <div class="task <%= t.isComplete() ? "completed" : "" %>">
        <div class="task-content">
            <div class="task-title">
                <%= t.isComplete() ? "✓ " : "" %><%= t.getTitre() %>
            </div>
            <% if (!t.getDescription().isEmpty()) { %>
                <div class="task-description"><%= t.getDescription() %></div>
            <% } %>
        </div>
        <div class="task-actions">
            <form action="todolist-simple.jsp" method="post" style="display: inline;">
                <input type="hidden" name="action" value="toggle">
                <input type="hidden" name="id" value="<%= t.getId() %>">
                <button type="submit" class="btn-small">
                    <%= t.isComplete() ? "↩️" : "✓" %>
                </button>
            </form>
            <form action="todolist-simple.jsp" method="post" style="display: inline;" 
                  onsubmit="return confirm('Supprimer cette tâche ?');">
                <input type="hidden" name="action" value="supprimer">
                <input type="hidden" name="id" value="<%= t.getId() %>">
                <button type="submit" class="btn-small btn-delete">🗑️</button>
            </form>
        </div>
    </div>
<% } 
} %>

</body>
</html>
