# HoTTLean change record

The target Lean version is v4.34.1. The initial commit is `31133dd`.
The initial Lean version is v4.25.0-rc2.

Use the Poly fork at <https://github.com/sosudo/Poly>.
The selected commit is `cc08a1f77c20e07a7366f0824ecd36ae472c0377`.
This commit uses Lean v4.34.1 and Mathlib v4.34.1.
It includes a local copy of checkdecls with the same Lean version.
Remove the direct checkdecls requirement. Use the copy from Poly.
Change the optional doc-gen4 version to v4.34.1.

These changes prepare the input for Unity. No build has passed yet.

The initial production sources contain three `sorry` terms and six axioms.
The three `sorry` terms are in `HoTTLean/ForPoly.lean`.
The axioms include three injectivity axioms and three theory constants.
The test sources also contain intentional holes and theory axioms.
The `attic` directory is not part of the declared build targets.

The required checks are `lake build`, `lake build NaturalModel`, and `lake test`.
The documentation configuration also needs a check.

This work uses [Unity](https://github.com/sosudo/unity).
