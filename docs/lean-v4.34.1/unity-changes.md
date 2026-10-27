# Unity change record

[Unity](https://github.com/sosudo/unity) prepared the Lean v4.34.1 migration.
It accepted source repairs, then stopped at a configuration task error.
A separate compiler repair procedure completed the project builds and tests.
The [HoTTLean change record](hottlean-changes.md) contains the project validation results.

## Installation and configuration

The installed Unity commit is `787e94eb3cebfc8dfb93a48b65da7e412be22186`.
The command `unity version` reports `0.5.0`.
The README installation script completed.

The local model list had no `gpt-6.1-luna` model.
The user approved `gpt-6-luna` as its replacement.
The roster used that Luna model, `gpt-6.1-terra`, and `gpt-6.1-sol`.
Terra was the primary agent.
The agents used the existing ChatGPT login.
No API key or custom provider was set.
Forum collaboration and separate worker worktrees stayed enabled.

## Initial setup and interruption

`unity init` created the runtime files.
Its cache step then tried to install the initial Lean v4.25.0-rc2 toolchain.
Extraction failed with `Quota exceeded (os error 122)`.
The failed temporary download was moved to the data volume.
The target Lean v4.34.1 toolchain was already installed there.
The bump command used that toolchain and resolved the dependencies.
The [setup log](evidence/unity-init-error.txt) records these facts.

The first bump command lost its terminal during a Codex service restart.
Its output log was empty.
The exact cause of the later process stop was not established.
Process records confirmed closure before the next command.
The resumed command used `unity bump --continue` and wrote directly to a log file.

## Inherited dependency validation

Unity rejected import repair candidate `candidate-36d0ac07cf5f61823267`.
Its source commit was `e0fad34798e29a32cdce6bb59b43d7953d64cecb`.
The validator reported:
`dependency path must be canonical, project-local and not a symlink`.
The [rejection record](evidence/unity-rejection.txt) contains the result.

The verification worktree had no fetched packages.
Its manifest referenced the inherited checkdecls directory inside Poly.
Unity required that directory before it ran `lake update`.
Lake had not yet fetched the package that supplied the directory.

The repair changed `unity/bump_dependencies.py` and its setup tests.
Before an update, the validator now permits a missing inherited path below the package directory.
It still rejects missing direct dependencies, path escapes, and symbolic links.
After the update, all local dependency directories must exist.
The [patch](evidence/unity-bump-fix.patch) records the change.
The patch applies to the Unity source commit listed above.

The setup suite passed 56 tests.
The runtime suite passed 28 tests.
Nine dependency-name tests passed with their default settings.
The native oracle test selected Lean v4.7.0 by sorting version names as text.
That toolchain lacks `Lean.Data.Json.FromToJson.Basic`, so the test failed.
The same test passed when Lean v4.34.1 was selected.
No source repair was made for that toolchain selection issue.
The [test log](evidence/unity-fix-tests.txt) records these results.
A broader test run was interrupted. It is not a passed check.

## Resume and stop

The resumed tasks used `MAX_ATTEMPTS` values of 2, 4, and 6.
This setting limits attempts per task. It is not a total token limit.
A Forum command required `UNITY_BUMP_PROFILE=preparing` after a profile lookup error.
The import repair then passed integration. A test import repair also passed.

The test module root conflicted with ProofWidgets.
The agent requested a unique root for the four HoTTLean test files.
Unity created replacement configuration tasks but kept assigning the original task.
At the stop, `configuration-2` had five attempts.
Tasks `configuration-3` through `configuration-6` had no attempts.
Their replacement module lists also retained the old module names.
The [state extract](evidence/unity-handoff.txt) records this condition.

The controller stopped cleanly with exit status 0.
That status confirmed the stop. It did not verify the project build.
The accepted source commits were retained for the compiler repair procedure.
No scheduling or collaboration feature was removed from Unity.
The Unity run stopped before its parallel declaration repair stage.
The later project results belong to the separate compiler repair procedure.
