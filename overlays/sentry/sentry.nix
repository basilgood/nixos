{ buildEnv, makeWrapper, lib, buildPythonPackage, fetchPypi, djangorestframework
, parsimonious, redis, ua-parser, setproctitle, enum34, cryptography, lxml
, cssselect, cssutils, semaphore, dateutil, requests, pytestrunner, python-utils
, sentry-sdk, jmespath, docutils, urllib3, zlib, msgpack, unidiff, httplib2, six
, pytest, django, pillow, mistune, botocore, boto3, progressbar2
, querystring_parser, python-u2flib-server, qrcode, memcached, statsd, click
, redis-py-cluster, strict-rfc3339, psycopg2-binary, celery }:

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

    python-u2flib-server

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
    qrcode

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
      version = "1.1.2";
      src = fetchPypi {
        inherit pname version;
        sha256 = "1ra7wanlkchpxhjzhx457c30db68x63qjmwizjg0phlc5h527m1k";
      };
      doCheck = false;
      propagatedBuildInputs = [ requests ];
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

    six

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
    botocore
    progressbar2
    querystring_parser
    memcached
    statsd
    click
    redis-py-cluster
    strict-rfc3339
    psycopg2-binary
    celery

  ];
}
