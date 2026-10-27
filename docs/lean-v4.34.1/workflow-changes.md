# Workflow change record

The migration first used Unity with three Codex models.
It switched to a separate compiler repair procedure after a configuration task error.
The [Unity change record](unity-changes.md) records that error and the local Unity repair.
The [HoTTLean change record](hottlean-changes.md) records the source changes and target results.

## Prepare the source and validation scope

Unity created its target worktree from a clean Git commit.
Its dependency option accepted a version or commit, but no repository URL.
The input commit therefore selected the Poly fork before the bump command.
It also selected doc-gen4 v4.34.1 for the optional documentation configuration.
Unity changed the toolchain and resolved the dependencies.

The validation scope included the default library, NaturalModel, and Groupoids.UHom.
It also included all four test modules and the API documentation target.
The declared build scope excluded the existing attic and benchmark programs.
A default library build alone did not cover the complete validation scope.

The old test root conflicted with ProofWidgets.
The test files moved from `test` to `HoTTLeanTest`.
The new driver includes the unit-type test that the old umbrella omitted.
That test referenced the absent files `Model.Interpretation` and `Groupoids.NaturalModelBase`.
The repaired test uses the current unstructured groupoid model.
The absent model bridge remains outside this repair.
The test repair also removed a redundant identity-sequence proof hole.
An instance search confirmed that Lean already supplies that instance.
The test source retains one intentional guarded `sorry` and ten theory axioms.

## Stop the configuration loop

The first build exposed removed Mathlib import paths.
Unity accepted a six-file import repair after the inherited-path validator was repaired.
It also accepted the unit-type test import and namespace repair.
These changes exposed the declaration errors for the next stage.

The test root rename then required a configuration change.
Unity created replacement tasks but kept assigning the original task.
The replacement module lists retained the old names.
At the stop, the original task had five attempts and four replacement tasks had none.
The [state extract](evidence/unity-handoff.txt) records the task states and clean stop.
The controller's exit status 0 confirmed the stop, not a successful project build.

The accepted Unity commits and fetched build cache were retained.
The compiler repair procedure continued in the main checkout.
It did not change Unity's scheduling or collaboration features.

## Divide the compiler repairs

The three agents first owned separate file groups.
Luna handled the test rename and small compatibility repairs.
Sol handled syntax, tactics, the typechecker, and the frontend.
Terra handled the remaining Mathlib compatibility files.
The coordinator handled models and integration.
The assignments changed as shared dependencies passed.

The central Grothendieck file blocked several groups.
One agent kept ownership of that source file.
Other agents tested separate proofs in temporary copies.
The owner then added the tested proofs to the source.
This method kept one writer for each source file.
Module builds checked local repairs. Complete builds checked the combined result.
The repair retained the mathematical statements, axioms, and existing production holes.
It added no proof hole.

The cloven isofibration file imported pi type declarations that it did not use.
Its import now names the required unstructured groupoid model.
This permitted independent checks of the identity and pi type files.
Both files remained in the project build scope.

## Check compatibility and generated code

The local `functor_map` source compiled before its generated declarations were checked.
A natural model build then exposed an invalid universe parameter assumption.
The new `Quiver.Hom` parameters required a repair in the generator.
The [probe](evidence/FunctorMapProbe.lean) invokes the attribute, nested attributes,
and the term elaborator.
Its [log](evidence/functor-map-probe.txt) records the generated declarations.

The free groupoid compatibility module compiled with the upstream construction.
A dependent model build then exposed a missing limits instance.
The upstream import supplied the adjunction but not that instance.
The repair restored the instance and checked its dependent modules.

Some proofs needed explicit reductions before simplification.
Other proofs needed heterogeneous equality for dependent morphisms and category structures.
These repairs retained the original equalities and kernel checks.
The polynomial support file retained its original three proof holes.

## Inspect complete verification results

One pi type probe had an open goal at the start of an equality witness.
A check of only the later edited lines missed that error.
The complete module build found the remaining goals during integration.
The final checks inspect the complete error list and the process exit status.
A partial line range cannot establish that a declaration passed.

An interrupted Unity test run was not counted as a successful check.
The [Unity test log](evidence/unity-fix-tests.txt) distinguishes completed suites
from the default-toolchain oracle failure and the selected-toolchain rerun.
Earlier checks of three frontend test modules did not establish success of all four tests.

The compiler reported unused simplifier arguments and deprecated declarations.
The repair removed 291 unused simplifier arguments and replaced deprecated lemma names.
It added no linter suppression.
The default build then passed with 1023 jobs.
Its warning count fell from 401 to 93.
The final interpretation cleanup reduced that count to 92.

The documentation generator and the project API documentation command completed.
The API command used `lake -R -Kenv=dev build HoTTLean:docs` and passed with 2234 jobs.
Its 43 generator warnings came from dependencies.
No generator warning came from HoTTLean.
Some equational lemma metadata was missing.
The [HoTTLean change record](hottlean-changes.md) contains the final repeated checks
after the test repairs and warning cleanup.

## Support the model universe levels

The added unit type test exposed a restriction in the unstructured interpreter.
Its context representation forced the object and morphism universes to be equal.
The groupoid model has different object and morphism universes.

Give the interpreter independent universe parameters.
Place extension sequences and contextual objects in `Type (max u v)`.
The standard monadic notation still required one universe for context interpretation.
Use the universe-polymorphic `Part.bind` and `Part.map` operations there.
Update the context membership proof for the explicit map operation.
The interpretation module and all four tests then passed without a new proof hole.

## Restore the default configuration

The API documentation check used the optional development dependencies.
A later `lake update` reused the cached development configuration.
A manifest comparison detected that the documentation packages were still present.
Reload the configuration with `lake -R update`.
The default package set then matched the saved manifest.
All default dependency commits and paths stayed the same.
The [update log](evidence/default-update-final.txt) records the reset.
The [manifest record](evidence/dependency-pins.txt) contains the resolved configurations.

The final default build passed with 1023 jobs.
The natural model build passed with 1029 jobs.
All four tests passed through the 1027-job test driver.
The three compatibility modules passed with 650 jobs.
The API documentation check passed with 2245 jobs on the final source.
The generated tactic probe, source style checks, and whitespace check also passed.
The [final check table](hottlean-changes.md#final-checks) links the commands and output.
The [source audit](evidence/source-audit.txt) and [warning index](evidence/warnings-final.txt)
record the remaining proof holes, axioms, and diagnostics.
