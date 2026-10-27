# Workflow change record

The requested first method is the Unity bump pipeline.
The alternate method is compiler repair in dependency order.

Unity creates its target worktree from a clean Git commit.
Its dependency option accepts a version or commit, but not a repository URL.
Thus, prepare and commit the Poly URL change before the bump command.
Also select the matching documentation dependency.
Let Unity change the Lean toolchain and run dependency resolution.

The default build does not include every CI target.
Add the NaturalModel modules and test modules to the Unity run.
After integration, run the three CI build commands in the main checkout.

The initial setup failed during an old toolchain download.
Use the installed target toolchain for the bump operation.
Keep the error and the later command results in the change records.
