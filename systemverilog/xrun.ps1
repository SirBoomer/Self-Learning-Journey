param([string]$name)
xvlog -sv "$name.sv"
if ($LASTEXITCODE -ne 0) { Write-Host "xvlog failed - not running"; exit 1 }
xelab $name -debug typical -s "${name}_sim"
if ($LASTEXITCODE -ne 0) { Write-Host "xelab failed - not running"; exit 1 }
xsim "${name}_sim" -runall