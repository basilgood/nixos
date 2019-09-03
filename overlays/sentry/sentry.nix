{ buildEnv, makeWrapper, lib, buildPythonPackage, fetchPypi, djangorestframework
, parsimonious, redis, ua-parser, setproctitle, enum34, cryptography, lxml
, cssselect, cssutils, semaphore, dateutil, requests, pytestrunner, python-utils
, sentry-sdk, jmespath, docutils, urllib3, zlib, msgpack, unidiff, httplib2, six
, pytest, django, pillow, mistune, py }:

buildPythonPackage rec {
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
    djangorestframework

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

    parsimonious

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

    ua-parser

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

    pytest

    (buildPythonPackage rec {
      pname = "pytest-html";
      version = "1.9.0";
      src = fetchPypi {
        inherit pname version;
        sha256 = "19aa0w6665vsnh0dy3njcpjl4jm29mk5llai731506djpmk9ik5f";
      };
      doCheck = false;
      propagatedBuildInputs = [ pytest ];
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

    django

    semaphore

    (buildPythonPackage rec {
      pname = "qrcode";
      version = "5.3";
      src = fetchPypi {
        inherit pname version;
        sha256 = "0kljfrfq0c2rmxf8am57333ia41kd0snbm2rnqbdy816hgpcq5a1";
      };
      doCheck = false;
      propagatedBuildInputs = [ six ];
    })

    (buildPythonPackage rec {
      pname = "croniter";
      version = "0.3.30";
      src = fetchPypi {
        inherit pname version;
        sha256 = "1405lnw9cwpf8q0yvx2zq9jdf80n8i69gny6vqy6r0gplyrxx2jk";
      };
      doCheck = false;
      propagatedBuildInputs = [ dateutil ];
    })

    (buildPythonPackage rec {
      pname = "percy";
      version = "2.0.2";
      src = fetchPypi {
        inherit pname version;
        sha256 = "07821yabrqjyg0z45xlm4vz4hgm4gs7p7mqa3hi5ryh1qhnn2f32";
      };
      doCheck = false;
      propagatedBuildInputs = [ requests ];
    })

    (buildPythonPackage rec {
      pname = "querystring_parser";
      version = "1.2.4";
      src = fetchPypi {
        inherit pname version;
        sha256 = "0qlar8a0wa003hm2z6wcpb625r6vjj0a70rsni9h8lz0zwfcwkv4";
      };
      doCheck = false;
      propagatedBuildInputs = [ six ];
    })

    (buildPythonPackage rec {
      pname = "progressbar2";
      version = "3.10.0";
      src = fetchPypi {
        inherit pname version;
        sha256 = "0h506iz9mz9qfxdq9xp1ccq5gkb1mn5i98d6wbgdiamxarzvhzyd";
      };
      doCheck = false;
      propagatedBuildInputs = [ pytestrunner python-utils ];
    })

    (buildPythonPackage rec {
      pname = "honcho";
      version = "1.0.1";
      src = fetchPypi {
        inherit pname version;
        sha256 = "0vpadk37y27m98x9lk151k96vp319w7jv8f6hdr7fdz3s8m412f1";
      };
      doCheck = false;
    })

    (buildPythonPackage rec {
      pname = "botocore";
      version = "1.5.70";
      src = fetchPypi {
        inherit pname version;
        sha256 = "1wngbi4n9gchdrz65g5n9ny3b3j2m2gxbl5ms601d9sgc5aixvma";
      };
      doCheck = false;
      propagatedBuildInputs = [ dateutil jmespath docutils urllib3 ];
    })

    sentry-sdk

    redis

    pillow

    (buildPythonPackage rec {
      pname = "django-jsonfield";
      version = "0.9.13";
      src = fetchPypi {
        inherit pname version;
        sha256 = "0hwfg8ccqg2p86j57mql8iid3x38s5ppzpabbz6cb39zaka3vbhj";
      };
      doCheck = false;
    })

    msgpack
    unidiff

    (buildPythonPackage rec {
      pname = "django-templatetag-sugar";
      version = "1.0";
      src = fetchPypi {
        inherit pname version;
        sha256 = "0plss9p32g8nb0sa3v679pvhiqxz3071k1dk53rlq5vckxa31xp9";
      };
      doCheck = false;
    })

    (buildPythonPackage rec {
      pname = "django-picklefield";
      version = "0.3.2";
      src = fetchPypi {
        inherit pname version;
        sha256 = "1qlsbp3798ii68ny9zlz2ppkna00jf7i4hmjal3p8433gi18md7s";
      };
      doCheck = false;
    })

    (buildPythonPackage rec {
      pname = "oauth2";
      version = "1.5.211";
      src = fetchPypi {
        inherit pname version;
        sha256 = "08ad9jc0sjrl5q5cac1asyz41185pd673py41xn4kym19mkqz8w2";
      };
      doCheck = false;
      propagatedBuildInputs = [ httplib2 ];
    })

    mistune
    six

  ];
}
