# Developer Documentation

## Generating the documentation

The commandline application 
[terraform-docs](https://github.com/segmentio/terraform-docs) is used for
generating documentation from the files [`variables.tf`](../../variables.tf)
and [`outputs.tf`](../../outputs.tf).

Download the latest version (at least v0.8.2) 
from the [release](https://github.com/segmentio/terraform-docs/releases) page or
use the [installation](https://github.com/segmentio/terraform-docs#installation)
instructions.

### Using terraform-docs

The [Makefile](../../Makefile) contains a target `documentation`
for generating the documentation and adding the files to git.

      make
      # or
      make documentation 

## Releasing a new version

1.  re-generate documentation: `make`
1.  check status of [issues](https://github.com/WildBeavers/terraform-aws-ec2-instance/issues) 
    vs. [CHANGELOG.md](../../CHANGELOG.md) vs. milestone `next`
1.  change `Title` of milestone `next` to release version and close it
1.  update [CHANGELOG.md](../../CHANGELOG.md):
    * add heading for new release version, e.g.

          <a name="v2.7.0"></a>
          ## [v2.7.0] - 2019-09-06
    * update diff links at the end of the document
1.  after the changes have been committed, create a release tag
    (`vMajor.Minor.Patch`)
1.  create new milestone `next`
