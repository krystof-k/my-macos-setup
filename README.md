# My macOS setup

Just copy-paste this into your freshly installed Mac's terminal 🚀

```console
/bin/bash -c "$(curl -fsSL -H 'Cache-Control: no-cache' https://raw.githubusercontent.com/krystof-k/my-macos-setup/main/setup.sh)"
```

All stages are idempotent — you can safely re-run the setup at any time.

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
