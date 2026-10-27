# HoTTLean change record

The project uses Lean v4.34.1.
The initial commit was `31133dd`. It used Lean v4.25.0-rc2.
The migration branch is `bump/lean-v4.34.1`.

## Dependencies

Use the [sosudo/Poly fork](https://github.com/sosudo/Poly).
Pin it to commit `cc08a1f77c20e07a7366f0824ecd36ae472c0377`.
Remove the direct checkdecls requirement.
Use the copy of checkdecls in `Poly/vendor/checkdecls`.
Both Poly and this copy use Lean v4.34.1.

The dependency update passed.
Mathlib v4.34.1 selects some packages with a v4.34.0 source toolchain.
The project builds those selected revisions with Lean v4.34.1.
No source repair was necessary in these dependency repositories.

| Package | Source toolchain | Revision |
| --- | --- | --- |
| Poly | v4.34.1 | `cc08a1f77c20e07a7366f0824ecd36ae472c0377` |
| checkdecls | v4.34.1 | `Poly/vendor/checkdecls` |
| mathlib | v4.34.1 | `d13f23b723b8a846827a245b89c10fc7d3f11612` |
| plausible | v4.34.0 | `118aa17ee84656b8bd727fef7c458ee8c833385c` |
| LeanSearchClient | v4.34.0 | `ddf04cf3949fa556442341e87d47f9f6e6074707` |
| importGraph | v4.34.0 | `e928b72544873815af278d38681b31c0293588e3` |
| proofwidgets | v4.34.0 | `106ff4fafc74ef4ac99d81dbf3ab399118f497a5` |
| aesop | v4.34.0 | `355695d523e41d0554926416cba2a2b3544fbbc9` |
| Qq | v4.34.0 | `6a489d9af5d0c47e5b259e2e8bcdfc1811b5a259` |
| batteries | v4.34.0 | `f2effa3d803fda822b1f97b806c47cf2adfbcbc2` |
| Cli | v4.34.0 | `e92c9f15fdfacc8536f31cfb3b7ad26c3c8cd204` |

## Source repairs

Use the new Mathlib import paths and category wrappers.
Update the projections for `Cat.Hom`, natural transformations, and full subcategories.
Make the required reductions explicit in pullback and polynomial proofs.
Use heterogeneous equality when transport changes dependent morphism types.
These repairs keep the mathematical claims.

Use the upstream free groupoid construction through local compatibility names.
Retain the original limits instance. The upstream adjunction does not provide that instance.
Remove local declarations that now conflict with equivalent Mathlib declarations.
One source API difference remains: `Discrete.functor_ext` now takes implicit functor arguments.
Calls that pass the functors explicitly must use named arguments.
Change `preservesPullbacks` from an instance to a theorem.
Its result type `IsPullback` is not a class in this Mathlib version.

Update the frontend import, environment, and declaration APIs.
Update quoted proofs in the typechecker.
Enable initializer execution before the frontend imports its theory prelude.
This Lean API has an effect on the whole process.
Concurrent or embedded frontend callers must follow the Lean initializer requirements.
Keep the existing unchecked declaration replay in the isolated theory environment.
This work adds no unchecked path for project theorem proofs.

Update the `functor_map` generator for the new `Quiver.Hom` universe parameters.
The [probe](evidence/FunctorMapProbe.lean) checks generated lemmas and nested attributes.
It also checks the term elaborator.
The [probe log](evidence/functor-map-probe.txt) records the passed check.
A build of the attribute source alone did not detect the error.

Update the natural model and unstructured model proofs for the selected APIs.
Update the groupoid model proofs for pi types, sigma types, and identity types.
Use explicit transport and wrapper reductions in those proofs.
Use `Groupoids.UnstructuredModel` as the import for the cloven isofibration file.
That file does not use pi type declarations.
This import change permits independent pi type and identity type checks.

Use `backward.isDefEq.respectTransparency false` where earlier elaboration is required.
This option changes elaboration. It does not disable kernel proof checks.
Use a local limit of 800000 heartbeats for three expensive proofs.
The proofs are the sigma associator composition, pi naturality inverse, and natural pair case.

Remove unused simplification arguments reported by Lean.
Replace three deprecated lemma names with their current names.
No linter suppression was added.
Wrap source lines that exceed the CI limit of 100 characters.
The initial sources had 43 such lines outside URLs.

## Tests and interpretation universes

Rename the test root from `test` to `HoTTLeanTest`.
The old root conflicts with a ProofWidgets test root.
The new root imports all four test files.
Keep the three existing frontend tests and their assertions.
Change the expected warning quote to match Lean v4.34.1.

The old test root did not import the unit type test.
That test also imported two absent modules: `Model.Interpretation` and `Groupoids.NaturalModelBase`.
Port the test to the current unstructured groupoid model.
Keep its theory axioms and interpretation equality.
This adds a checked use of the current model.
It does not restore a natural groupoid model bridge that was absent from the initial source.

Allow independent object and morphism universes in the unstructured interpreter.
Its category has object universe `u` and morphism universe `v`.
Its extension sequences and contextual objects use `Type (max u v)`.
Use the universe-polymorphic `Part.bind` and `Part.map` operations for context interpretation.
This includes the earlier equal-universe case and the groupoid model case.
The soundness statements remain the same under these more general universe parameters.

Remove the unit test's redundant `IdSeq := sorry` instance.
The groupoid model supplies a checked identity type instance.
Keep the intentional `sorry` inside the frontend warning test.

## API documentation

Select doc-gen4 v4.34.1 in the optional development configuration.
`lake update -R -Kenv=dev doc-gen4` passed.
All existing dependency commits stayed the same.
The Cli source label changed from a release tag to `main`; its commit stayed the same.
The [update log](evidence/docs-update.txt) records the result.

| Package | Source toolchain | Revision |
| --- | --- | --- |
| doc-gen4 | v4.34.1 | `953c8992d174b4e56955e01e101d46668c68f2bb` |
| leansqlite | v4.34.0 | `f9cdb9eacb5c8b8ecc02ee9fd9e568d7d28c1416` |
| UnicodeBasic | v4.34.0 | `0e569d08b6443ce0908d356884c765397253e2f0` |
| BibtexQuery | v4.34.0 | `4d8616fd4870d0a3453d845770833eac7951fe1c` |
| MD4Lean | v4.29.0-rc1 | `31907cc18f48a95384f99cee5582c00fb39e0f67` |

These are the revisions selected by doc-gen4 v4.34.1.
The generator and these dependencies compiled with Lean v4.34.1.
No dependency source repair was necessary.
The [generator build](evidence/docs-generator-build.txt) passed with 194 jobs.

## Final checks

All checks below passed on the final source with Lean v4.34.1.
The compiler commit is `5045d0056413266e57c625dcd7c365b10e377c52`.
Lake reports version `5.0.0-src+5045d00`.
The [source hashes](evidence/source-hashes.txt) identify the checked source and configuration.
The logs include results replayed from Lake's build cache.
Each command returned exit status 0.

| Check | Jobs | Compiler warnings | Evidence |
| --- | ---: | ---: | --- |
| `lake build` | 1023 | 92 | [Log](evidence/project-final.txt) |
| `lake build NaturalModel` | 1029 | 29 | [Log](evidence/natural-final.txt) |
| `lake test` | 1027 | 92 | [Log](evidence/tests-final.txt) |
| Three compatibility modules | 650 | 0 | [Command and log](evidence/compatibility-final.txt) |
| `lake -R -Kenv=dev build HoTTLean:docs` | 2245 | 92 | [Log](evidence/api-docs-final.txt) |
| Generated `functor_map` declarations | — | 0 | [Command and log](evidence/functor-map-final.txt) |
| Line lengths and precise imports | — | 0 | [Result](evidence/style-final.txt) |
| `git diff --check` | — | 0 | [Result](evidence/whitespace-final.txt) |

The test driver checks all four test modules.
It also checks `HoTTLean.Groupoids.UHom` through the unit type test.
The three extra modules are `Groupoid`, `Localization.Predicate`, and `MorphismProperty.Basic`.
They are under `HoTTLean.ForMathlib.CategoryTheory`.
Together, these checks cover all 67 production and test modules.
Prelude and both root files are also checked.

After the documentation build, `lake update` reused the cached development configuration.
The [first update log](evidence/default-update-cached-config.txt) records that command.
Reload the configuration with `lake -R update`.
The [final update log](evidence/default-update-final.txt) records the successful reset.
The final default manifest has the same dependency commits and paths as before the documentation check.
The [manifest record](evidence/dependency-pins.txt) contains both configurations.
The final project, natural model, and test commands used the restored default configuration.

The generated root page and interpretation page exist in `.lake/build/doc/`.
The API generator emitted 43 warnings about dependency metadata.

## Repository cleanup

Archive duplicate intermediate logs outside the repository.
Ignore local Unity state and repair workspaces.
Add a link to these records in the README.
The Lean source and dependency configuration stayed the same during cleanup.
The default build, natural model build, and test driver passed again before the push.
The [check record](evidence/pre-push-checks.txt) records these results.

## Remaining limits

The production sources retain three proof holes in `HoTTLean/ForPoly.lean`.
They retain six axiom declarations: three prelude constants and three injectivity axioms.
No production proof hole or axiom was added.
The tests retain one intentional proof hole and ten theory axioms.
The [source audit](evidence/source-audit.txt) gives the declarations, locations, and count method.

The final logs contain 99 distinct HoTTLean compiler warning headlines.
Three concern the existing proof holes.
The others concern proof scripts, definitions, instances, namespaces, or universes.
The logs also contain 13 distinct Poly warnings for declarations that use `sorry`.
The [warning index](evidence/warnings-final.txt) lists every location and headline.
It also lists all 43 API generator warnings.
Repeated warnings in separate target logs are counted once in this index.
The full messages remain in the linked target logs.
No compilation or test blocker remains.

The API generator reports missing metadata for some dependency declarations.
These warnings affect equation or declaration documentation.
They do not indicate a project compilation failure.

The checks use the local Linux environment and the resolved dependency cache.
A second clean machine and remote GitHub Actions were not used.
The obsolete notes, `attic`, and benchmark programs are outside the declared build scope.
The blueprint TeX build, Jekyll site build, and GitHub Pages deployment were not run.
The generated API pages are local artifacts. They were not published.
Their source links use commit `d3df93c`, which preceded the final migration repairs.
The recorded source hashes identify the source used for verification.

See the separate [Unity record](unity-changes.md) and [workflow record](workflow-changes.md).
