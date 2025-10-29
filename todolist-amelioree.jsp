<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>TodoList Pro - by Christophe MURA</title>
<style>
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
    }
    
    body {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        min-height: 100vh;
        padding: 20px;
    }
    
    .container {
        max-width: 900px;
        margin: 0 auto;
        background: white;
        border-radius: 15px;
        box-shadow: 0 10px 40px rgba(0,0,0,0.2);
        padding: 30px;
    }
    
    h1 {
        color: #667eea;
        text-align: center;
        margin-bottom: 10px;
        font-size: 2.5em;
    }
    
    .subtitle {
        text-align: center;
        color: #666;
        margin-bottom: 30px;
        font-size: 0.9em;
    }
    
    .stats {
        display: flex;
        justify-content: space-around;
        margin-bottom: 30px;
        flex-wrap: wrap;
        gap: 10px;
    }
    
    .stat-box {
        background: #f8f9fa;
        padding: 15px 25px;
        border-radius: 10px;
        text-align: center;
        flex: 1;
        min-width: 150px;
    }
    
    .stat-number {
        font-size: 2em;
        font-weight: bold;
        color: #667eea;
    }
    
    .stat-label {
        color: #666;
        font-size: 0.9em;
    }
    
    .form-container {
        background: #f8f9fa;
        padding: 25px;
        border-radius: 10px;
        margin-bottom: 30px;
    }
    
    .form-group {
        margin-bottom: 15px;
    }
    
    label {
        display: block;
        margin-bottom: 5px;
        color: #333;
        font-weight: 600;
    }
    
    input[type="text"],
    textarea,
    select {
        width: 100%;
        padding: 12px;
        border: 2px solid #ddd;
        border-radius: 8px;
        font-size: 14px;
        transition: border-color 0.3s;
    }
    
    input[type="text"]:focus,
    textarea:focus,
    select:focus {
        outline: none;
        border-color: #667eea;
    }
    
    textarea {
        resize: vertical;
        min-height: 60px;
        font-family: inherit;
    }
    
    .btn {
        background: #667eea;
        color: white;
        padding: 12px 30px;
        border: none;
        border-radius: 8px;
        cursor: pointer;
        font-size: 16px;
        font-weight: 600;
        transition: background 0.3s, transform 0.1s;
        width: 100%;
    }
    
    .btn:hover {
        background: #5568d3;
        transform: translateY(-2px);
    }
    
    .btn:active {
        transform: translateY(0);
    }
    
    .tasks-container {
        margin-top: 20px;
    }
    
    .filter-buttons {
        display: flex;
        gap: 10px;
        margin-bottom: 20px;
        flex-wrap: wrap;
    }
    
    .filter-btn {
        padding: 8px 20px;
        border: 2px solid #667eea;
        background: white;
        color: #667eea;
        border-radius: 20px;
        cursor: pointer;
        font-weight: 600;
        transition: all 0.3s;
    }
    
    .filter-btn:hover,
    .filter-btn.active {
        background: #667eea;
        color: white;
    }
    
    .task-card {
        background: white;
        border: 2px solid #e0e0e0;
        border-radius: 10px;
        padding: 20px;
        margin-bottom: 15px;
        transition: all 0.3s;
        position: relative;
    }
    
    .task-card:hover {
        box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        transform: translateY(-2px);
    }
    
    .task-card.completed {
        opacity: 0.7;
        border-color: #4caf50;
        background: #f1f8f4;
    }
    
    .task-card.priority-haute {
        border-left: 5px solid #f44336;
    }
    
    .task-card.priority-moyenne {
        border-left: 5px solid #ff9800;
    }
    
    .task-card.priority-basse {
        border-left: 5px solid #2196f3;
    }
    
    .task-header {
        display: flex;
        justify-content: space-between;
        align-items: flex-start;
        margin-bottom: 10px;
        flex-wrap: wrap;
        gap: 10px;
    }
    
    .task-title {
        font-size: 1.3em;
        font-weight: 600;
        color: #333;
        flex: 1;
    }
    
    .task-card.completed .task-title {
        text-decoration: line-through;
        color: #999;
    }
    
    .task-priority {
        padding: 4px 12px;
        border-radius: 12px;
        font-size: 0.8em;
        font-weight: 600;
        text-transform: uppercase;
    }
    
    .priority-haute {
        background: #ffebee;
        color: #c62828;
    }
    
    .priority-moyenne {
        background: #fff3e0;
        color: #e65100;
    }
    
    .priority-basse {
        background: #e3f2fd;
        color: #1565c0;
    }
    
    .task-description {
        color: #666;
        margin-bottom: 15px;
        line-height: 1.5;
    }
    
    .task-footer {
        display: flex;
        justify-content: space-between;
        align-items: center;
        flex-wrap: wrap;
        gap: 10px;
    }
    
    .task-date {
        font-size: 0.85em;
        color: #999;
    }
    
    .task-actions {
        display: flex;
        gap: 10px;
    }
    
    .action-btn {
        padding: 8px 15px;
        border: none;
        border-radius: 6px;
        cursor: pointer;
        font-size: 14px;
        font-weight: 600;
        transition: all 0.3s;
    }
    
    .btn-complete {
        background: #4caf50;
        color: white;
    }
    
    .btn-complete:hover {
        background: #45a049;
    }
    
    .btn-uncomplete {
        background: #ff9800;
        color: white;
    }
    
    .btn-uncomplete:hover {
        background: #e68900;
    }
    
    .btn-delete {
        background: #f44336;
        color: white;
    }
    
    .btn-delete:hover {
        background: #da190b;
    }
    
    .empty-state {
        text-align: center;
        padding: 60px 20px;
        color: #999;
    }
    
    .empty-state-icon {
        font-size: 4em;
        margin-bottom: 20px;
    }
    
    .clear-all {
        background: #f44336;
        color: white;
        padding: 10px 20px;
        border: none;
        border-radius: 8px;
        cursor: pointer;
        font-weight: 600;
        margin-bottom: 20px;
        transition: background 0.3s;
    }
    
    .clear-all:hover {
        background: #da190b;
    }
    
    @media (max-width: 768px) {
        .container {
            padding: 20px;
        }
        
        h1 {
            font-size: 2em;
        }
        
        .task-header,
        .task-footer {
            flex-direction: column;
            align-items: flex-start;
        }
        
        .task-actions {
            width: 100%;
            justify-content: flex-end;
        }
    }
