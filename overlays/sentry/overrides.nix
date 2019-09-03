self: super:
let
  six_1_10 = with super;
    six.overridePythonAttrs (old: rec {
      pname = "six";
      version = "1.10.0";
      src = fetchPypi {
        inherit pname version;
        sha256 = "1scqzwc51c875z23phj48gircqjgnn3af8zy2izjwmnlxrxsgs3h";
      };
      doCheck = false;
      propagatedBuildInputs = [ ];
    });
in with super; {
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

  djangorestframework = djangorestframework.overridePythonAttrs (old: rec {
    src = fetchPypi {
      version = "2.4.8";
      pname = "djangorestframework";
      sha256 = "1amphhzqya7yidar0zb0frzirrc521hpn6v3042wcpl1wxd702v4";
    };
    propagatedBuildInputs = [ self.django ];
  });

  pillow = pillow.overridePythonAttrs (old: rec {
    pname = "Pillow";
    version = "4.2.1";
    src = fetchPypi {
      inherit pname version;
      sha256 = "0wq0fiw964bj5rdmw66mhbfsjnmb13bcdr42krpk2ig5f1cgc967";
    };
    doCheck = false;
    propagatedBuildInputs = [ olefile ];
  });

  six = six_1_10;

  pytest = pytest.overridePythonAttrs (old: rec {
    src = fetchPypi {
      version = "3.6.0";
      pname = "pytest";
      sha256 = "0bdfazvjjbxssqzyvkb3m2x2in7xv56ipr899l00s87k7815sm9r";
    };

    propagatedBuildInputs = [
      attrs
      py
      setuptools
      six_1_10
      more-itertools
      atomicwrites

      funcsigs
      (pluggy.overridePythonAttrs (old: rec {
        pname = "pluggy";
        version = "0.5.0";
        src = fetchPypi {
          inherit pname version;
          sha256 = "0v5qcz1m8jhr7r3n24fp77jlxwk2y3m95vbdgz1z73695fw0bqlr";
        };
      }))
    ];
    doCheck = false;
  });

  whoosh = whoosh.overridePythonAttrs (old: rec {
    pname = "Whoosh";
    version = "2.7.4";
    doCheck = false;
  });

  ua-parser = ua-parser.overridePythonAttrs (old: rec {
    src = fetchPypi {
      version = "0.6.1";
      pname = "ua-parser";
      sha256 = "1ygkvwphzf22yf7izwn5w930a4qimkziphmaw97vjxn8jghf8fbs";
    };
  });

  parsimonious = parsimonious.overridePythonAttrs (old: rec {
    src = fetchPypi {
      version = "0.8.0";
      pname = "parsimonious";
      sha256 = "0sq81p00vsilvwyqpzp66vwbygp791bmyfii4hzp0mvf5bbnj25f";
    };
  });
}
