self: super: pkgs:
with super; rec {

  mmh3 = (buildPythonPackage rec {
    pname = "mmh3";
    version = "2.3.1";
    src = fetchPypi {
      inherit pname version;
      sha256 = "0a795lk2gqj5ar0diwpd0gsgycv83pwlr0a91fki2ch9giaw7bgc";
    };
  });

  email_reply_parser = (buildPythonPackage rec {
    pname = "email_reply_parser";
    version = "0.2.0";
    src = fetchPypi {
      inherit pname version;
      sha256 = "0rlhsvs1ii93fq2774dn45gwfqgwx1f4fv4k27v1zr0h1zj9il1z";
    };
    doCheck = false;
  });

  uwsgi = (buildPythonPackage rec {
    pname = "uwsgi";
    version = "2.0.18";
    src = fetchPypi {
      inherit pname version;
      sha256 = "10zmk4npknigmbqcq1wmhd461dk93159px172112vyq0i19sqwj9";
    };
    doCheck = false;
  });

  python-openid = (buildPythonPackage rec {
    pname = "python-openid";
    version = "2.2.5";
    src = fetchPypi {
      inherit pname version;
      sha256 = "1vvhxlghjan01snfdc4k7ykd80vkyjgizwgg9bncnin8rqz1ricj";
    };
    doCheck = false;
  });

  rb = (buildPythonPackage rec {
    pname = "rb";
    version = "1.7";
    src = fetchPypi {
      inherit pname version;
      sha256 = "1sjqia19dap042idbdibyqa951gck64jqgbxp78ammgxcnnaq499";
    };
    doCheck = false;
    propagatedBuildInputs = [ redis ];
  });

  loremipsum = (buildPythonPackage rec {
    pname = "loremipsum";
    version = "1.0.5";
    src = fetchPypi {
      inherit pname version;
      sha256 = "1x9sabp50zyi2j8dkpxgdkcnj5wrbd4w1v15zsnjpxf30n9wcjdq";
    };
    doCheck = false;
  });

  pytest-html = (buildPythonPackage rec {
    pname = "pytest-html";
    version = "1.9.0";
    src = fetchPypi {
      inherit pname version;
      sha256 = "19aa0w6665vsnh0dy3njcpjl4jm29mk5llai731506djpmk9ik5f";
    };
    doCheck = false;
    propagatedBuildInputs = [ pytest ];
  });

  toronado = (buildPythonPackage rec {
    pname = "toronado";
    version = "0.0.11";
    src = fetchPypi {
      inherit pname version;
      sha256 = "1a5hvn9fhhkbkdsqr9fw4jhvd7vhhrd4a06nf89zlsf92fddr1br";
    };
    doCheck = false;
    propagatedBuildInputs = [ lxml cssselect cssutils ];
  });

  croniter = (buildPythonPackage rec {
    pname = "croniter";
    version = "0.3.30";
    src = fetchPypi {
      inherit pname version;
      sha256 = "1405lnw9cwpf8q0yvx2zq9jdf80n8i69gny6vqy6r0gplyrxx2jk";
    };
    doCheck = false;
    propagatedBuildInputs = [ dateutil ];
  });

  percy = (buildPythonPackage rec {
    pname = "percy";
    version = "1.1.2";
    src = fetchPypi {
      inherit pname version;
      sha256 = "1ra7wanlkchpxhjzhx457c30db68x63qjmwizjg0phlc5h527m1k";
    };
    doCheck = false;
    propagatedBuildInputs = [ requests ];
  });

  honcho = (buildPythonPackage rec {
    pname = "honcho";
    version = "1.0.1";
    src = fetchPypi {
      inherit pname version;
      sha256 = "0vpadk37y27m98x9lk151k96vp319w7jv8f6hdr7fdz3s8m412f1";
    };
    doCheck = false;
  });

  django-jsonfield = (buildPythonPackage rec {
    pname = "django-jsonfield";
    version = "0.9.13";
    src = fetchPypi {
      inherit pname version;
      sha256 = "0hwfg8ccqg2p86j57mql8iid3x38s5ppzpabbz6cb39zaka3vbhj";
    };
    doCheck = false;
  });

  django-templatetag-sugar = (buildPythonPackage rec {
    pname = "django-templatetag-sugar";
    version = "1.0";
    src = fetchPypi {
      inherit pname version;
      sha256 = "0plss9p32g8nb0sa3v679pvhiqxz3071k1dk53rlq5vckxa31xp9";
    };
    doCheck = false;
  });

  django-picklefield = (buildPythonPackage rec {
    pname = "django-picklefield";
    version = "0.3.2";
    src = fetchPypi {
      inherit pname version;
      sha256 = "1qlsbp3798ii68ny9zlz2ppkna00jf7i4hmjal3p8433gi18md7s";
    };
    doCheck = false;
  });

  oauth2 = (buildPythonPackage rec {
    pname = "oauth2";
    version = "1.5.211";
    src = fetchPypi {
      inherit pname version;
      sha256 = "08ad9jc0sjrl5q5cac1asyz41185pd673py41xn4kym19mkqz8w2";
    };
    doCheck = false;
    propagatedBuildInputs = [ httplib2 ];
  });

  amqp = super.amqp.overridePythonAttrs (old: rec {
    pname = "amqp";
    version = "1.4.9";

    src = fetchPypi {
      inherit pname version;
      sha256 = "06n6q0kxhjnbfz3vn8x9yz09lwmn1xi9d6wxp31h5jbks0b4vsid";
    };
  });

  anyjson = super.anyjson.overridePythonAttrs (old: rec {
    pname = "anyjson";
    version = "0.3.3";

    src = fetchPypi {
      inherit pname version;
      sha256 = "1fjph4alvcscsl5d4b6qpv1yh31jy05jxi1l0xff7lws7j32v09p";
    };
  });

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
      sha256 = "0snmb8xffb3vsma0z67i0h0w2g2dy0p3gsgh9gi4i0kgc5l8spqh";
    };
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
    version = "2.6.0";
    src = fetchPypi {
      inherit pname version;
      sha256 = "0qnpp9y3ygx4jk4pf5ad71fh2skbvnr6gl54m7rg5qysnx4g0q73";
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
  });

  django-sudo = (buildPythonPackage rec {
    pname = "django-sudo";
    version = "2.1.0";
    src = fetchPypi {
      inherit pname version;
      sha256 = "19j7001xwwilws46m34isrq885w43ida4k0q4jgz9z3x28032nip";
    };
    doCheck = false;
  });

  django-crispy-forms = (buildPythonPackage rec {
    pname = "django-crispy-forms";
    version = "1.4.0";
    src = fetchPypi {
      inherit pname version;
      sha256 = "040m50ypf7c97rx8zkglwci6acmb5zn7gri5yraw53gzplg57jfh";
    };
    doCheck = false;
  });

  pytest-django = (buildPythonPackage rec {
    pname = "pytest-django";
    version = "2.9.1";
    src = fetchPypi {
      inherit pname version;
      sha256 = "1mmc7zsz3dlhs6sx4sppkj1vgshabi362r1a8b8wpj1qfximpqcb";
    };
    doCheck = false;
    buildInputs = [ setuptools-scm180 pytest ];
  });

  setuptools-scm180 = buildPythonPackage rec {
    pname = "setuptools_scm";
    version = "1.8.0";
    src = fetchPypi {
      inherit pname version;
      sha256 = "106f6y3g3ckmd3cdlflck5nn1mh98x7hnr9d71d2l1lx31d9mhbb";
      extension = "zip";
    };
    doCheck = false;
  };

  setuptools-scm = buildPythonPackage rec {
    pname = "setuptools-scm";
    version = "3.3.3";
    src = fetchPypi {
      inherit pname version;
      sha256 = "1myrbdbjzm7gd5dfscri6irqv9mqjqfh9hgkbvm72yh34gw8hkyy";
    };
    doCheck = false;
  };

  redis = super.redis.overridePythonAttrs (old: rec {
    pname = "redis";
    version = "2.10.5";

    src = fetchPypi {
      inherit pname version;
      sha256 = "0csmrkxb29x7xs9b51zplwkkq2hwnbh9jns1g85dykn5rxmaxysx";
    };
  });

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

  cryptography =
    super.cryptography.overridePythonAttrs (old: rec { checkPhase = false; });

  boto3 = super.boto3.overridePythonAttrs (old: rec {
    pname = "boto3";
    version = "1.4.5";
    src = fetchPypi {
      inherit pname version;
      sha256 = "07c3364s071p3w6vgz4c7s0b56dqhi2vpbxbx4sjps4jyvq0smvd";
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

  requests = super.requests.overridePythonAttrs (old: rec {
    pname = "requests";
    version = "2.20.1";
    src = fetchPypi {
      inherit pname version;
      sha256 = "0qzj6cgv3k9wyj7wlxgz7xq0cfg4jbbkfm24pp8dnhczwl31527a";
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
    version = "3.10.1";
    src = fetchPypi {
      inherit pname version;
      sha256 = "0s9ixxgvjs66d1hm57hywb5gxqr4clq7mwq7iiln878wwjrnzx0b";
    };
    postPatch = false;
    checkInputs = old.checkInputs ++ [ hypothesis ];
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

  memcached = super.memcached.overridePythonAttrs (old: rec {
    pname = "python-memcached";
    version = "1.59";
    src = fetchPypi {
      inherit pname version;
      sha256 = "0kvyapavbirk2x3n1jx4yb9nyigrj1s3x15nm3qhpvhkpqvqdqm2";
    };
    propagatedBuildInputs = [ six ];
  });

  statsd = super.statsd.overridePythonAttrs (old: rec {
    pname = "statsd";
    version = "3.1";
    src = fetchPypi {
      inherit pname version;
      sha256 = "1vi8xx8hrgyhgcw3d3yc7bh4vfc48swlm0xwfp1994xf6gmmzbpv";
    };
  });

  click = super.click.overridePythonAttrs (old: rec {
    pname = "click";
    version = "6.7";
    src = fetchPypi {
      inherit pname version;
      sha256 = "02qkfpykbq35id8glfgwc38yc430427yd05z1wc5cnld8zgicmgi";
    };
  });

  redis-py-cluster = buildPythonPackage rec {
    pname = "redis-py-cluster";
    version = "1.3.4";
    src = fetchPypi {
      inherit pname version;
      sha256 = "0n7k4nqdryz1x34f5axbhj7xl6s1b6hlav02491nzy047bgdv29i";
    };
    doCheck = false;
    propagatedBuildInputs = [ redis ];
  };

  cssutils = super.cssutils.overridePythonAttrs (old: rec {
    pname = "cssutils";
    version = "0.9.9";
    src = fetchPypi {
      inherit pname version;
      sha256 = "139yfm9yz9k33kgqw4khsljs10rkhhxyywbq9i82bh2r31cil1pp";
      extension = "zip";
    };
  });

  psycopg2-binary = buildPythonPackage rec {
    pname = "psycopg2-binary";
    version = "2.7.4";
    src = fetchPypi {
      inherit pname version;
      sha256 = "1myrbdbjzm2gd3dfscri6irqv9mqjqfh9hgkbvm72yh34gw8hkyy";
    };
    doCheck = false;
    nativeBuildInputs = [ pkgs.postgresql ];
  };

  celery = super.celery.overridePythonAttrs (old: rec {
    pname = "celery";
    version = "3.1.18";
    src = fetchPypi {
      inherit pname version;
      sha256 = "1bry1qzb4gw0ni40w1pyzxl2d0rqbf688sdi13a5gz66f10gj909";
    };
    doCheck = false;
    checkInputs = [ ];
  });

  pycrypto = super.pycrypto.overridePythonAttrs (old: rec {
    pname = "pycrypto";
    version = "2.6.1";
    src = fetchPypi {
      inherit pname version;
      sha256 = "0g0ayql5b9mkjam8hym6zyg6bv77lbh66rv1fyvgqb17kfc1xkpj";
    };
  });

  sshpubkeys = super.sshpubkeys.overridePythonAttrs (old: rec {
    pname = "sshpubkeys";
    version = "1.2.2";
    src = fetchPypi {
      inherit pname version;
      sha256 = "1skk6s5sk2dyyvlv7d3z1jiw7pfm05d32hpjw3dsa5hlbpx8n6s3";
    };
    nativeBuildInputs = [ pycrypto ];
    checkPhase = ''
      pushd sshpubkeys/tests
      nosetests -v unit/ functional/
      popd
    '';
  });

  aws-xray-sdk = super.aws-xray-sdk.overridePythonAttrs (old: rec {
    pname = "aws-xray-sdk";
    version = "0.91";
    src = fetchPypi {
      inherit pname version;
      sha256 = "0d4psi54adlwi7impi1g4y5mcx5lk7r8g8dfzsa3vrdngnadxy57";
    };
  });

  s3transfer = super.s3transfer.overridePythonAttrs (old: rec {
    pname = "s3transfer";
    version = "0.1.11";
    src = fetchPypi {
      inherit pname version;
      sha256 = "0yfrfnf404cxzn3iswibqjxklsl0b1lwgqiml6pwiqj79a7zbwbn";
    };
    checkPhase = ''
      pushd s3transfer/tests
      nosetests -v unit/ functional/
      popd
    '';
  });
  kombu = super.kombu.overridePythonAttrs (old: rec {
    pname = "kombu";
    version = "3.0.35";
    src = fetchPypi {
      inherit pname version;
      sha256 = "09xpxpjz9nk8d14dj361dqdwyjwda3jlf1a7v6jif9wn2xm37ar2";
    };
    propagatedBuildInputs = old.propagatedBuildInputs ++ [ anyjson ];
    checkInputs = old.checkInputs ++ [ redis ];
  });

  billiard = super.billiard.overridePythonAttrs (old: rec {
    pname = "billiard";
    version = "3.3.0.23";
    src = fetchPypi {
      inherit pname version;
      sha256 = "02wxsc6bhqvzh8j6w758kvgqbnj14l796mvmrcms8fgfamd2lak9";
    };
  });

  sqlparse = super.sqlparse.overridePythonAttrs (old: rec {
    pname = "sqlparse";
    version = "0.1.19";
    src = fetchPypi {
      inherit pname version;
      sha256 = "1s2fvaxgh9kqzrd6iwy5h7i61ckn05plx9np13zby93z3hdbx5nq";
    };
  });

  pyyaml = super.pyyaml.overridePythonAttrs (old: rec {
    pname = "PyYAML";
    version = "3.11";
    src = fetchPypi {
      inherit pname version;
      sha256 = "1s26125vfnskng58ym37xhwv8v0mm95b2cwbjfag8prfhy596v63";
    };
  });

  requests_oauthlib = super.requests_oauthlib.overridePythonAttrs (old: rec {
    pname = "requests-oauthlib";
    version = "0.3.3";
    src = fetchPypi {
      inherit pname version;
      sha256 = "1s87y2qgwm9k9d0pqqqw9gq330wb2j197p359hm0vxgfwd6pnm9p";
    };
  });

  oauthlib = super.oauthlib.overridePythonAttrs (old: rec {
    pname = "oauthlib";
    version = "3.1.0";
    src = fetchPypi {
      inherit pname version;
      sha256 = "12gqnabwck30gdlpwm6af3s28qm9p2yc7b1w8s4fk9ncbz1irr5y";
    };
  });

  pyjwt = super.pyjwt.overridePythonAttrs (old: rec {
    pname = "PyJWT";
    version = "1.5.3";
    src = fetchPypi {
      inherit pname version;
      sha256 = "1rxsg14i33vm2i6lz0my628108c81k43v10n4h3p0gx62xdyf2sh";
    };
    doCheck = false;
  });

  simplejson = super.simplejson.overridePythonAttrs (old: rec {
    pname = "simplejson";
    version = "3.8.2";
    src = fetchPypi {
      inherit pname version;
      sha256 = "0zylrnax8b6r0ndgni4w9c599fi6wm9vx5g6k3ddqfj3932kk16m";
    };
  });

  hiredis = (buildPythonPackage rec {
    pname = "hiredis";
    version = "0.1.6";
    src = fetchPypi {
      inherit pname version;
      sha256 = "0dba7fm5s8wf1mnsx6r0ffr786g50jgmh7llw4pign1i08m2dpxn";
    };
  });
  petname = (buildPythonPackage rec {
    pname = "petname";
    version = "2.0";
    src = fetchPypi {
      inherit pname version;
      sha256 = "1l7y88858imxy2qscw77svm9y7fxkdxxk77agshy216h7r2sz898";
    };
  });
  structlog = super.structlog.overridePythonAttrs (old: rec {
    pname = "structlog";
    version = "16.1.0";
    src = fetchPypi {
      inherit pname version;
      sha256 = "00dywyg3bqlkrmbrfrql21hpjjjkc4zjd6xxjyxyd15brfnzlkdl";
    };
    doCheck = false;
  });

  BeautifulSoup = (buildPythonPackage rec {
    pname = "BeautifulSoup";
    version = "3.2.1";
    src = fetchPypi {
      inherit pname version;
      sha256 = "1nqwzqllayjpv6xi8f2lri0h15xbrm8jmif8g6si3q0i250b933a";
    };
    propagatedBuildInputs = [ soupsieve ];
    doCheck = false;
  });

  exam = (buildPythonPackage rec {
    pname = "exam";
    version = "0.10.6";
    src = fetchPypi {
      inherit pname version;
      sha256 = "128pw5rny5ilk5g80cvx52rpnb187ga5nn5h44kjjyqwpiza0b8c";
    };
    propagatedBuildInputs = [ mock nose ];
  });
}
