# atmin Homebrew tap

Install the experimental code review CLI on macOS or Linux:

```sh
brew install atmin-inc/tap/atmin
atmin --help
```

Homebrew installs Node 24, Git and the GitHub CLI. Authenticate with
`gh auth login`, set `OPENROUTER_API_KEY` in your environment, then run:

```sh
cp "$(brew --prefix atmin-inc/tap/atmin)/share/atmin/profiles/smoke-openrouter-free.json" ./review-profile.json
atmin review https://github.com/OWNER/REPO/pull/123 \
  --profile ./review-profile.json --out ./private-review
```

Replace the example URL with a PR you may access and send to your model provider.
The free profile permits only zero-priced inference, with no paid fallback;
provider availability and rate limits apply. The bundled `baseline-deepseek.json`
profile permits up to $2 per review. Keep output directories private: they contain
repository source. Reviews do not execute repository scripts.

This tap currently packages the review alpha. It also provides `atmin-review`
and `atmin-review-github`; see the [review documentation](https://github.com/atmin-inc/review)
for verdicts, individual commands and GitHub App operation.

If another installation already owns `atmin`, preserve it with
`brew install --skip-link atmin-inc/tap/atmin` and run this package through
`"$(brew --prefix atmin-inc/tap/atmin)/bin/atmin"`.

## Maintain

The formula installs a versioned public npm archive and verifies its SHA-256.
For a release, update its URL, version and checksum, then run:

```sh
brew install --build-from-source atmin-inc/tap/atmin
brew test atmin-inc/tap/atmin
```

CI checks installation and command handling on macOS and Linux without GitHub
credentials or model credits. The formula source is maintained in the review
system's packaging directory and published here; this repository contains no
private product source or history.
