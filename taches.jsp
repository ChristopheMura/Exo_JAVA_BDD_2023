<%@page contentType="text/html" pageEncoding="UTF-8"%>

<html>
<head>
<title>Taches</title>
</head>
<body bgcolor=white>
<h1>Saisir une tache</h1>
<form action="#" method="post">
    <label for="inputValeur">Saisir le nom d'une tache : </label>
    <input type="text" id="inputValeur" name="valeur">
    <input type="submit" value="Enregistrer">
</form>

<%! 
    class MyClass {
        String nameTache;

        public MyClass(String name) {
            nameTache = name;
        }
    }
%>

<%
    String valeur = request.getParameter("valeur");

    if (valeur != null && !valeur.isEmpty()) {
        MyClass tache = new MyClass(valeur);
%>
        <p>Nom de la tâche : <%= tache.nameTache %></p>
<%
    }
%>

</body>
</html>
