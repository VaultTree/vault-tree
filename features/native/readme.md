Embeded implementation of the vault-tree library using mruby

Vault Tree should be complient with the mruby interpreter with the hope of:
  * Enabling the vault tree library to be run on any mobile device.
  * Native Applications for iOS, OSX, and Android can be easily build on top of
    vault tree API's

### Project Management

First order support will be given to both MRI and mRuby implementation of Vault
Tree. Items to consider:

  * Full mruby support is still a ways off
  * The test suite should be designed in such away that the mruby implementation
    of Vault Tree is always exercised along side the MRI 1.9.3 test runs.

#### Resources

* http://matt.aimonetti.net/posts/2012/04/25/getting-started-with-mruby/
* http://yujiyokoo.com/
