# MEDBLOCKS

Application mobile de traçabilité des lots pharmaceutiques : lecture du code
porté par la boîte, résolution du lot, affichage de la provenance déclarée.

Publiée sur l'App Store (n° 6504901422) et sur Google Play
(com.medblocks.medblockseu).

## Périmètre actuel
- Catalogue et fiches produit : composition, dosage, précautions
- Lecture de code et écran de résultat de vérification
- Suivi de catalogue et de lots
- Compte utilisateur, panier, commandes
- Mise en relation avec un praticien

## Stack
Flutter (Dart), Firebase (authentification, Firestore, stockage).
Version Flutter épinglée via FVM.

## Arborescence
| Dossier | Contenu |
|---|---|
| `lib/models` | modèles de données |
| `lib/services` | accès réseau, session, caméra |
| `lib/screens` | écrans par domaine |
| `lib/widgets` | composants réutilisables |
| `lib/tokens` | jetons de design |
| `docs` | documentation technique |
| `test` | tests unitaires |

## Historique des versions
| Version | Date | Contenu |
|---|---|---|
| 1.0.6 | 11/08/2026 | refonte d'interface, pages 16 KB |
| 1.0.3 | 12/06/2025 | corrections, publication Play Store |
| 1.0.2 | 15/04/2025 | corrections d'interface |
| 1.0.1 | 15/04/2025 | première publication, fonctions e-pharmacie |

## Limites connues
- Hébergement Firebase non certifié HDS ; migration planifiée avant le pilote.
- Parsing des identifiants GS1 partiel : le code produit est lu, les
  identifiants de lot et de péremption ne sont pas encore traités.
- Pas d'ancrage d'empreinte à ce stade.

## Configuration locale
`android/app/keystore.properties` et `android_jks/` ne sont pas versionnés.
Documentation interne en français dans `docs/`.
