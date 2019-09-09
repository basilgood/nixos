self: super:
with super; rec {

  pluggy = super.pluggy.overridePythonAttrs (old: rec {
    pname = "pluggy";
    version = "0.6.0";
    src = fetchPypi {
      inherit pname version;
      sha256 = "1zqckndfn85l1cd8pndw212zg1bq9fkg1nnj32kp2mppppsyg2kz";
    };
  });

  six = super.six.overridePythonAttrs (old: rec {
    pname = "six";
    version = "1.10.0";
    src = fetchPypi {
      inherit pname version;
      sha256 = "1scqzwc51c875z23phj48gircqjgnn3af8zy2izjwmnlxrxsgs3h";
    };
    checkPhase = false;
  });

  pytest = super.pytest.overridePythonAttrs (old: rec {
    pname = "pytest";
    version = "3.5.1";
    src = fetchPypi {
      inherit pname version;
      sha256 = "1s1qj0xwh3nagwp59plrwnsn1szakaqi4fkhy1pxnf3mr4k3nwal";
    };
  });

  pytestcov = super.pytestcov.overridePythonAttrs (old: rec {
    pname = "pytest-cov";
    version = "2.4.0";
    src = fetchPypi {
      inherit pname version;
      sha256 = "03c2qc42r4bczyw93gd7n0qi1h1jfhw7fnbhi33c3vp1hs81gm2k";
    };
  });

  django = (buildPythonPackage rec {
    pname = "Django";
    version = "1.6.11";
    src = fetchPypi {
      inherit pname version;
      sha256 = "0misvia78c14y07zs5xsb9lv54q0v217jpaindrmhhw4wiryal3y";
    };
    doCheck = false;
    propagatedBuildInputs = [ ];
  });

  redis = buildPythonPackage rec {
    pname = "redis";
    version = "2.10.3";

    src = fetchPypi {
      inherit pname version;
      sha256 = "1701qjwn4n05q90fdg4bsg96s27xf5s4hsb4gxhv3xk052q3gyx4";
    };
    doCheck = false;
  };

  djangorestframework = super.djangorestframework.overridePythonAttrs
    (old: rec {
      pname = "djangorestframework";
      version = "2.4.8";
      src = fetchPypi {
        inherit pname version;
        sha256 = "1amphhzqya7yidar0zb0frzirrc521hpn6v3042wcpl1wxd702v4";
      };
    });

  pillow = super.pillow.overridePythonAttrs (old: rec {
    pname = "Pillow";
    version = "4.2.1";
    src = fetchPypi {
      inherit pname version;
      sha256 = "0wq0fiw964bj5rdmw66mhbfsjnmb13bcdr42krpk2ig5f1cgc967";
    };
    doCheck = false;
  });

  ua-parser = super.ua-parser.overridePythonAttrs (old: rec {
    version = "0.6.1";
    pname = "ua-parser";
    src = fetchPypi {
      inherit pname version;
      sha256 = "1ygkvwphzf22yf7izwn5w930a4qimkziphmaw97vjxn8jghf8fbs";
    };
  });

  parsimonious = super.parsimonious.overridePythonAttrs (old: rec {
    pname = "parsimonious";
    version = "0.8.0";
    src = fetchPypi {
      inherit pname version;
      sha256 = "0sq81p00vsilvwyqpzp66vwbygp791bmyfii4hzp0mvf5bbnj25f";
    };
  });

  msgpack = super.msgpack.overridePythonAttrs (old: rec { doCheck = false; });

  pycodestyle = super.pycodestyle.overridePythonAttrs (old: rec {
    pname = "pycodestyle";
    version = "2.3.1";

    src = fetchPypi {
      inherit pname version;
      sha256 = "0rk78b66p57ala26mdldl9lafr48blv5s659sah9q50qnfjmc8k8";
    };
  });
  pyflakes = super.pyflakes.overridePythonAttrs (old: rec {
    pname = "pyflakes";
    version = "1.6.0";
    src = fetchPypi {
      inherit pname version;
      sha256 = "01c87qiadz71sbqrclrsr85vx601p20g4hs7nlcvyg945ww6lqcd";
    };
  });

  flake8 = super.flake8.overridePythonAttrs (old: rec {
    pname = "flake8";
    version = "3.5.0";
    src = fetchPypi {
      inherit pname version;
      sha256 = "184b33grvvjmiwlv9kyd7yng9qv5ld24154j70z332xxg9gjclvj";
    };
  });

  urllib3 = super.flake8.overridePythonAttrs (old: rec {
    pname = "urllib3";
    version = "1.24.2";

    src = fetchPypi {
      inherit pname version;
      sha256 = "1hwscrsw77vbkzdbw0db74zzf1135521wwccngnlz73hvxrp494s";
    };
    checkPhase = false;
  });

  pytest_xdist = super.pytest_xdist.overridePythonAttrs (old: rec {
    pname = "pytest-xdist";
    version = "1.24.1";

    src = fetchPypi {
      inherit pname version;
      sha256 = "1pi375z0c0gv7ripidh7hh4dlc1b25mc2n4diai6h7mjplwbk6wh";
    };
  });

  idna = super.idna.overridePythonAttrs (old: rec {
    pname = "idna";
    version = "2.7";
    src = fetchPypi {
      inherit pname version;
      sha256 = "05jam7d31767dr12x0rbvvs8lxnpb1mhdb2zdlfxgh83z6k3hjk8";
    };
  });

  hypothesis = super.hypothesis.overridePythonAttrs (old: rec {
    pname = "hypothesis";
    version = "1.11.4";
    src = fetchPypi {
      inherit pname version;
      sha256 = "00snccw4ybhfqzcjrpn8x6ggc7fmq78g58wcmhpdwfn4wkfvds0z";
    };
    postUnpack = "";

    checkPhase = false;
  });

  cryptography = super.cryptography.overridePythonAttrs (old: rec {
    pname = "cryptography";
    version = "1.3.4";

    src = fetchPypi {
      inherit pname version;
      sha256 = "1a85l548w5vvq3yhz0az7ajg2ijixzp6gagapw6wgrqvq28ghgs2";
    };

    propagatedBuildInputs = old.propagatedBuildInputs
      ++ [ idna pyasn1 pyasn1-modules ];
    doCheck = false;
  });

  cryptography_vectors = super.cryptography_vectors.overridePythonAttrs
    (old: rec {
      pname = "cryptography_vectors";
      version = "1.3.4";

      src = fetchPypi {
        inherit pname version;
        sha256 = "15h1iz2klnpb4f8djxy7cpbnyn3wbjp7bnj4pz6s7w6plghbq524";
      };
    });

  botocore = super.botocore.overridePythonAttrs (old: rec {
    pname = "botocore";
    version = "1.5.70";
    src = fetchPypi {
      inherit pname version;
      sha256 = "1wngbi4n9gchdrz65g5n9ny3b3j2m2gxbl5ms601d9sgc5aixvma";
    };
  });

  boto3 = super.boto3.overridePythonAttrs (old: rec {
    pname = "boto3";
    version = "1.4.5";
    src = fetchPypi {
      inherit pname version;
      sha256 = "07c3364s071p3w6vgz4c7s0b56dqhi2vpbxbx4sjps4jyvq0smvd";
    };
  });

  requests = super.requests.overridePythonAttrs (old: rec {
    pname = "requests";
    version = "2.14.0";
    src = fetchPypi {
      inherit pname version;
      sha256 = "1hi2m3r1sdvckbm42sqsq8ldp5snlxjsmx7ggjnnnjnbb627fkwc";
    };
  });

  packaging = super.packaging.overridePythonAttrs (old: rec {
    pname = "packaging";
    version = "14.0";
    src = fetchPypi {
      inherit pname version;
      sha256 = "18hyvrzm24sksqpbs1486fh52ca0il3bd5kp8khmj7wld36nxww9";
    };
  });

  chardet = super.chardet.overridePythonAttrs (old: rec { doCheck = false; });

  sphinx = super.sphinx.overridePythonAttrs (old: rec {
    propagatedBuildInputs = old.propagatedBuildInputs ++ [ packaging ];
  });

  progressbar2 = super.progressbar2.overridePythonAttrs (old: rec {
    pname = "progressbar2";
    version = "3.10.0";
    src = fetchPypi {
      inherit pname version;
      sha256 = "0h506iz9mz9qfxdq9xp1ccq5gkb1mn5i98d6wbgdiamxarzvhzyd";
    };
    postPatch = false;
    checkPhase = false;
  });

  python-u2flib-server = buildPythonPackage rec {
    pname = "python-u2flib-server";
    version = "4.0.1";
    src = fetchPypi {
      inherit pname version;
      sha256 = "02q0zwfkwmvb8cdymkvi7zbrwlkab92kqz8s4v70cys003z2a10n";
    };
    doCheck = false;
    propagatedBuildInputs = [ six enum34 cryptography lxml ];
  };

  querystring_parser = buildPythonPackage rec {
    pname = "querystring_parser";
    version = "1.2.4";
    src = fetchPypi {
      inherit pname version;
      sha256 = "0qlar8a0wa003hm2z6wcpb625r6vjj0a70rsni9h8lz0zwfcwkv4";
    };
    doCheck = false;
    propagatedBuildInputs = [ six ];
  };

  qrcode = super.qrcode.overridePythonAttrs (old: rec {
    pname = "qrcode";
    version = "5.3";
    src = fetchPypi {
      inherit pname version;
      sha256 = "0kljfrfq0c2rmxf8am57333ia41kd0snbm2rnqbdy816hgpcq5a1";
    };
  });
}
