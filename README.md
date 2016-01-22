# terraform-stuff

zOMG it's Terraform stuff!

There are some significant parts of what go into a successful `terraform apply`
that *do not* live in this repository.  Inspection of the
[`Makefile`](./Makefile) will show that files in `./cloud-init` expected by the
terraform configs such as `gce.tf` are not stored in Git, but instead are
expected to be generated.  This is because the secrets live elsewhere.

## `travis-worker`

The minimum inputs needed for a given travis-worker `./cloud-init` file are the
corresponding file in `./envs` and the `travis-worker.bash.in` file.  The env file
must be provided and should be line-separated environment variable declarations
suitable for an `/etc/default/travis-worker` file.

## Atlas state

We store the Terraform state in Atlas. To set up:

    make terraform-config
