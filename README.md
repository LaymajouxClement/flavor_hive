# Flavor Hive

FlavoHive (ruche de saveurs) est une application intelligente qui vous aide à explorer et expérimenter une multitude de saveurs.
Si vous avez des épices errants dans votre cuisine sans savoir que faire, il vous suffira de les renseigner dans l’application afin qu’elle vous suggère des idées de repas.
Cette fonctionnalité pouvant être réversible, c’est-à-dire vous pouvez avoir envie de concocter un nouveau plat mais n’ayant pas la recette,
FlavorHive pourra vous dresser la recette et même vous donner les instructions pour le faire.

## Démarrage

Ce projet peut être récupéré et lancer depuis votre local mais il contient des dépendences nécessaires pour son bon fonctionnement, il vous faudra effectuer les action suivantes :

**Etape 1 :**

Télécharger ou cloner ce repertoire en utilisant ce lien

```
https://github.com/LaymajouxClement/flavor_hive.git
```

**Etape 2 :**

Aller à la racine du projet et exécuter la commande suivante pour récupérer les dépendances requises

```
flutter pub get 
```

**Etape 3 :**

Recupérer le fichier de credentials Google `google-services.json` et le mettre dans `android/app/google-services.json` (si vous n'étes pas autorisé, n'hésitez pas à nous contacter)

```
https://console.firebase.google.com/u/0/project/flavorhive-2023/settings/general/android:com.example.flavor_hive?consoleUI=FIREBASE
```

**Etape 4 :**

Ajouter une clé API Open AI dans le fichier `lib/components/open_ai.dart`