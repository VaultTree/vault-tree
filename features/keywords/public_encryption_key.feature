Feature: Public Encryption Key


```javascript
  "contents": "PUBLIC_ENCRYPTION_KEY['decryption_key_vault_id']",
```

Public encryption keys are derived from their corresponding private decryption key.

This Keyword takes one argument the vault ID containing the associated private
key.

Public encryption keys and private decryption keys are used to build DH Keys
to lock and unlock asymmetric vaults.
