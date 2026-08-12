# Spécification de lecture des identifiants GS1

Document de travail. Décrit le format attendu et les règles de lecture. La mise
en œuvre est suivie en ticket.

## 1. Objet
Le code porté par une boîte de médicament est un DataMatrix GS1. La lecture
doit extraire quatre identifiants et rejeter tout code incomplet.

## 2. Identifiants visés
| AI | Signification | Format | Obligatoire |
|---|---|---|---|
| 01 | code produit (GTIN) | 14 chiffres | oui |
| 17 | date de péremption | AAMMJJ | oui |
| 10 | numéro de lot | 20 caractères alphanumériques max | oui |
| 21 | numéro de série | 20 caractères alphanumériques max | non |

## 3. Structure
Les identifiants sont concaténés. Les AI de longueur variable (10, 21) sont
terminés par le séparateur GS (0x1D). Les AI de longueur fixe (01, 17) ne le
sont pas.

## 4. Règles de lecture
1. Rejeter le code si l'AI 01 est absent ou si le GTIN n'a pas 14 chiffres.
2. Lire l'AI 17 et convertir en date ; rejeter une date invalide.
3. Lire l'AI 10 jusqu'au séparateur GS ou à la fin de la chaîne.
4. Signaler un lot expiré sans bloquer l'affichage.
5. Ne jamais faire confiance au contenu affiché : revérifier côté service.

## 5. Cas d'erreur
| Cas | Comportement attendu |
|---|---|
| Code tronqué | message explicite, bascule en saisie manuelle |
| GTIN invalide | refus, message |
| Date invalide | refus, message |
| AI 10 absent | refus : un lot sans numéro n'est pas traçable |

## 6. Cas de test à écrire
- code complet valide ;
- code sans AI 10 ;
- code avec date impossible (mois 13) ;
- code tronqué au milieu du GTIN ;
- code avec séparateur GS manquant ;
- code avec caractères non ASCII.
