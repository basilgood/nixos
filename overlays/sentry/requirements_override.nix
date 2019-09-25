{ pkgs, python }:

self: super: {

  "pluggy" = python.overrideDerivation super."pluggy" (old: {
    buildInputs = old.buildInputs ++ [ self."setuptools-scm" ];
  });
  "jsonschema" = python.overrideDerivation super."jsonschema" (old: {
    buildInputs = old.buildInputs ++ [ self."setuptools-scm" ];
  });
  # "pytest" = python.overrideDerivation super."pytest" (old: {
  #   buildInputs = old.buildInputs ++ [ self."setuptools-scm" ];
  # });

  "urllib3" = python.overrideDerivation super."urllib3" (old: {
    buildInputs = old.buildInputs ++ [ self."pyyaml" ];
  });

  "ua-parser" = python.overrideDerivation super."ua-parser" (old: {
    buildInputs = old.buildInputs ++ [ self."pyyaml" ];
  });
  # "pytest" = with pkgs.python27Packages; pytest.overridePythonAttrs (old: rec {
  #   pname = "pytest";
  #   version = "3.5.1";
  #   src = fetchPypi {
  #     inherit pname version;
  #     sha256 = "1s1qj0xwh3nagwp59plrwnsn1szakaqi4fkhy1pxnf3mr4k3nwal";
  #   };
  # });
}
