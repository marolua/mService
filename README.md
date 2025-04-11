
# 📦 mService - Gestion du Temps de Service pour FiveM

## 🔍 Description

**mService** est un script **FiveM** permettant de suivre avec précision le **temps de service** des joueurs.  
Il gère automatiquement le début et la fin du service, calcule la durée, enregistre les données en base de données, et envoie un **log complet sur Discord**.

---

## 🚀 Fonctionnalités

- ✅ Détection du début et de la fin de service
- ⏱️ Calcul automatique de la durée totale en service
- 🗃️ Sauvegarde en base de données (MySQL)
- 📤 Envoi d’un log formaté sur Discord (Webhook)
- 🔎 Commandes pour savoir si un joueur est en service et connaître son temps de service

---

## 📦 Installation

1. Téléchargez le script et placez-le dans le dossier `resources`.
2. Configurez correctement votre base de données pour accueillir les données du service.
3. Ajoutez la ligne suivante dans votre `server.cfg` :

```
ensure mservice
```

---

## 🧪 Commandes de test

Commandes disponibles côté client :

```lua
/prisedeservice            -- Démarre un service
/findeservice              -- Termine le service et envoie les logs
/TestPlayerService         -- Vérifie si le joueur est en service
/testplayertimeservice     -- Affiche le temps de service actuel du joueur
```

---

## 🔁 Intégration dans vos scripts

### Lancer ou arrêter un service :

```lua
TriggerServerEvent("M:StartService") -- Commencer le service
TriggerServerEvent("M:StopServiceAndSendLogs") -- Terminer le service et envoyer les logs
```

### Vérification depuis le client :

```lua
TriggerServerEvent("M:PlayerService")         -- Renvoie true/false selon si le joueur est en service
TriggerServerEvent("M:PlayerTimeInService")   -- Renvoie le temps en HH:MM:SS

-- Événements de retour :
RegisterNetEvent("M:ClientReturn:IsInService", function(isInService)
    print("Est en service :", isInService)
end)

RegisterNetEvent("M:ClientReturn:ServiceTime", function(time)
    print("Temps de service :", time)
end)
```

---

## ⚙️ Configuration

- Le webhook Discord est configurable directement dans le fichier `server.lua`.
- Les noms, jobs, et timestamps sont automatiquement récupérés avec **ESX**.
- Les notifications sont compatibles avec `xPlayer.showNotification`.

---

## 💬 Support

Pour toute question, suggestion ou problème :

- Ouvrez une **issue GitHub**
- Contactez-moi directement via **Discord**

---

## 📜 Licence

Ce projet est sous licence **MIT**.  
Vous pouvez l'utiliser, le modifier et le redistribuer librement tant que vous mentionnez l’auteur original.

---
