Feature: Contents

The `CONTENTS` keyword is used to fetch the contents of another vault:

```javascript
"contents": "CONTENTS['some_string']"
```

It takes one argument, the name of the vault holding the desired contents.

The contents keyword should only be used in the **"contents"** field. If you want to use it in either

the **lock_with** or **unlock_with** fields, you should consider the alias `KEY` instead.

Here is an example of a vault that makes use of the `CONTENTS` keyword.

```javascript
"locked_message":{
  "contents": "CONTENTS['message_locked_with_random_key']",
  "lock_key": "KEY['unlocked_random_key']",
  "unlock_key": "KEY['unlocked_random_key']",
  "ciphertext": ""
}
```
