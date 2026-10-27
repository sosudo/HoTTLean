# Unity change record

Install Unity with the install script from its README.
The installed source commit is `787e94eb3cebfc8dfb93a48b65da7e412be22186`.
The command `unity version` reports `0.5.0`.
The install completed. It reported a withdrawn Claude SDK release.
This run uses the Codex backend.

The local model list has no `gpt-6.1-luna` model.
The user approved `gpt-6-luna` as the replacement.
Use one Luna agent, one `gpt-6.1-terra` agent, and one `gpt-6.1-sol` agent.
Use the existing ChatGPT login. Do not set an API key or a custom provider.
Set `MAX_ATTEMPTS=2`. This setting is not a total token limit.
Keep Forum collaboration and separate worker worktrees enabled.

The command `unity init` created the runtime files.
Its cache step then tried to install Lean v4.25.0-rc2.
Extraction failed with `Quota exceeded (os error 122)`.
The target Lean v4.34.1 toolchain is already installed.
The bump command can use that installed toolchain.

No Unity source changes have been made.

Source: [Unity](https://github.com/sosudo/unity).
