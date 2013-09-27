Feature: CLI Settings File

Scenario: vault-tree settings
  Given an empty settings file
  When I run `vault-tree settings`
  Then the stdout should contain "EMPTY_SETTINGS_PASSWORD"
