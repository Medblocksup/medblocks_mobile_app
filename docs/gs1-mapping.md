# GS1 identifier parsing specification

Working document. Describes the expected format and reading rules.
Implementation tracked in issue #8.

## 1. Purpose
The code carried by a medicine box is a GS1 DataMatrix. Parsing must extract
four identifiers and reject any incomplete code.

## 2. Target identifiers
| AI | Meaning | Format | Required |
|---|---|---|---|
| 01 | product code (GTIN) | 14 digits | yes |
| 17 | expiry date | YYMMDD | yes |
| 10 | batch number | 20 alphanumeric chars max | yes |
| 21 | serial number | 20 alphanumeric chars max | no |

## 3. Structure
Identifiers are concatenated. Variable-length AIs (10, 21) are terminated by
the GS separator (0x1D). Fixed-length AIs (01, 17) are not.

## 4. Reading rules
1. Reject the code if AI 01 is missing or the GTIN is not 14 digits.
2. Read AI 17 and convert to a date; reject an invalid date.
3. Read AI 10 up to the GS separator or end of string.
4. Flag an expired batch without blocking display.
5. Never trust displayed content: re-check server-side.

## 5. Error cases
| Case | Expected behaviour |
|---|---|
| Truncated code | explicit message, fall back to manual entry |
| Invalid GTIN | reject, message |
| Invalid date | reject, message |
| Missing AI 10 | reject: a batch without a number is not traceable |

## 6. Test cases to write
- valid complete code;
- code without AI 10;
- code with an impossible date (month 13);
- code truncated in the middle of the GTIN;
- code with a missing GS separator;
- code with non-ASCII characters.
