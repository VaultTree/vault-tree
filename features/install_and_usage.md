Make sure you checkout the README in the [Github Repo] for the full install documentation.

[Github Repo]: https://github.com/VaultTree/vault-tree

### Install With Vagrant

I think it should be easy for you to get a Vault Tree development environment up and running. If you don't know about Vagrant, you should, it's awesome!

* Follow the [Vagrant] download and install steps
* Clone the Vault Tree Repo and go into it:

[Vagrant]: http://www.vagrantup.com/

```shell
git clone git@github.com:VaultTree/vault-tree.git
cd ~/path/to/vault-tree/
```

Now you just need to Vagrant Up!

```shell
vagrant up
```

This will download and boot a pre-packaged Linux virtual machine with Vault-Tree and all dependencies already installed.

Once your VM is downloaded and built. You can go inside with:

```shell
vagrant ssh
```

As a developer working on Vault Tree you can now go to the VM's directory:

```
/vagrant
```
and run

```
bundle
rake
```

This will pull down the latest version of the code from [Ruby Gems] and then run all the core contracts and put you in a good spot to start exploring the library.

If you're not already familiar, take a few minutes to learn about how Vagrant will [sync your files] to and from the guest machine.

[vault-tree]: https://github.com/VaultTree/vault-tree
[main repo]: https://github.com/VaultTree/vault-tree
[Ruby Gems]: http://rubygems.org

### Install With Bundler

If you are comfortable with Ruby and Bundler checkout the README in the [main repo] to get started with a direct install.

[main repo]: https://github.com/VaultTree/vault-tree
