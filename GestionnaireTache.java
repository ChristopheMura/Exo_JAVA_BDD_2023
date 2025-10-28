
import java.util.ArrayList;
import java.util.List;

public class GestionnaireTache
{
    private List<String> taches;

    // Constructeur
    public GestionnaireTache()
    {
        taches = new ArrayList<>();
    }

    // Ajouter une tâche
    public void ajouterTache(String tache)
    {
        if (tache != null && !tache.trim().isEmpty())
        {
            taches.add(tache);
        }
    }

    // Récupérer la liste des tâches
    public List<String> getTaches()
    {
        return taches;
    }
}
