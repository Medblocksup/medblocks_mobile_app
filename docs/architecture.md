# Architecture

Working document. Describes the technical organisation of the application and
its known limits.

## 1. Overview
Flutter client (Dart). Firebase back end: authentication, Firestore, file
storage. No application server of its own at this stage.

## 2. Layers
- `presentation/ui/screen` : one screen per domain, no business logic.
- `presentation/ui/widgets` : reusable display components.
- `presentation/state_holders` : state and controllers.
- `data/services` : Firestore access, session, camera, decoding.
- `data/models` : data structures and serialisation.
- `data/utilities` : helpers.
- `assets` : fonts and images.

## 3. Verification flow
1. Open the scan screen, request camera permission.
2. Decode the code carried by the box.
3. Extract the product code.
4. Query the `lots` collection in Firestore.
5. Display the result: declared provenance, expiry date, status.

## 4. Data
| Collection | Content | Access |
|---|---|---|
| `produits` | product sheets, composition, price | public read |
| `lots` | number, product, provenance, expiry | authenticated read |
| `commandes` | cart, address, status | owner |
| `profils` | account, role | owner |

No identifying health data is processed at this stage.

## 5. Threat model
| Threat | Current mitigation | Remaining work |
|---|---|---|
| Batch record falsified in the database | Firestore rules, restricted writes | audit log |
| Replay of an already scanned code | read timestamp | hash anchoring |
| Network interception | TLS | certificate pinning |

## 6. Accepted limits
- Firebase is not HDS certified: migration required before any pharmacy pilot.
- No ledger and no anchoring: provenance is declarative.
- No offline mode: the result screen fails without network.
