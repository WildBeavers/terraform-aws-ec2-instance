.PHONY: changelog release

all: documentation

define print_info
  @echo "                         ##############################################"
  @echo "$$(date  ${DATE_FORMAT}) ### INFO - $(1)"
  @echo "                         ##############################################"
endef

changelog:
	git-chglog -o CHANGELOG.md --next-tag `semtag final -s minor -o`

release:
	semtag final -s minor

documentation:
	$(call print_info, "Generating documentation")
	# generating input parameter documentation
	mkdir -p ./tmp/variables
	cp variables.tf ./tmp/variables/
	terraform-docs markdown table --no-escape --sort-inputs-by-required --with-aggregate-type-defaults --no-providers --indent 1 --no-outputs ./tmp/variables > docs/user/variables.md
	git add docs/user/variables.md

	# generating output parameter documentation
	mkdir -p ./tmp/outputs
	cp outputs.tf ./tmp/outputs/
	terraform-docs markdown table --no-escape --sort-inputs-by-required --with-aggregate-type-defaults --no-providers --indent 1 --no-inputs ./tmp/outputs/ > docs/user/outputs.md
	git add docs/user/outputs.md