</style>
</head>
<body>
<%! 
// Classe pour représenter une tâche
public class Tache {
    private String id;
    private String titre;
    private String description;
    private String priorite;
    private boolean complete;
    private Date dateCreation;
    
    public Tache(String titre, String description, String priorite) {
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
    public void setComplete(boolean complete) { this.complete = complete; }
    
    public String getDateCreationFormatee() {
        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm");
        return sdf.format(dateCreation);
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
    
    // Gestion des actions
    String action = request.getParameter("action");
    
    // Ajouter une tâche
    if ("ajouter".equals(action)) {
        String titre = request.getParameter("titre");
        String description = request.getParameter("description");
        String priorite = request.getParameter("priorite");
        
        if (titre != null && !titre.trim().isEmpty()) {
            if (description == null) description = "";
            if (priorite == null) priorite = "moyenne";
            listeTaches.add(new Tache(titre.trim(), description.trim(), priorite));
        }
    }
    
    // Supprimer une tâche
    else if ("supprimer".equals(action)) {
        String id = request.getParameter("id");
        listeTaches.removeIf(t -> t.getId().equals(id));
    }
    
    // Marquer comme complétée/non complétée
    else if ("toggle".equals(action)) {
        String id = request.getParameter("id");
        for (Tache t : listeTaches) {
            if (t.getId().equals(id)) {
                t.setComplete(!t.isComplete());
                break;
            }
        }
    }
    
    // Tout supprimer
    else if ("toutSupprimer".equals(action)) {
        listeTaches.clear();
    }
    
    // Calculer les statistiques
    int totalTaches = listeTaches.size();
    int tachesCompletes = 0;
    int tachesEnCours = 0;
    
    for (Tache t : listeTaches) {
        if (t.isComplete()) {
            tachesCompletes++;
        } else {
            tachesEnCours++;
        }
    }
%>

<div class="container">
    <h1>📝 TodoList Pro</h1>
    <p class="subtitle">Gérez vos tâches efficacement - by Christophe MURA</p>
    
    <!-- Statistiques -->
    <div class="stats">
        <div class="stat-box">
            <div class="stat-number"><%= totalTaches %></div>
            <div class="stat-label">Total</div>
        </div>
        <div class="stat-box">
            <div class="stat-number"><%= tachesEnCours %></div>
            <div class="stat-label">En cours</div>
        </div>
        <div class="stat-box">
            <div class="stat-number"><%= tachesCompletes %></div>
            <div class="stat-label">Terminées</div>
        </div>
    </div>
    
    <!-- Formulaire d'ajout -->
    <div class="form-container">
        <h2 style="margin-bottom: 20px; color: #333;">➕ Ajouter une nouvelle tâche</h2>
        <form action="todolist-amelioree.jsp" method="post" onsubmit="return validerFormulaire()">
            <input type="hidden" name="action" value="ajouter">
            
            <div class="form-group">
                <label for="titre">Titre de la tâche *</label>
                <input type="text" id="titre" name="titre" placeholder="Ex: Finir le projet JSP" required>
            </div>
            
            <div class="form-group">
                <label for="description">Description</label>
                <textarea id="description" name="description" placeholder="Détails de la tâche..."></textarea>
            </div>
            
            <div class="form-group">
                <label for="priorite">Priorité</label>
                <select id="priorite" name="priorite">
                    <option value="basse">🟢 Basse</option>
                    <option value="moyenne" selected>🟡 Moyenne</option>
                    <option value="haute">🔴 Haute</option>
                </select>
            </div>
            
            <button type="submit" class="btn">Ajouter la tâche</button>
        </form>
    </div>
    
    <!-- Liste des tâches -->
    <div class="tasks-container">
        <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; flex-wrap: wrap; gap: 10px;">
            <h2 style="color: #333;">Mes tâches</h2>
            <% if (totalTaches > 0) { %>
                <form action="todolist-amelioree.jsp" method="post" style="display: inline;" onsubmit="return confirm('Êtes-vous sûr de vouloir supprimer toutes les tâches ?');">
                    <input type="hidden" name="action" value="toutSupprimer">
                    <button type="submit" class="clear-all">🗑️ Tout supprimer</button>
                </form>
            <% } %>
        </div>
        
        <div class="filter-buttons">
            <button class="filter-btn active" onclick="filtrerTaches('toutes')">Toutes (<%= totalTaches %>)</button>
            <button class="filter-btn" onclick="filtrerTaches('encours')">En cours (<%= tachesEnCours %>)</button>
            <button class="filter-btn" onclick="filtrerTaches('completes')">Terminées (<%= tachesCompletes %>)</button>
        </div>
        
        <% if (listeTaches.isEmpty()) { %>
            <div class="empty-state">
                <div class="empty-state-icon">📭</div>
                <h3>Aucune tâche pour le moment</h3>
                <p>Ajoutez votre première tâche ci-dessus !</p>
            </div>
        <% } else { %>
            <% 
            // Trier par priorité et statut
            List<Tache> tachesTrie = new ArrayList<>(listeTaches);
            Collections.sort(tachesTrie, new Comparator<Tache>() {
                public int compare(Tache t1, Tache t2) {
                    if (t1.isComplete() != t2.isComplete()) {
                        return t1.isComplete() ? 1 : -1;
                    }
                    Map<String, Integer> prioriteOrdre = new HashMap<>();
                    prioriteOrdre.put("haute", 1);
                    prioriteOrdre.put("moyenne", 2);
                    prioriteOrdre.put("basse", 3);
                    return prioriteOrdre.get(t1.getPriorite()).compareTo(prioriteOrdre.get(t2.getPriorite()));
                }
            });
            
            for (Tache t : tachesTrie) { 
                String statut = t.isComplete() ? "completed" : "encours";
            %>
                <div class="task-card <%= t.isComplete() ? "completed" : "" %> priority-<%= t.getPriorite() %>" data-statut="<%= statut %>">
                    <div class="task-header">
                        <div class="task-title">
                            <%= t.isComplete() ? "✓ " : "" %><%= escapeHtml(t.getTitre()) %>
                        </div>
                        <span class="task-priority priority-<%= t.getPriorite() %>">
                            <%= t.getPriorite().toUpperCase() %>
                        </span>
                    </div>
                    
                    <% if (!t.getDescription().isEmpty()) { %>
                        <div class="task-description">
                            <%= escapeHtml(t.getDescription()) %>
                        </div>
                    <% } %>
                    
                    <div class="task-footer">
                        <div class="task-date">
                            📅 Créée le <%= t.getDateCreationFormatee() %>
                        </div>
                        <div class="task-actions">
                            <form action="todolist-amelioree.jsp" method="post" style="display: inline;">
                                <input type="hidden" name="action" value="toggle">
                                <input type="hidden" name="id" value="<%= t.getId() %>">
                                <button type="submit" class="action-btn <%= t.isComplete() ? "btn-uncomplete" : "btn-complete" %>">
                                    <%= t.isComplete() ? "↩️ Réactiver" : "✓ Terminer" %>
                                </button>
                            </form>
                            <form action="todolist-amelioree.jsp" method="post" style="display: inline;" onsubmit="return confirm('Supprimer cette tâche ?');">
                                <input type="hidden" name="action" value="supprimer">
                                <input type="hidden" name="id" value="<%= t.getId() %>">
                                <button type="submit" class="action-btn btn-delete">🗑️ Supprimer</button>
                            </form>
                        </div>
                    </div>
                </div>
            <% } %>
        <% } %>
    </div>
</div>

<script>
function validerFormulaire() {
    const titre = document.getElementById('titre').value.trim();
    if (titre === '') {
        alert('Le titre est obligatoire !');
        return false;
    }
    return true;
}

function filtrerTaches(filtre) {
    const taches = document.querySelectorAll('.task-card');
    const boutons = document.querySelectorAll('.filter-btn');
    
    // Mettre à jour les boutons actifs
    boutons.forEach(btn => btn.classList.remove('active'));
    event.target.classList.add('active');
    
    // Filtrer les tâches
    taches.forEach(tache => {
        if (filtre === 'toutes') {
            tache.style.display = 'block';
        } else if (filtre === 'encours') {
            tache.style.display = tache.dataset.statut === 'encours' ? 'block' : 'none';
        } else if (filtre === 'completes') {
            tache.style.display = tache.dataset.statut === 'completed' ? 'block' : 'none';
        }
    });
}
</script>

<%!
// Méthode pour échapper le HTML et prévenir les attaques XSS
private String escapeHtml(String text) {
    if (text == null) return "";
    return text.replace("&", "&amp;")
               .replace("<", "&lt;")
               .replace(">", "&gt;")
               .replace("\"", "&quot;")
               .replace("'", "&#x27;");
}
%>

</body>
</html>
