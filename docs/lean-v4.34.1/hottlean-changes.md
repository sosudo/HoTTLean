# Lean v4.34.1 migration record

This branch combines two completed migrations from `31133dd` (Lean v4.25.0-rc2).
Unity produced commit `39e8eb63`.
The earlier root-led migration ended at `6f719862`.
The combined work keeps the Unity source as its base.
It adds the stronger unit test, compiler warning cleanup, source formatting,
and documentation from the earlier work.
This combination is root-led work. It is not the Unity-approved snapshot.

## Dependencies and source changes

Use Lean v4.34.1 and Mathlib v4.34.1.
Use the [sosudo/Poly fork](https://github.com/sosudo/Poly) at
`cc08a1f77c20e07a7366f0824ecd36ae472c0377`.
Use its vendored checkdecls package.
The combined work does not change the default dependency commits or paths.

Keep Unity's repairs for the category wrappers, pullbacks, polynomial functors,
groupoid model, and natural and unstructured models.
Keep the original public Grothendieck names and their compatibility aliases.
Keep the declaration-local elaboration options and explicit wrapper projections.
These options control elaboration. They do not disable kernel proof checks.
Remove unused simplification arguments and deprecated lemma names.
Wrap source lines to meet the CI limit of 100 characters, except URLs.
Do not add linter suppressions.

Keep Unity's frontend environment loader unchanged.
It reads the custom prelude without changing process-wide import flags.
It checks that the prelude imports only Init and has no initializers.
It restores persistent extension entries without loading native code or running
module initializers.
This loader supports that restricted prelude contract.
It is not a general replacement for Lean's module loader.
The existing unchecked declaration replay remains limited to the isolated theory
environment.

Keep the `functor_map` universe repair.
The [probe](evidence/FunctorMapProbe.lean) checks generated declarations,
nested attributes, and the term elaborator.

## Tests

The test root is `HoTTLeanTest`.
It imports all four test modules and avoids the ProofWidgets `test` root conflict.
The unit type test uses the current unstructured groupoid model.
The interpreter permits separate object and morphism universes.
Remove the redundant `IdSeq := sorry` instance from that test.
Use the checked instance from `HoTTLean.Groupoids.UHom`.
Keep the intentional proof hole in the frontend warning test.

Build the natural and unstructured model targets separately.
Their exported names overlap, so they must not share one imported environment.

## Validation

All checks passed on source commit `20c4b230` with Lean v4.34.1.
The compiler commit is `5045d0056413266e57c625dcd7c365b10e377c52`.
The [source hashes](evidence/source-hashes.txt) identify the checked files.
The [command receipts](evidence/command-receipts.txt) give exit status, duration,
and log hashes. Each command kept its source inputs unchanged.
The logs include results replayed from Lake's dependency and project caches.

| Check | Jobs | Project warnings | Evidence |
| --- | ---: | ---: | --- |
| `lake build` | 1025 | 66 | [Log](evidence/project.txt) |
| `lake build NaturalModel` | 1029 | 21 | [Log](evidence/natural.txt) |
| `lake test` | — | 67 | [Log](evidence/tests.txt) |
| `lake build +HoTTLean.ForMathlib.CategoryTheory.Groupoid +HoTTLean.ForMathlib.CategoryTheory.Localization.Predicate +HoTTLean.ForMathlib.CategoryTheory.MorphismProperty.Basic` | 650 | 0 | [Log](evidence/compatibility.txt) |
| `lake -R -Kenv=dev build HoTTLean:docs` | 3410 | 66 | [Log](evidence/api-docs.txt) |
| `lake env lean docs/lean-v4.34.1/evidence/FunctorMapProbe.lean` | — | 0 | [Log](evidence/functor-map.txt) |
| `lake env lean test.lean` | — | 0 | [Log](evidence/legacy-test-root.txt) |
| `lake -R env lean --version` | — | 0 | [Log](evidence/default-config.txt) |
| `git diff --check 39e8eb63` | — | 0 | [Log](evidence/whitespace.txt) |

The default build has 66 project warnings. Unity's approved build had 389.
The natural-model build has 21 warnings. The test command has 67 warnings.
There are 81 distinct project warning headlines across these checks.
The [warning index](evidence/warnings.txt) lists them.
It also lists 43 documentation-generator warnings about dependency metadata.
Those warnings do not prevent the documentation build.

The [static import check](evidence/module-coverage.txt) covers all 67 production
and test modules. The root modules and legacy test root also pass.
The [style check](evidence/style.txt) and whitespace check pass.
The [source audit](evidence/source-audit.txt) compares master, Unity, and the combined source.
Production proof holes and axiom counts stay unchanged.
The test proof-hole count decreases from two to one.
The [independent source review](evidence/review.txt) found no concrete blocker.

The documentation build uses `lake -R -Kenv=dev build HoTTLean:docs`.
The [dependency record](evidence/dependency-pins.txt) lists both configurations.
All 15 Git dependency checkouts match their selected revisions and have clean
tracked sources, as recorded in the [checkout check](evidence/dependency-checkouts.txt).
After the documentation build, restore the original default manifest exactly.
Reload it with `lake -R env lean --version` before the three main checks.
The final default manifest matches Unity's manifest byte for byte.
The documentation and default builds use identical Lean source files.

The generated index and unstructured interpretation page exist in `.lake/build/doc/`.
The generated source links use `20c4b230`, the checked source commit.

## Scope and remaining limits

The production sources retain the three existing proof holes in `ForPoly.lean`.
They retain the three custom prelude axioms and three syntax injectivity axioms.
The tests retain their theory axioms and the intentional warning-test proof hole.
Dependency proof holes are not repaired by this migration.

The checks use a local Linux environment and cached dependencies.
They do not establish a whole-dependency cold build, external consumer
compatibility, or cross-version semantic equivalence.
Obsolete notes, attic files, benchmarks, and inactive draft regions are outside
the declared build scope.
The blueprint, Jekyll site, and remote CI are not part of these checks.
API documentation is a local artifact. It is not published.

The earlier migration and its evidence remain in Git at `6f719862`.
The Unity-only source remains in Git at `39e8eb63`.
The combined check logs describe the new source, not either earlier snapshot.
