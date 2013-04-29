Feature: Initialize the CLI

  Scenario: For the First Time
    Given a clean start
    Then a directory named "~/.vault-tree" should not exist
    When I run `vault-tree`
    Then the output should contain "Creating a .vault-tree dir under ~/"
    And a directory named "~/.vault-tree" should exist

  Scenario: After the first init
    Given a clean start
    Then a directory named "~/.vault-tree" should not exist
    When I run `vault-tree`
    And I run `vault-tree`
    Then the output should not contain "Creating a .vault-tree dir under ~/"
    And a directory named "~/.vault-tree" should exist

  Scenario: With the CLI Alias
    Given a clean start
    Then a directory named "~/.vault-tree" should not exist
    When I run `vt`
    Then the output should contain
      """ 
                          Vault Tree
                Self Enforcing Bitcoin Contracts

      usage: vault-tree <command> [<args>]

      The most commonly used vault-tree commands are:
        contract    Execute, create or delete contracts
        key         Create or delete public and private keys
        url         Create, delete, and rename remote urls
        fetch       Download, objects and refs from remote urls
        status      Show the status of active contracts 
        log         Show contract logs
     """ 
