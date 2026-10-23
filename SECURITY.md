# Security notes

## iOS signing files in old commits (decision D1, 2026-10-23)

Commit `1024388` (2026-07-28) added two iOS signing files to the repository root:

- `distribution_new.cer`: the Apple distribution **certificate** (public part only, DER). It
  holds no private key, so it cannot be used to sign builds. It is valid until 2027-06-19.
- `BookPortfolioAppStore.mobileprovision`: the App Store provisioning profile
  `BookPortfolio-AppStore`. It expired on 2026-09-28.

Commit `e780945` (2026-10-21) stopped tracking both files, added them to `.gitignore`, and added
`scripts/check-signing-files.sh`, which CI runs so signing files cannot be committed again.
The files remain in the history before `e780945`.

**Decision (owner, 2026-10-23): leave the history as it is.** No certificate revoke, no
history rewrite, and the repository stays public. Reason: the certificate is public material
without its private key and the profile has expired, so neither can sign or install a build.
Revoking the certificate or rewriting history would cost a new signing setup and break
existing clones for no security gain.

Revisit this if a private key (`.p12`, `.key`, `.pem`) or an App Store Connect API key is ever
found in the history: then revoke it in the Apple Developer account first, and rewrite history.

## Reporting a problem

Open a private security advisory on this repository, or contact the owner through the
profile at https://bookchaowalit.com.
