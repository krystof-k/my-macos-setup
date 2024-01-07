# My macOS setup

Just copy-paste this into your freshly installed Mac's terminal 🚀

```console
/bin/bash -c "$(curl -fsSL -H 'Cache-Control: no-cache' https://raw.githubusercontent.com/krystof-k/my-macos-setup/main/setup.sh)"
```

| Option | Description |
| - | - |
| `--skip-authentication` | Skip signing in, setting up SSH keys and other authentication steps |
| `--skip-homebrew-install` | Skip installing and setting up Homebrew |
| `--skip-git` | Skip installing Git and cloning this repostiory |
| `--skip-brew` | Skip installing apps from Brewfile |
| `--skip-ruby` | Skip Ruby version manager setup |
| `--skip-node-js` | Skip Node.js version manager setup |
| `--skip-python` | Skip Python version manager setup |

## Encryption

Sensitive files can be put in the `safe` folder and encrypted using GPG and the SSH private key.

Run the following to generate the symmetric key and encrypt it with the SSH private key:

```console
openssl rand 256 > my-macos-setup.key
openssl pkeyutl -encrypt -in my-macos-setup.key -out my-macos-setup.key.enc -inkey ~/.ssh/krystof-k.pem
```

Then run

```console
./utilities/encrypt.sh
```

to encrypt the `safe` folder and

```console
./utilities/decrypt.sh
```

to decrypt it.
