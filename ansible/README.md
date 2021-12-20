# ansible

This is the ansible playbook for the configuration of my machines.

## Usage

```bash
make run
```

## TODOs

- [ ] working gpg for signing commits.
- [ ] make `yay` role idempotent (right now doesn't clean up properly so second run fails due to local modifications).
- [ ] ssh-ask-pass environment variable path to script
  - https://stackoverflow.com/questions/10232121/set-environment-variable-ssh-askpass-or-askpass-in-sudoers-resp
