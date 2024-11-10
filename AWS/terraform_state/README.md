# Managing Terraform State

## Manipulating the state file
It is sometimes necessary to directly interact with the state file, either to check its contents, remove items when they have been imported incorrectly or no longer exist in the real infrastructure, or import items that already exist to bring them under Terraform management.

The terraform state command can be used to perform advanced state management. All state management commands that modify the state create a timestamped backup of the state prior to making modifications.

## Useful terraform state commands

**terraform state list** — List the resources of the state file.
**terraform state rm** — Remove an item from the state file.
**terraform state show** — Show a resource in the state file.
**terraform state mv** — move an item in the state.
**terraform state pull** — pull current state and output to stdout.
**terraform state replace-prodicer** — replace provider in the state.