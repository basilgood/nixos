{ buildEnv, makeWrapper, lib, buildPythonPackage, fetchPypi, pytest, attrs, py
, setuptools, six, more-itertools, atomicwrites, funcsigs, pluggy
, djangorestframework, parsimonious, redis, ua-parser, setproctitle, enum34
, cryptography, lxml, cssselect, cssutils, semaphore }:
let
  customPackages = {
    pytest = pytest.overridePythonAttrs (old: rec {
      src = fetchPypi {
        version = "3.5.0";
        pname = "pytest";
        sha256 = "1q832zd07zak2lyxbycxjydh0jp7y3hvawjqzlvra6aghz8r3r7s";
      };

      propagatedBuildInputs = [
        attrs
        py
        setuptools
        six
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
  };
in buildPythonPackage rec {
  pname = "sentry";
  version = "9.1.2";
  src = fetchPypi {
    inherit pname version;
    format = "wheel";
    python = "py27";
    sha256 = "c326fe1766f10e71cff813d0dd1ea120abbd94af720b7c0a56cffef8c041b3e6";
  };
  format = "wheel";

  propagatedBuildInputs = [

    (djangorestframework.overridePythonAttrs (old: rec {
      src = fetchPypi {
        version = "2.4.8";
        pname = "djangorestframework";
        sha256 = "1amphhzqya7yidar0zb0frzirrc521hpn6v3042wcpl1wxd702v4";
      };
      propagatedBuildInputs = [ customPackages.django ];
    }))

    (buildPythonPackage rec {
      pname = "mmh3";
      version = "2.3.1";
      src = fetchPypi {
        inherit pname version;
        sha256 = "0a795lk2gqj5ar0diwpd0gsgycv83pwlr0a91fki2ch9giaw7bgc";
      };
    })

    (buildPythonPackage rec {
      pname = "email_reply_parser";
      version = "0.2.0";
      src = fetchPypi {
        inherit pname version;
        sha256 = "0rlhsvs1ii93fq2774dn45gwfqgwx1f4fv4k27v1zr0h1zj9il1z";
      };
      doCheck = false;
    })

    (buildPythonPackage rec {
      pname = "uwsgi";
      version = "2.0.18";
      src = fetchPypi {
        inherit pname version;
        sha256 = "10zmk4npknigmbqcq1wmhd461dk93159px172112vyq0i19sqwj9";
      };
      doCheck = false;
    })

    (buildPythonPackage rec {
      pname = "python-openid";
      version = "2.2.5";
      src = fetchPypi {
        inherit pname version;
        sha256 = "1vvhxlghjan01snfdc4k7ykd80vkyjgizwgg9bncnin8rqz1ricj";
      };
      doCheck = false;
    })

    (parsimonious.overridePythonAttrs (old: rec {
      src = fetchPypi {
        version = "0.8.0";
        pname = "parsimonious";
        sha256 = "0sq81p00vsilvwyqpzp66vwbygp791bmyfii4hzp0mvf5bbnj25f";
      };
    }))
    (buildPythonPackage rec {
      pname = "rb";
      version = "1.7";
      src = fetchPypi {
        inherit pname version;
        sha256 = "1sjqia19dap042idbdibyqa951gck64jqgbxp78ammgxcnnaq499";
      };
      doCheck = false;
      propagatedBuildInputs = [ redis ];
    })

    (ua-parser.overridePythonAttrs (old: rec {
      src = fetchPypi {
        version = "0.6.1";
        pname = "ua-parser";
        sha256 = "1ygkvwphzf22yf7izwn5w930a4qimkziphmaw97vjxn8jghf8fbs";
      };
    }))

    (buildPythonPackage rec {
      pname = "loremipsum";
      version = "1.0.5";
      src = fetchPypi {
        inherit pname version;
        sha256 = "1x9sabp50zyi2j8dkpxgdkcnj5wrbd4w1v15zsnjpxf30n9wcjdq";
      };
      doCheck = false;
    })

    setproctitle

    (buildPythonPackage rec {
      pname = "python-u2flib-server";
      version = "4.0.1";
      src = fetchPypi {
        inherit pname version;
        sha256 = "02q0zwfkwmvb8cdymkvi7zbrwlkab92kqz8s4v70cys003z2a10n";
      };
      doCheck = false;
      propagatedBuildInputs = [ six enum34 cryptography lxml ];
    })

    customPackages.pytest

    (buildPythonPackage rec {
      pname = "pytest-html";
      version = "1.9.0";
      src = fetchPypi {
        inherit pname version;
        sha256 = "19aa0w6665vsnh0dy3njcpjl4jm29mk5llai731506djpmk9ik5f";
      };
      doCheck = false;
      propagatedBuildInputs = [ customPackages.pytest ];
    })

    (buildPythonPackage rec {
      pname = "toronado";
      version = "0.0.11";
      src = fetchPypi {
        inherit pname version;
        sha256 = "1a5hvn9fhhkbkdsqr9fw4jhvd7vhhrd4a06nf89zlsf92fddr1br";
      };
      doCheck = false;
      propagatedBuildInputs = [ lxml cssselect cssutils ];
    })

    customPackages.django

    semaphore
  ];
}
