# Architecture

Document de travail. Décrit l'organisation technique de l'application et ses
limites connues.

## 1. Vue d'ensemble
Application cliente Flutter (Dart). Back-end Firebase : authentification,
base Firestore, stockage de fichiers. Pas de serveur applicatif propre à ce
stade.

## 2. Couches
- `screens` : écrans par domaine, sans logique métier.
- `widgets` : composants d'affichage réutilisables.
- `services` : accès Firestore, session, caméra, décodage.
- `models` : structures de données et sérialisation.
- `tokens` : jetons de design.

## 3. Flux de vérification
1. Ouverture de l'écran de lecture, demande de permission caméra.
2. Décodage du code porté par la boîte.
3. Extraction du code produit.
4. Requête Firestore sur la collection `lots`.
5. Affichage du résultat : provenance déclarée, date de péremption, statut.

## 4. Données
| Collection | Contenu | Accès |
|---|---|---|
| `produits` | fiches produit, composition, prix | lecture publique |
| `lots` | numéro, produit, provenance, péremption | lecture authentifiée |
| `commandes` | panier, adresse, statut | propriétaire |
| `profils` | compte, rôle | propriétaire |

Aucune donnée de santé identifiante n'est stockée à ce stade.

## 5. Modèle de menaces
| Menace | Parade actuelle | Reste à faire |
|---|---|---|
| Falsification d'un lot en base | règles Firestore, écriture restreinte | journal d'audit |
| Rejeu d'un code déjà scanné | horodatage de la lecture | ancrage d'empreinte |
| Interception réseau | TLS | épinglage de certificat |

## 6. Limites assumées
- Firebase n'est pas certifié HDS : migration avant tout pilote en officine.
- Pas de registre ni d'ancrage : la provenance est déclarative.
- Pas de mode hors connexion : l'écran de résultat échoue sans réseau.
