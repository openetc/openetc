#!/usr/bin/env sh
# generate documentation only for OpenETC and ethcore libraries

cargo doc --no-deps --verbose --all &&
	echo '<meta http-equiv=refresh content=0;url=ethcore/index.html>' > target/doc/index.html
