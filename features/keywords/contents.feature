Feature: Contents

The contents keyword is used to fetch the contents of another vault. For
example: 

```javascript
"fill_with": "CONTENTS['vault_three_key']",
```

It takes one argument, the name of the vault holding the desired contents.

The contents keyword can be used in the **fill_with**, **lock_with** and **unlock_with** fields.
