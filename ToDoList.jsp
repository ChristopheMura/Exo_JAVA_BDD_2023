<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>TodoList Pro - by Christophe MURA</title>
    <style>
        /* --- STYLES CSS --- */

        /* Style du corps de la page */
        body {
            font-family: Arial, sans-serif;
            max-width: 700px;
            margin: 50px auto;
            padding: 20px;
            background-color: #f5f5f5;
        }

        /* Titre principal */
        h1 {
            color: #333;
            text-align: center;
        }

        /* Boite du formulaire */
        .form-box {
            background: white;
            padding: 20px;
            border-radius: 8px;
            margin-bottom: 20px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        /* Champs de saisie texte et textarea */
        input[type="text"], textarea {
            width: 100%;
            padding: 10px;
            margin-bottom: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
        }

        /* Zone de texte multi-lignes */
        textarea {
            min-height: 60px;
            resize: vertical;
        }

        /* Tous les boutons et bouton submit */
        button, input[type="submit"] {
            background-color: #4CAF50;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
        }
        
        /* Bouton au survol de la souris */
        button:hover, input[type="submit"]:hover {
            background-color: #45a049;
        }
        
        /* Carte d'une tâche */
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
        
        /* Style pour une tâche complétée */
        .task.completed {
            background-color: #f0f0f0;
            opacity: 0.7;
        }

        /* Contenu de la tâche (titre + description) */
        .task-content {
            flex: 1;
        }

        /* Titre de la tâche */
        .task-title {
            font-weight: bold;
            margin-bottom: 5px;
        }
        
        /* Titre d'une tâche complétée */
        .task.completed .task-title {
            text-decoration: line-through;
            color: #999;
        }
        
        /* Description de la tâche */
        .task-description {
            color: #666;
            font-size: 14px;
        }

        /* Conteneur des boutons d'action */
        .task-actions {
            display: flex;
            gap: 5px;
        }
        
        /* Petits boutons (✓ et 🗑️) */
        .btn-small {
            padding: 5px 10px;
            font-size: 12px;
        }
        
        /* Bouton de suppression */
        .btn-delete {
            background-color: #f44336;
        }
        
        /* Bouton de suppression au survol */
        .btn-delete:hover {
            background-color: #da190b;
        }
        
        /* Zone des statistiques */
        .stats {
            text-align: center;
            margin-bottom: 20px;
            color: #666;
        }
        
        /* Message quand aucune tâche */
        .empty-message {
            text-align: center;
            padding: 40px;
            color: #999;
        }

    </style>
</head>
<body>

<%! 
/* Définition de la classe Tache */

// Classe pour représenter une tâche avec titre et description
public class Tache
{
    // ===== ATTRIBUTS PRIVÉS =====
    private String id;                  // Identifiant unique de la tâche
    private String titre;               // Titre de la tâche
    private String description;         // Description détaillée
    private boolean complete;           // Etat : true = terminé, false = en cours

    // ===== CONSTRUCTEUR =====
    public Tache(String titre, String description)
    {
        this.id = UUID.randomUUID().toString(); // On génère un identifiant aléatoire pour chaque tâche
        this.titre = titre;                     // Stocke le titre de la tâche
        this.description = description;         // Stocke la description de la tâche
        this.complete = false;                  // Par défaut la tâche n'est pas complétée
    }

    // ===== GETTERS (méthodes pour récupérer les valeurs) =====
    // Recupere l'id de la tâche
    public String getId() { return id; }
    // Recupere le titre de la tâche
    public String getTitre() { return titre; }
    // Recupere la description de la tâche
    public String getDescription() { return description; }
    // Verifie si la tâche est complétée ou non
    public boolean isComplete() { return complete; }

    // ===== SETTER (méthode pour modifier une valeur) =====
    // Permet de changer l'état complété/non complété
    public void setComplete(boolean pComplete)
    {
        this.complete = pComplete;
    }
}
%>

<%
    // ===== 1. GESTION DE LA SESSION =====
    // Récupérer la liste des tâches depuis la session
    // session permet de dissocier les sessions utilisateur créée
    // application permet d'associer toutes les sessions ensemble
    List<Tache> listeTaches = (List<Tache>) application.getAttribute("listeTaches");
    // Est ce que c'est la premiere fois que je visite le site web ?
    if (listeTaches == null)
    {
        listeTaches = new ArrayList<>(); // On crée une nouvelle liste vide
        // On stocke cette liste dans la session pour la retrouver plus tard
        application.setAttribute("listeTaches", listeTaches);
    }

    // ===== 2. RÉCUPÉRATION DE L'ACTION =====
    // Gestion des actions
    String action = request.getParameter("action");

    // ===== 3. TRAITEMENT DES ACTIONS =====

    // ----- ACTION : AJOUTER UNE TÂCHE -----
    if ("ajouter".equals(action))
    {
        // Récupère le titre depuis le formulaire
        String titre = request.getParameter("titre");
        // Récupère la description depuis le formulaire
        String description = request.getParameter("description");

        // Vérifie que le titre existe et n'est pas vide et qu'il n'y a pas d'espace
        if (titre != null && !titre.trim().isEmpty())
        {
            // Si description est null, on met une chaîne vide
            if (description == null)
            {
                description = "";
            }
            // Crée une nouvelle tâche et l'ajoute à la liste
            listeTaches.add(new Tache(titre.trim(), description.trim()));
        }
    }
    // ----- ACTION : SUPPRIMER UNE TÂCHE -----
    else if ("supprimer".equals(action))
    {
        // Récupère l'ID de la tâche à supprimer
        String id = request.getParameter("id");
        // Si l'ID de la tâche correspond à l'ID reçu, elle est supprimée
        listeTaches.removeIf(t->t.getId().equals(id));
    }
    // ----- ACTION : BASCULER L'ÉTAT (complété ↔ en cours) -----
    else if ("toggle".equals(action))
    {
        // Récupère l'ID de la tâche à supprimer
        String id = request.getParameter("id");
        // Parcourt toutes les tâches
        for (Tache t : listeTaches)
        {
            // Si l'ID correspond
            if (t.getId().equals(id))
            {
                // Inverse l'état de complete
                t.setComplete(!t.isComplete());
                break;
            }
        }
    }
    // ----- ACTION : TOUT SUPPRIMER -----
    else if ("toutSupprimer".equals(action))
    {
        // Vide la liste entierement
        listeTaches.clear();
    }

    // ===== 4. CALCUL DES STATISTIQUES =====
    // Statistiques
    // Nombre total de tâche dans la liste
    int total = listeTaches.size();
    // Compteur de tâches complétées (initialisé à 0)
    int completes = 0;
    // Parcourt toutes les tâches pour compter celles qui sont complétées
    for (Tache t : listeTaches)
    {
        if (t.isComplete())
        {
            completes++;
        }
    }
%>

<!-- ===== STRUCTURE DE LA PAGE ===== -->

<!-- Titre principal -->
<h1>📋 Ma TodoList</h1>

<!-- Zone d'affichage des statistiques -->
<div class="stats">
    <%= total %> tâche(s) - <%= completes %> terminée(s) - <%= total - completes %> en cours
</div>

<!--- Zone d'ajout d'une tâche --->
<form action="#" method="post">
    <p>
        <input type="hidden" name="action" value="ajouter">
    </p>
    <p>
        Titre de la tâche : 
        <input type="text" name="titre" required>
    </p>
    <p>
        Description de la tâche : 
        <textarea type="text" name="description"></textarea>
    </p>
    <!-- Bouton pour soumettre le formulaire -->
    <p><input type="submit" value="Ajouter"></p>
</form>


 <!-- Afficher seulement s'il y a au moins une tâche -->
<%if (total > 0) {%>
    <div style="text-align: right; margin-bottom: 10px;">
        <form action="#" method="post" style="display: inline;"
              onsubmit="return confirm('Supprimer toutes les tâches ?');">
              <input type="hidden" name="action" value="toutSupprimer">
              <button type="submit" class="btn-small btn-delete">🗑️ Tout supprimer</button>
        </form>
    </div>
<%}%>


<!-- Liste des tâches -->
<% if (listeTaches.isEmpty()) { %>
    <div class="empty-message">
        <p>Aucune tâche pour le moment</p>
    </div>

<!-- Sinon, affiche toutes les tâches -->
<% } else { 
    for (Tache t : listeTaches) { 
%>
    <!--- ===== Affichage de la carte d'une tâche  --->
    <!-- Classe "completed" ajoutée si la tâche est complétée -->
    <div class="task <%= t.isComplete() ? "completed" : "" %>">
        <!-- Contenu de la tâche (titre et description) -->
        <div class="task-content">
            <!-- Titre de la tâche -->
            <div class="task-title">
                <%= t.isComplete() ? "✓ " : "" %><%= t.getTitre() %>
            </div>
            <!-- Description (affichée seulement si non vide) -->
            <% if (!t.getDescription().isEmpty()) { %>
                <div class="task-description"><%= t.getDescription() %></div>
            <% } %>
        </div>
        <!-- Boutons d'action -->
        <div class="task-actions">
            <!-- Gestion bouton terminer ou réactiver la tâche -->
            <form action="#" method="post" style="display: inline;">
                <input type="hidden" name="action" value="toggle">
                <input type="hidden" name="id" value="<%= t.getId() %>">
                <button type="submit" class="btn-small">
                    <%= t.isComplete() ? "↩️" : "✓" %>
                </button>
            </form>
            <!-- Bouton supprimer la tâche -->
            <form action="#" method="post" style="display: inline;" 
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
