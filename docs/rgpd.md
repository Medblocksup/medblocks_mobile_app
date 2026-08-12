# Audit interne de conformité RGPD

Auto-évaluation interne. Ne vaut pas analyse d'impact au sens de l'article 35
du RGPD, dont la rédaction reste à mener avant tout pilote en officine.

## 1. Périmètre
Traitements réalisés par l'application mobile MEDBLOCKS : compte utilisateur,
lecture de code, catalogue, commandes.

## 2. Données traitées
| Donnée | Finalité | Base légale | Durée | Support |
|---|---|---|---|---|
| Identité, contact | compte | contrat | vie du compte | Firestore |
| Adresse de livraison | commande | contrat | 3 ans | Firestore |
| Code lu, horodatage | traçabilité | intérêt légitime | à définir | Firestore |
| Historique de commandes | service | contrat | 3 ans | Firestore |

Aucune donnée de santé identifiante n'est traitée à ce stade.

## 3. Constats
| N° | Constat | Gravité |
|---|---|---|
| C1 | Aucune durée de conservation fixée pour les lectures de code | moyenne |
| C2 | Pas de purge locale à la déconnexion | moyenne |
| C3 | Hébergement Firebase non certifié HDS | haute |
| C4 | Analyse d'impact non rédigée | haute |
| C5 | Registre des sous-traitants incomplet | moyenne |
| C6 | Information sur les durées absente de la politique publiée | faible |

## 4. Plan de remédiation
| Action | Échéance | État |
|---|---|---|
| Fixer et documenter la durée de rétention des lectures | T4 2026 | à faire |
| Purger l'historique local à la déconnexion | T4 2026 | à faire |
| Rédiger l'analyse d'impact | T1 2027 | à faire |
| Migrer vers un hébergement certifié HDS | T1 2027 | à faire |
| Compléter le registre des sous-traitants et les contrats de traitement | T1 2027 | à faire |
| Mettre à jour la politique de confidentialité | T1 2027 | à faire |

## 5. Sous-traitants
Google Ireland Limited (Firebase) — authentification, base, stockage.
Contrat de traitement à formaliser. Transferts hors Union à documenter.

## 6. Suivi
Revue trimestrielle. Le plan est suivi en tickets, étiquette `rgpd`.
