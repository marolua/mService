# mService - Gestion du Temps de Service pour FiveM

## Description
mService est un script FiveM permettant de suivre le temps de service d'un joueur. Il enregistre l'heure de début et de fin de service dans une base de données et envoie des logs avec la durée totale du service.

## Fonctionnalités
- Enregistrement de l'heure de début et de fin de service.
- Calcul automatique de la durée totale passée en service.
- Sauvegarde des informations en base de données.
- Envoi automatique des logs en fin de service.

## Installation
1. Téléchargez le script et ajoutez-le à votre dossier `resources`.
2. Assurez-vous d'avoir une base de données configurée pour enregistrer les temps de service.
3. Ajoutez `ensure mservice` à votre `server.cfg`.

## Utilisation
Vous pouvez tester le script avec les commandes suivantes :

```lua
RegisterCommand("prisedeservice", function()
    TriggerServerEvent("M:StartService")
end, false)

RegisterCommand("findeservice", function()
    TriggerServerEvent("M:StopServiceAndSendLogs")
end, false)
```

Pour intégrer les événements dans votre propre script, utilisez simplement :

```lua
TriggerServerEvent("M:StartService") -- Démarrer le service
TriggerServerEvent("M:StopServiceAndSendLogs") -- Terminer le service et envoyer les logs
```

## Configuration
Vous pouvez modifier le script pour adapter le stockage des données et la gestion des logs selon vos besoins.

## Support
Si vous avez des questions ou des suggestions, n'hésitez pas à ouvrir une issue ou à me contacter sur mon discord.

## Licence
Ce projet est sous licence MIT. Vous êtes libre de le modifier et de le redistribuer avec mention de l'auteur original.# mService
