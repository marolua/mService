DROP TABLE IF EXISTS `mservice`;
CREATE TABLE IF NOT EXISTS `mservice` (
  `service_id` INT AUTO_INCREMENT PRIMARY KEY,  -- Ajout d'un champ `service_id` auto-incrémenté
  `id` varchar(60) NOT NULL,             -- Garde l'`id` du joueur comme un champ, mais ce ne sera pas la clé primaire
  `firstname` tinytext NOT NULL,
  `name` tinytext NOT NULL,
  `start` int NOT NULL,
  `fin` int NOT NULL,
  INDEX (`id`) -- Optionnel : Index pour améliorer la recherche par `player_id`
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
COMMIT;
