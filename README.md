# Flavor Hive

FlavoHive (ruche de saveurs) est une application intelligente qui vous aide à explorer et expérimenter une multitude de saveurs.
Si vous avez des épices errants dans votre cuisine sans savoir que faire, il vous suffira de les renseigner dans l’application afin qu’elle vous suggère des idées de repas.
Cette fonctionnalité pouvant être réversible, c’est-à-dire vous pouvez avoir envie de concocter un nouveau plat mais n’ayant pas la recette,
FlavorHive pourra vous dresser la recette et même vous donner les instructions pour le faire.

## Démarrage

Ce projet peut être récupéré et lancer depuis votre local mais il contient des dépendences nécessaires pour son bon fonctionnement, il vous faudra effectuer les action suivantes :

**Etape 1 :**

Télécharger ou cloner ce repertoire en utilisant ce lien [ici](https://github.com/LaymajouxClement/flavor_hive.git)

**Etape 2 :**

Aller à la racine du projet et exécuter la commande suivante pour récupérer les dépendances requises

```bash
flutter pub get 
```

**Etape 3 :**

Recupérer le fichier de [credentials Google](https://console.firebase.google.com/u/0/project/flavorhive-2023/settings/general/android:com.example.flavor_hive?consoleUI=FIREBASE) `google-services.json` et le mettre dans `android/app/google-services.json` (si vous n'étes pas autorisé.es, n'hésitez pas à nous contacter)

**Etape 4 :**

Créer un fichier nommé `.env` à l'image du fichier `.env.example` quitte à la copier, puis renseigner une clé API Open AI valide

**Etape 5 :**

Lancer depuis votre IDE ou alors depuis votre terminal avec la commande

```bash
flutter run
```
