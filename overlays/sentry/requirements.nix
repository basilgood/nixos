# generated using pypi2nix tool (version: 2.0.0)
# See more at: https://github.com/nix-community/pypi2nix
#
# COMMAND:
#   pypi2nix -v -V python27 -e semaphore -E cargo -e psycopg2 -E postgresql -e confluent-kafka -E rdkafka -e pillow -E zlib.dev -E pkgconfig -E libjpeg -e lxml -E libxml2 -E libxslt -E nodejs -E yarn -E openssl -e cffi==1.11.5 -r requirements.txt
#

{ pkgs ? import <nixpkgs> {},
  overrides ? ({ pkgs, python }: self: super: {})
}:

let

  inherit (pkgs) makeWrapper;
  inherit (pkgs.stdenv.lib) fix' extends inNixShell;

  pythonPackages =
  import "${toString pkgs.path}/pkgs/top-level/python-packages.nix" {
    inherit pkgs;
    inherit (pkgs) stdenv;
    python = pkgs.python27Full;
    # patching pip so it does not try to remove files when running nix-shell
    overrides =
      self: super: {
        bootstrapped-pip = super.bootstrapped-pip.overrideDerivation (old: {
          patchPhase = (if builtins.hasAttr "patchPhase" old then old.patchPhase else "") + ''
            if [ -e $out/${pkgs.python27Full.sitePackages}/pip/req/req_install.py ]; then
              sed -i \
                -e "s|paths_to_remove.remove(auto_confirm)|#paths_to_remove.remove(auto_confirm)|"  \
                -e "s|self.uninstalled = paths_to_remove|#self.uninstalled = paths_to_remove|"  \
                $out/${pkgs.python27Full.sitePackages}/pip/req/req_install.py
            fi
          '';
        });
      };
  };

  commonBuildInputs = with pkgs; [ cargo postgresql rdkafka zlib.dev pkgconfig libjpeg libxml2 libxslt nodejs yarn openssl ];
  commonDoCheck = false;

  withPackages = pkgs':
    let
      pkgs = builtins.removeAttrs pkgs' ["__unfix__"];
      interpreterWithPackages = selectPkgsFn: pythonPackages.buildPythonPackage {
        name = "python27Full-interpreter";
        buildInputs = [ makeWrapper ] ++ (selectPkgsFn pkgs);
        buildCommand = ''
          mkdir -p $out/bin
          ln -s ${pythonPackages.python.interpreter} \
              $out/bin/${pythonPackages.python.executable}
          for dep in ${builtins.concatStringsSep " "
              (selectPkgsFn pkgs)}; do
            if [ -d "$dep/bin" ]; then
              for prog in "$dep/bin/"*; do
                if [ -x "$prog" ] && [ -f "$prog" ]; then
                  ln -s $prog $out/bin/`basename $prog`
                fi
              done
            fi
          done
          for prog in "$out/bin/"*; do
            wrapProgram "$prog" --prefix PYTHONPATH : "$PYTHONPATH"
          done
          pushd $out/bin
          ln -s ${pythonPackages.python.executable} python
          ln -s ${pythonPackages.python.executable} \
              python2
          popd
        '';
        passthru.interpreter = pythonPackages.python;
      };

      interpreter = interpreterWithPackages builtins.attrValues;
    in {
      __old = pythonPackages;
      inherit interpreter;
      inherit interpreterWithPackages;
      mkDerivation = args: pythonPackages.buildPythonPackage (args // {
        nativeBuildInputs = (args.nativeBuildInputs or []) ++ args.buildInputs;
      });
      packages = pkgs;
      overrideDerivation = drv: f:
        pythonPackages.buildPythonPackage (
          drv.drvAttrs // f drv.drvAttrs // { meta = drv.meta; }
        );
      withPackages = pkgs'':
        withPackages (pkgs // pkgs'');
    };

  python = withPackages {};

  generated = self: {
    "amqp" = python.mkDerivation {
      name = "amqp-1.4.9";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/cc/a4/f265c6f9a7eb1dd45d36d9ab775520e07ff575b11ad21156f9866da047b2/amqp-1.4.9.tar.gz";
        sha256 = "2dea4d16d073c902c3b89d9b96620fb6729ac0f7a923bbc777cb4ad827c0c61a";
};
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://github.com/celery/py-amqp";
        license = licenses.lgpl3;
        description = "Low-level AMQP client for Python (fork of amqplib)";
      };
    };

    "anyjson" = python.mkDerivation {
      name = "anyjson-0.3.3";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/c3/4d/d4089e1a3dd25b46bebdb55a992b0797cff657b4477bc32ce28038fdecbc/anyjson-0.3.3.tar.gz";
        sha256 = "37812d863c9ad3e35c0734c42e0bf0320ce8c3bed82cd20ad54cb34d158157ba";
};
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://bitbucket.org/runeh/anyjson/";
        license = licenses.bsdOriginal;
        description = "Wraps the best available JSON implementation available in a common interface";
      };
    };

    "asn1crypto" = python.mkDerivation {
      name = "asn1crypto-0.24.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/fc/f1/8db7daa71f414ddabfa056c4ef792e1461ff655c2ae2928a2b675bfed6b4/asn1crypto-0.24.0.tar.gz";
        sha256 = "9d5c20441baf0cb60a4ac34cc447c6c189024b6b4c6cd7877034f4965c464e49";
};
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/wbond/asn1crypto";
        license = licenses.mit;
        description = "Fast ASN.1 parser and serializer with definitions for private keys, public keys, certificates, CRL, OCSP, CMS, PKCS#3, PKCS#7, PKCS#8, PKCS#12, PKCS#5, X.509 and TSP";
      };
    };

    "attrs" = python.mkDerivation {
      name = "attrs-19.1.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/cc/d9/931a24cc5394f19383fbbe3e1147a0291276afa43a0dc3ed0d6cd9fda813/attrs-19.1.0.tar.gz";
        sha256 = "f0b870f674851ecbfbbbd364d6b5cbdff9dcedbc7f3f5e18a6891057f21fe399";
};
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://www.attrs.org/";
        license = licenses.mit;
        description = "Classes Without Boilerplate";
      };
    };

    "beautifulsoup" = python.mkDerivation {
      name = "beautifulsoup-3.2.1";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/1e/ee/295988deca1a5a7accd783d0dfe14524867e31abb05b6c0eeceee49c759d/BeautifulSoup-3.2.1.tar.gz";
        sha256 = "6a8cb4401111e011b579c8c52a51cdab970041cc543814bbd9577a4529fe1cdb";
};
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://www.crummy.com/software/BeautifulSoup/";
        license = licenses.bsdOriginal;
        description = "HTML/XML parser for quick-turnaround applications like screen-scraping.";
      };
    };

    "billiard" = python.mkDerivation {
      name = "billiard-3.3.0.23";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/64/a6/d7b6fb7bd0a4680a41f1d4b27061c7b768c673070ba8ac116f865de4e7ca/billiard-3.3.0.23.tar.gz";
        sha256 = "692a2a5a55ee39a42bcb7557930e2541da85df9ea81c6e24827f63b80cd39d0b";
};
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://github.com/celery/billiard";
        license = licenses.bsdOriginal;
        description = "Python multiprocessing fork with improvements and bugfixes";
      };
    };

    "boto3" = python.mkDerivation {
      name = "boto3-1.4.5";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/c7/ba/37e3657129590191ab2a8fade26355d56b8811bbac8bf446ef6d6bc6f0c8/boto3-1.4.5.tar.gz";
        sha256 = "6d570df0f692e82b35e9abafbb4584b899b2803e8cfcb70d1f371ca08919831d";
};
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."botocore"
        self."jmespath"
        self."s3transfer"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/boto/boto3";
        license = licenses.asl20;
        description = "The AWS SDK for Python";
      };
    };

    "botocore" = python.mkDerivation {
      name = "botocore-1.5.70";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/1d/83/a935afd5920b372a44a1cc9983661bcfe0ff72fb99d47fef7b242783e588/botocore-1.5.70.tar.gz";
        sha256 = "aaee1e55614fa71680d1b5d0d59fa8428e35bc4db6bc627e6e90bd64495ccff2";
};
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."docutils"
        self."jmespath"
        self."python-dateutil"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/boto/botocore";
        license = licenses.asl20;
        description = "Low-level, data-driven core of boto 3.";
      };
    };

    "celery" = python.mkDerivation {
      name = "celery-3.1.18";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/2f/b9/8a5d74bb351c5082465aaddf8772cfe6d4e954da68f3ac0f79bfd48f22df/celery-3.1.18.tar.gz";
        sha256 = "0924f94070c6fc57d408b169848c5b38832668fffe060e48b4803fb23e0e3eaf";
};
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."billiard"
        self."kombu"
        self."pytz"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://celeryproject.org";
        license = licenses.bsdOriginal;
        description = "Distributed Task Queue";
      };
    };

    "certifi" = python.mkDerivation {
      name = "certifi-2019.9.11";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/62/85/7585750fd65599e88df0fed59c74f5075d4ea2fe611deceb95dd1c2fb25b/certifi-2019.9.11.tar.gz";
        sha256 = "e4f3620cfea4f83eedc95b24abd9cd56f3c4b146dd0177e83a21b4eb49e21e50";
};
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://certifi.io/";
        license = licenses.mpl20;
        description = "Python package for providing Mozilla's CA Bundle.";
      };
    };

    "cffi" = python.mkDerivation {
      name = "cffi-1.11.5";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/e7/a7/4cd50e57cc6f436f1cc3a7e8fa700ff9b8b4d471620629074913e3735fb2/cffi-1.11.5.tar.gz";
        sha256 = "e90f17980e6ab0f3c2f3730e56d1fe9bcba1891eeea58966e89d352492cc74f4";
};
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."pycparser"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://cffi.readthedocs.org";
        license = licenses.mit;
        description = "Foreign Function Interface for Python calling C code.";
      };
    };

    "chardet" = python.mkDerivation {
      name = "chardet-3.0.4";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/fc/bb/a5768c230f9ddb03acc9ef3f0d4a3cf93462473795d18e9535498c8f929d/chardet-3.0.4.tar.gz";
        sha256 = "84ab92ed1c4d4f16916e05906b6b75a6c0fb5db821cc65e70cbd64a3e2a5eaae";
};
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/chardet/chardet";
        license = licenses.lgpl3;
        description = "Universal encoding detector for Python 2 and 3";
      };
    };

    "click" = python.mkDerivation {
      name = "click-6.7";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/95/d9/c3336b6b5711c3ab9d1d3a80f1a3e2afeb9d8c02a7166462f6cc96570897/click-6.7.tar.gz";
        sha256 = "f15516df478d5a56180fbf80e68f206010e6d160fc39fa508b65e035fd75130b";
};
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://github.com/mitsuhiko/click";
        license = "UNKNOWN";
        description = "A simple wrapper around optparse for powerful command line utilities.";
      };
    };

    "confluent-kafka" = python.mkDerivation {
      name = "confluent-kafka-0.11.5";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/bf/41/25a4e23a98df212e910aecd445d3b1ea37928ef857749a85365da7108b83/confluent-kafka-0.11.5.tar.gz";
        sha256 = "bfb5807bfb5effd74f2cfe65e4e3e8564a9e72b25e099f655d8ad0d362a63b9f";
};
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."enum34"
        self."futures"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/confluentinc/confluent-kafka-python";
        license = "UNKNOWN";
        description = "Confluent's Apache Kafka client for Python";
      };
    };

    "croniter" = python.mkDerivation {
      name = "croniter-0.3.30";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/2c/ad/1cf1dba43cd3740b07879671c6c9c9870941bf78356ac432d24529da8913/croniter-0.3.30.tar.gz";
        sha256 = "538adeb3a7f7816c3cdec6db974c441620d764c25ff4ed0146ee7296b8a50590";
};
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."python-dateutil"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://github.com/kiorky/croniter";
        license = licenses.mit;
        description = "croniter provides iteration for datetime object with cron like format";
      };
    };

    "cryptography" = python.mkDerivation {
      name = "cryptography-2.7";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/c2/95/f43d02315f4ec074219c6e3124a87eba1d2d12196c2767fadfdc07a83884/cryptography-2.7.tar.gz";
        sha256 = "e6347742ac8f35ded4a46ff835c60e68c22a536a8ae5c4422966d06946b6d4c6";
};
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."asn1crypto"
        self."cffi"
        self."enum34"
        self."ipaddress"
        self."six"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/pyca/cryptography";
        license = licenses.bsdOriginal;
        description = "cryptography is a package which provides cryptographic recipes and primitives to Python developers.";
      };
    };

    "cssselect" = python.mkDerivation {
      name = "cssselect-1.1.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/70/54/37630f6eb2c214cdee2ae56b7287394c8aa2f3bafb8b4eb8c3791aae7a14/cssselect-1.1.0.tar.gz";
        sha256 = "f95f8dedd925fd8f54edb3d2dfb44c190d9d18512377d3c1e2388d16126879bc";
};
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/scrapy/cssselect";
        license = licenses.bsdOriginal;
        description = "cssselect parses CSS3 Selectors and translates them to XPath 1.0";
      };
    };

    "cssutils" = python.mkDerivation {
      name = "cssutils-0.9.10";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/92/4f/02b84160055ac51c4c7bb654aca3a0724c4e90b2e124088d7e24b39ea0b1/cssutils-0.9.10.zip";
        sha256 = "2ea142fddf8aec9231fde5bc1184b282008f2ca35a7b483371eef5b97b6c23a6";
};
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://cthedot.de/cssutils/";
        license = "LGPL 2.1 or later, see also http://cthedot.de/cssutils/";
        description = "A CSS Cascading Style Sheets library for Python";
      };
    };

    "django" = python.mkDerivation {
      name = "django-1.8.19";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/ad/da/980dbd68970fefbdf9c62faeed5da1d8ed49214ff3ea3991c2d233719b51/Django-1.8.19.tar.gz";
        sha256 = "33d44a5cf9d333247a9a374ae1478b78b83c9b78eb316fc04adde62053b4c047";
};
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://www.djangoproject.com/";
        license = licenses.bsdOriginal;
        description = "A high-level Python Web framework that encourages rapid development and clean, pragmatic design.";
      };
    };

    "django-crispy-forms" = python.mkDerivation {
      name = "django-crispy-forms-1.4.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/cc/aa/8b8d7f440acb2b2094a3240b691bf065c02df26d88525a8be06cc43fafab/django-crispy-forms-1.4.0.tar.gz";
        sha256 = "d0c9531ebdff8dc255f625e677ec2fab326522e3f4cd8f7a3e891d773d281510";
};
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://github.com/maraujop/django-crispy-forms";
        license = licenses.mit;
        description = "Best way to have Django DRY forms";
      };
    };

    "django-jsonfield" = python.mkDerivation {
      name = "django-jsonfield-0.9.13";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/a4/93/0d881e8f32043c65454a0980e8472fc831e2e75ae05607ef4d406cbe123f/django-jsonfield-0.9.13.tar.gz";
        sha256 = "12ae3dd4543f8dc5cc5f4bdd7f6fd168f4d1624414d753a441573ccc187a8e43";
};
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://bitbucket.org/schinckel/django-jsonfield/";
        license = "UNKNOWN";
        description = "JSONField for django models";
      };
    };

    "django-picklefield" = python.mkDerivation {
      name = "django-picklefield-1.0.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/e8/69/232d78ef16cad8dd4c2f871b0f44d87bcde36ed6a90597416e903034600b/django-picklefield-1.0.0.tar.gz";
        sha256 = "61e3ba7f6df82d8df9e6be3a8c55ef589eb3bf926c3d25d2b7949b07eae78354";
};
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://github.com/gintas/django-picklefield";
        license = "UNKNOWN";
        description = "Pickled object field for Django";
      };
    };

    "django-sudo" = python.mkDerivation {
      name = "django-sudo-2.1.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/23/1e/ccc9259ea7c9b6bc3e4cce20edd94f165c94701b09d4c555f332c844fa01/django-sudo-2.1.0.tar.gz";
        sha256 = "375a3100127dfcf49f24184ca25a1c84178470d6918c6a88e63472de030047a6";
};
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/mattrobenolt/django-sudo";
        license = licenses.bsdOriginal;
        description = "Extra security for your sensitive pages";
      };
    };

    "djangorestframework" = python.mkDerivation {
      name = "djangorestframework-3.0.5";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/c0/c6/53b00976f53b82e20109b08398f2215fff09274a88ff9226eb713c361510/djangorestframework-3.0.5.tar.gz";
        sha256 = "80c1690df1d9ed0d4f449f8378b08f00548838690d1a83ed901148a871145d27";
};
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://www.django-rest-framework.org";
        license = licenses.bsdOriginal;
        description = "Web APIs for Django, made easy.";
      };
    };

    "docutils" = python.mkDerivation {
      name = "docutils-0.15.2";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/93/22/953e071b589b0b1fee420ab06a0d15e5aa0c7470eb9966d60393ce58ad61/docutils-0.15.2.tar.gz";
        sha256 = "a2aeea129088da402665e92e0b25b04b073c04b2dce4ab65caaa38b7ce2e1a99";
};
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://docutils.sourceforge.net/";
        license = "public domain, Python, 2-Clause BSD, GPL 3 (see COPYING.txt)";
        description = "Docutils -- Python Documentation Utilities";
      };
    };

    "email-reply-parser" = python.mkDerivation {
      name = "email-reply-parser-0.2.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/96/1b/a6c9acd8e78e758a7a2f4a30dbcfbf38063a58363b1086d3e5fcdd54fc51/email_reply_parser-0.2.0.tar.gz";
        sha256 = "3fd098e40f10e41ff611936c475ce8fc61c75f21b69173047623c518f4d69066";
};
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/zapier/email-reply-parser";
        license = licenses.mit;
        description = "Email reply parser";
      };
    };

    "enum34" = python.mkDerivation {
      name = "enum34-1.1.6";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/bf/3e/31d502c25302814a7c2f1d3959d2a3b3f78e509002ba91aea64993936876/enum34-1.1.6.tar.gz";
        sha256 = "8ad8c4783bf61ded74527bffb48ed9b54166685e4230386a9ed9b1279e2df5b1";
};
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://bitbucket.org/stoneleaf/enum34";
        license = licenses.bsdOriginal;
        description = "Python 3.4 Enum backported to 3.3, 3.2, 3.1, 2.7, 2.6, 2.5, and 2.4";
      };
    };

    "exam" = python.mkDerivation {
      name = "exam-0.10.6";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/c7/bd/c15ce029540bb1b551af83c0df502ba47e019ce7132a65db046ad16b8eda/exam-0.10.6.tar.gz";
        sha256 = "0c2da07ebc1c7b292721b0585bd43b282c7bb3287d33805e9934166f73e11789";
};
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."mock"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/fluxx/exam";
        license = licenses.mit;
        description = "Helpers for better testing.";
      };
    };

    "funcsigs" = python.mkDerivation {
      name = "funcsigs-1.0.2";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/94/4a/db842e7a0545de1cdb0439bb80e6e42dfe82aaeaadd4072f2263a4fbed23/funcsigs-1.0.2.tar.gz";
        sha256 = "a7bb0f2cf3a3fd1ab2732cb49eba4252c2af4240442415b4abce3b87022a8f50";
};
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://funcsigs.readthedocs.org";
        license = "ASL";
        description = "Python function signatures from PEP362 for Python 2.6, 2.7 and 3.2+";
      };
    };

    "functools32" = python.mkDerivation {
      name = "functools32-3.2.3.post2";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/c5/60/6ac26ad05857c601308d8fb9e87fa36d0ebf889423f47c3502ef034365db/functools32-3.2.3-2.tar.gz";
        sha256 = "f6253dfbe0538ad2e387bd8fdfd9293c925d63553f5813c4e587745416501e6d";
};
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/MiCHiLU/python-functools32";
        license = "PSF license";
        description = "Backport of the functools module from Python 3.2.3 for use on 2.7 and PyPy.";
      };
    };

    "futures" = python.mkDerivation {
      name = "futures-3.3.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/47/04/5fc6c74ad114032cd2c544c575bffc17582295e9cd6a851d6026ab4b2c00/futures-3.3.0.tar.gz";
        sha256 = "7e033af76a5e35f58e56da7a91e687706faf4e7bdfb2cbc3f2cca6b9bcda9794";
};
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/agronholm/pythonfutures";
        license = "PSF";
        description = "Backport of the concurrent.futures package from Python 3";
      };
    };

    "hiredis" = python.mkDerivation {
      name = "hiredis-0.1.6";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/27/d2/5e4d2ac0b3161f00ce7251f51c7cb86dfc51a6fe309e550cabddd6926f65/hiredis-0.1.6.tar.gz";
        sha256 = "b6df262a0231d8172fe1941e589f04e51974b273209bae6d0d8e235daa3b6a35";
};
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/redis/hiredis-py";
        license = licenses.bsdOriginal;
        description = "Python wrapper for hiredis";
      };
    };

    "honcho" = python.mkDerivation {
      name = "honcho-1.0.1";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/a2/8b/c404bce050eba79a996f6901f35445a53c1133b0424b33e58a4ad225bc37/honcho-1.0.1.tar.gz";
        sha256 = "c189402ad2e337777283c6a12d0f4f61dc6dd20c254c9a3a4af5087fc66cea6e";
};
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/nickstenning/honcho";
        license = licenses.mit;
        description = "Honcho: a Python clone of Foreman. For managing Procfile-based applications.";
      };
    };

    "httplib2" = python.mkDerivation {
      name = "httplib2-0.13.1";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/78/23/bb9606e87a66fd8c72a2b1a75b049d3859a122bc2648915be845bc44e04f/httplib2-0.13.1.tar.gz";
        sha256 = "6901c8c0ffcf721f9ce270ad86da37bc2b4d32b8802d4a9cec38274898a64044";
};
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/httplib2/httplib2";
        license = licenses.mit;
        description = "A comprehensive HTTP client library.";
      };
    };

    "idna" = python.mkDerivation {
      name = "idna-2.7";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/65/c4/80f97e9c9628f3cac9b98bfca0402ede54e0563b56482e3e6e45c43c4935/idna-2.7.tar.gz";
        sha256 = "684a38a6f903c1d71d6d5fac066b58d7768af4de2b832e426ec79c30daa94a16";
};
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/kjd/idna";
        license = licenses.bsdOriginal;
        description = "Internationalized Domain Names in Applications (IDNA)";
      };
    };

    "ipaddress" = python.mkDerivation {
      name = "ipaddress-1.0.22";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/97/8d/77b8cedcfbf93676148518036c6b1ce7f8e14bf07e95d7fd4ddcb8cc052f/ipaddress-1.0.22.tar.gz";
        sha256 = "b146c751ea45cad6188dd6cf2d9b757f6f4f8d6ffb96a023e6f2e26eea02a72c";
};
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/phihag/ipaddress";
        license = licenses.psfl;
        description = "IPv4/IPv6 manipulation library";
      };
    };

    "jmespath" = python.mkDerivation {
      name = "jmespath-0.9.4";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/2c/30/f0162d3d83e398c7a3b70c91eef61d409dea205fb4dc2b47d335f429de32/jmespath-0.9.4.tar.gz";
        sha256 = "bde2aef6f44302dfb30320115b17d030798de8c4110e28d5cf6cf91a7a31074c";
};
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/jmespath/jmespath.py";
        license = licenses.mit;
        description = "JSON Matching Expressions";
      };
    };

    "jsonschema" = python.mkDerivation {
      name = "jsonschema-2.6.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/58/b9/171dbb07e18c6346090a37f03c7e74410a1a56123f847efed59af260a298/jsonschema-2.6.0.tar.gz";
        sha256 = "6ff5f3180870836cae40f06fa10419f557208175f13ad7bc26caa77beb1f6e02";
};
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."functools32"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://github.com/Julian/jsonschema";
        license = licenses.mit;
        description = "An implementation of JSON Schema validation for Python";
      };
    };

    "kombu" = python.mkDerivation {
      name = "kombu-3.0.35";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/5f/4f/3859b52f6d465d0d4a767516c924ee4f0e1387498ac8d0c30d9942da3762/kombu-3.0.35.tar.gz";
        sha256 = "22ab336a17962717a5d9470547e5508d4bcf1b6ec10cd9486868daf4e5edb727";
};
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."amqp"
        self."anyjson"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://kombu.readthedocs.org";
        license = "UNKNOWN";
        description = "Messaging library for Python";
      };
    };

    "loremipsum" = python.mkDerivation {
      name = "loremipsum-1.0.5";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/55/8e/f75963c116c72bb81d2e22ec64ff3837e962cc89bae025ab60698dd83160/loremipsum-1.0.5.tar.gz";
        sha256 = "b849c69305c3f52badfe25ecc0495b991769d96cafdfd99014d17f50ee523af5";
};
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://projects.monkeython.com/loremipsum";
        license = "UNKNOWN";
        description = "UNKNOWN";
      };
    };

    "lxml" = python.mkDerivation {
      name = "lxml-4.4.1";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/c4/43/3f1e7d742e2a7925be180b6af5e0f67d38de2f37560365ac1a0b9a04c015/lxml-4.4.1.tar.gz";
        sha256 = "c81cb40bff373ab7a7446d6bbca0190bccc5be3448b47b51d729e37799bb5692";
};
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://lxml.de/";
        license = licenses.bsdOriginal;
        description = "Powerful and Pythonic XML processing library combining libxml2/libxslt with the ElementTree API.";
      };
    };

    "milksnake" = python.mkDerivation {
      name = "milksnake-0.1.5";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/f9/6d/b55d227c75643445fb5bcd496ab21e543550330ba58a3d791efe973d39c1/milksnake-0.1.5.zip";
        sha256 = "dfcd43b78bcf93897a75eea1dadf71c848319f19451cff4f3f3a628a5abe1688";
};
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."cffi"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "UNKNOWN";
        license = licenses.asl20;
        description = "A python library that extends setuptools for binary extensions.";
      };
    };

    "mistune" = python.mkDerivation {
      name = "mistune-0.8.4";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/2d/a4/509f6e7783ddd35482feda27bc7f72e65b5e7dc910eca4ab2164daf9c577/mistune-0.8.4.tar.gz";
        sha256 = "59a3429db53c50b5c6bcc8a07f8848cb00d7dc8bdb431a4ab41920d201d4756e";
};
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/lepture/mistune";
        license = licenses.bsdOriginal;
        description = "The fastest markdown parser in pure Python";
      };
    };

    "mmh3" = python.mkDerivation {
      name = "mmh3-2.3.1";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/87/a9/d15efdb230b1588b9427c77ce4b608aaf478bd0ebd47b2f6a7a1bc7cce4b/mmh3-2.3.1.tar.gz";
        sha256 = "ecadc3557c093211a70b49814cf91d6833fff403edf2d8405645e227262de928";
};
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://packages.python.org/mmh3";
        license = "Public Domain";
        description = "Python library for MurmurHash (MurmurHash3), a set of fast and robust hash functions.";
      };
    };

    "mock" = python.mkDerivation {
      name = "mock-2.0.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/0c/53/014354fc93c591ccc4abff12c473ad565a2eb24dcd82490fae33dbf2539f/mock-2.0.0.tar.gz";
        sha256 = "b158b6df76edd239b8208d481dc46b6afd45a846b7812ff0ce58971cf5bc8bba";
};
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."funcsigs"
        self."pbr"
        self."six"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/testing-cabal/mock";
        license = "UNKNOWN";
        description = "Rolling backport of unittest.mock for all Pythons";
      };
    };

    "more-itertools" = python.mkDerivation {
      name = "more-itertools-5.0.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/dd/26/30fc0d541d9fdf55faf5ba4b0fd68f81d5bd2447579224820ad525934178/more-itertools-5.0.0.tar.gz";
        sha256 = "38a936c0a6d98a38bcc2d03fdaaedaba9f412879461dd2ceff8d37564d6522e4";
};
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."six"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/erikrose/more-itertools";
        license = licenses.mit;
        description = "More routines for operating on iterables, beyond itertools";
      };
    };

    "msgpack" = python.mkDerivation {
      name = "msgpack-0.6.1";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/81/9c/0036c66234482044070836cc622266839e2412f8108849ab0bfdeaab8578/msgpack-0.6.1.tar.gz";
        sha256 = "4008c72f5ef2b7936447dcb83db41d97e9791c83221be13d5e19db0796df1972";
};
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://msgpack.org/";
        license = licenses.asl20;
        description = "MessagePack (de)serializer.";
      };
    };

    "oauth2" = python.mkDerivation {
      name = "oauth2-1.9.0.post1";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/64/19/8b9066e94088e8d06d649e10319349bfca961e87768a525aba4a2627c986/oauth2-1.9.0.post1.tar.gz";
        sha256 = "c006a85e7c60107c7cc6da1b184b5c719f6dd7202098196dfa6e55df669b59bf";
};
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."httplib2"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://github.com/joestump/python-oauth2";
        license = licenses.mit;
        description = "library for OAuth version 1.9";
      };
    };

    "oauthlib" = python.mkDerivation {
      name = "oauthlib-3.1.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/fc/c7/829c73c64d3749da7811c06319458e47f3461944da9d98bb4df1cb1598c2/oauthlib-3.1.0.tar.gz";
        sha256 = "bee41cc35fcca6e988463cacc3bcb8a96224f470ca547e697b604cc697b2f889";
};
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/oauthlib/oauthlib";
        license = licenses.bsdOriginal;
        description = "A generic, spec-compliant, thorough implementation of the OAuth request-signing logic";
      };
    };

    "olefile" = python.mkDerivation {
      name = "olefile-0.46";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/34/81/e1ac43c6b45b4c5f8d9352396a14144bba52c8fec72a80f425f6a4d653ad/olefile-0.46.zip";
        sha256 = "133b031eaf8fd2c9399b78b8bc5b8fcbe4c31e85295749bb17a87cba8f3c3964";
};
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://www.decalage.info/python/olefileio";
        license = licenses.bsdOriginal;
        description = "Python package to parse, read and write Microsoft OLE2 files (Structured Storage or Compound Document, Microsoft Office)";
      };
    };

    "parsimonious" = python.mkDerivation {
      name = "parsimonious-0.8.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/4a/89/32c55944cd30dff856f16859ee325b13c83c260d0c56c0eed511e8063c87/parsimonious-0.8.0.tar.gz";
        sha256 = "ae0869d72a6e57703f24313a5f5748e73ebff836e6fe8b3ddf34ea0dc00d086b";
};
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."six"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/erikrose/parsimonious";
        license = licenses.mit;
        description = "(Soon to be) the fastest pure-Python PEG parser I could muster";
      };
    };

    "pbr" = python.mkDerivation {
      name = "pbr-5.4.3";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/99/f1/7807d3409c79905a907f1c616d910c921b2a8e73c17b2969930318f44777/pbr-5.4.3.tar.gz";
        sha256 = "2c8e420cd4ed4cec4e7999ee47409e876af575d4c35a45840d59e8b5f3155ab8";
};
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://docs.openstack.org/pbr/latest/";
        license = "UNKNOWN";
        description = "Python Build Reasonableness";
      };
    };

    "percy" = python.mkDerivation {
      name = "percy-2.0.2";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/6c/e8/1b856488736db9f1bb8578480f9497f7cf1ede96c6e6e17f29ebef4e78bc/percy-2.0.2.tar.gz";
        sha256 = "6238612dc401fa5c221c0ad7738f7ea43e48fe2695f6423e785ee2bc940f021d";
};
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."requests"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/percy/python-percy-client";
        license = licenses.mit;
        description = "Python client library for visual regression testing with Percy (https://percy.io).";
      };
    };

    "petname" = python.mkDerivation {
      name = "petname-2.6";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/8e/a5/348c90b3fb09d7bd76f7dacf1b92e251d75bfbe715006cb9b84eb23be1b1/petname-2.6.tar.gz";
        sha256 = "981c31ef772356a373640d1bb7c67c102e0159eda14578c67a1c99d5b34c9e4c";
};
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://launchpad.net/python-petname";
        license = "Apache2";
        description = "Generate human-readable, random object names";
      };
    };

    "pillow" = python.mkDerivation {
      name = "pillow-4.2.1";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/55/aa/f7f983fb72710a9daa4b3374b7c160091d3f94f5c09221f9336ade9027f3/Pillow-4.2.1.tar.gz";
        sha256 = "c724f65870e545316f9e82e4c6d608ab5aa9dd82d5185e5b2e72119378740073";
};
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."olefile"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://python-pillow.org";
        license = "Standard PIL License";
        description = "Python Imaging Library (Fork)";
      };
    };

    "pluggy" = python.mkDerivation {
      name = "pluggy-0.6.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/11/bf/cbeb8cdfaffa9f2ea154a30ae31a9d04a1209312e2919138b4171a1f8199/pluggy-0.6.0.tar.gz";
        sha256 = "7f8ae7f5bdf75671a718d2daf0a64b7885f74510bcd98b1a0bb420eb9a9d0cff";
};
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/pytest-dev/pluggy";
        license = licenses.mit;
        description = "plugin and hook calling mechanisms for python";
      };
    };

    "progressbar2" = python.mkDerivation {
      name = "progressbar2-3.10.1";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/1c/de/a2f5feaf4048c941070e06e5814cb2adad73cdf47778920cb6c762145f17/progressbar2-3.10.1.tar.gz";
        sha256 = "0bf46fb3e41c1d64698c07f37a306524e3fecae21e9e526168c668b95fef3169";
};
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."python-utils"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "";
        license = "";
        description = "A Python Progressbar library to provide visual (yet text based) progress to";
      };
    };

    "psycopg2" = python.mkDerivation {
      name = "psycopg2-2.8.3";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/5c/1c/6997288da181277a0c29bc39a5f9143ff20b8c99f2a7d059cfb55163e165/psycopg2-2.8.3.tar.gz";
        sha256 = "897a6e838319b4bf648a574afb6cabcb17d0488f8c7195100d48d872419f4457";
};
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://initd.org/psycopg/";
        license = licenses.zpl21;
        description = "psycopg2 - Python-PostgreSQL Database Adapter";
      };
    };

    "psycopg2-binary" = python.mkDerivation {
      name = "psycopg2-binary-2.8.3";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/80/91/91911be01869fa877135946f928ed0004e62044bdd876c1e0f12e1b5fb90/psycopg2-binary-2.8.3.tar.gz";
        sha256 = "cd37cc170678a4609becb26b53a2bc1edea65177be70c48dd7b39a1149cabd6e";
};
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://initd.org/psycopg/";
        license = licenses.zpl21;
        description = "psycopg2 - Python-PostgreSQL Database Adapter";
      };
    };

    "py" = python.mkDerivation {
      name = "py-1.8.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/f1/5a/87ca5909f400a2de1561f1648883af74345fe96349f34f737cdfc94eba8c/py-1.8.0.tar.gz";
        sha256 = "dc639b046a6e2cff5bbe40194ad65936d6ba360b52b3c3fe1d08a82dd50b5e53";
};
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://py.readthedocs.io/";
        license = licenses.mit;
        description = "library with cross-python path, ini-parsing, io, code, log facilities";
      };
    };

    "pycparser" = python.mkDerivation {
      name = "pycparser-2.19";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/68/9e/49196946aee219aead1290e00d1e7fdeab8567783e83e1b9ab5585e6206a/pycparser-2.19.tar.gz";
        sha256 = "a988718abfad80b6b157acce7bf130a30876d27603738ac39f140993246b25b3";
};
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/eliben/pycparser";
        license = licenses.bsdOriginal;
        description = "C parser in Python";
      };
    };

    "pyjwt" = python.mkDerivation {
      name = "pyjwt-1.5.3";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/c9/2a/ffd27735280696f6f244c8d1b4d2dd130511340475a29768ed317f9eaf0c/PyJWT-1.5.3.tar.gz";
        sha256 = "500be75b17a63f70072416843dc80c8821109030be824f4d14758f114978bae7";
};
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://github.com/jpadilla/pyjwt";
        license = licenses.mit;
        description = "JSON Web Token implementation in Python";
      };
    };

    "pytest" = python.mkDerivation {
      name = "pytest-3.5.1";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/b2/85/24954df0ea8156599563b753de54383a5d702081093b7953334e4701b8d8/pytest-3.5.1.tar.gz";
        sha256 = "54713b26c97538db6ff0703a12b19aeaeb60b5e599de542e7fca0ec83b9038e8";
};
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."attrs"
        self."funcsigs"
        self."more-itertools"
        self."pluggy"
        self."py"
        self."six"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pytest.org";
        license = licenses.mit;
        description = "pytest: simple powerful testing with Python";
      };
    };

    "pytest-django" = python.mkDerivation {
      name = "pytest-django-2.9.1";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/50/6d/77a4644d15746ed2a243ed557af693cec7887e43b357919ba0b4fd029518/pytest-django-2.9.1.tar.gz";
        sha256 = "8be15b637738c8cbd1422a6461465c0aeab7839cf76ad2b5d190b6f1f53facd6";
};
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."pytest"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pytest-django.readthedocs.org/";
        license = licenses.bsd3;
        description = "A Django plugin for py.test.";
      };
    };

    "pytest-html" = python.mkDerivation {
      name = "pytest-html-1.9.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/2d/f2/8b2afdef7fc60314d35065801933675fc228eb031db3176c6b99a9de36a1/pytest-html-1.9.0.tar.gz";
        sha256 = "aecc9866bdb21950c23851515a664da24a42e565d20edf00b47a17630c074aa5";
};
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."pytest"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/pytest-dev/pytest-html";
        license = "Mozilla Public License 2.0 (MPL 2.0)";
        description = "pytest plugin for generating HTML reports";
      };
    };

    "python-dateutil" = python.mkDerivation {
      name = "python-dateutil-2.8.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/ad/99/5b2e99737edeb28c71bcbec5b5dda19d0d9ef3ca3e92e3e925e7c0bb364c/python-dateutil-2.8.0.tar.gz";
        sha256 = "c89805f6f4d64db21ed966fda138f8a5ed7a4fdbc1a8ee329ce1b74e3c74da9e";
};
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs ++ [
        self."setuptools-scm"
      ];
      propagatedBuildInputs = [
        self."six"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://dateutil.readthedocs.io";
        license = "Dual License";
        description = "Extensions to the standard Python datetime module";
      };
    };

    "python-memcached" = python.mkDerivation {
      name = "python-memcached-1.59";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/90/59/5faf6e3cd8a568dd4f737ddae4f2e54204fd8c51f90bf8df99aca6c22318/python-memcached-1.59.tar.gz";
        sha256 = "a2e28637be13ee0bf1a8b6843e7490f9456fd3f2a4cb60471733c7b5d5557e4f";
};
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."six"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/linsomniac/python-memcached";
        license = "UNKNOWN";
        description = "Pure python memcached client";
      };
    };

    "python-openid" = python.mkDerivation {
      name = "python-openid-2.2.5";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/7b/8a/e94d18c666073280b8c0614b7e38cfaf0b129989e42f4ca713942b862f0a/python-openid-2.2.5.tar.gz";
        sha256 = "92c51c3ecec846cbec4aeff11f9ff47303d4a63f93b0e6ac0ec02a091fed70ef";
};
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://github.com/openid/python-openid";
        license = "UNKNOWN";
        description = "OpenID support for servers and consumers.";
      };
    };

    "python-u2flib-server" = python.mkDerivation {
      name = "python-u2flib-server-5.0.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/27/c7/ab44905ecf6300063a4754c9cd3997389fdf5c2c08644ed36c57800c2201/python-u2flib-server-5.0.0.tar.gz";
        sha256 = "9b9044db13fe24abc7a07c2bdb4b7bb541ca275702f43ecbd0d9641c28bcc226";
};
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."cryptography"
        self."enum34"
        self."six"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/Yubico/python-u2flib-server";
        license = "UNKNOWN";
        description = "Python based U2F server library";
      };
    };

    "python-utils" = python.mkDerivation {
      name = "python-utils-2.3.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/30/95/d01fbd09ced38a16b7357a1d6cefe1327b9273885bffd6371cbec3e23af7/python-utils-2.3.0.tar.gz";
        sha256 = "34aaf26b39b0b86628008f2ae0ac001b30e7986a8d303b61e1357dfcdad4f6d3";
};
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."six"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/WoLpH/python-utils";
        license = licenses.bsdOriginal;
        description = "Python Utils is a module with some convenient utilities not included with the standard Python install";
      };
    };

    "pytz" = python.mkDerivation {
      name = "pytz-2019.2";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/27/c0/fbd352ca76050952a03db776d241959d5a2ee1abddfeb9e2a53fdb489be4/pytz-2019.2.tar.gz";
        sha256 = "26c0b32e437e54a18161324a2fca3c4b9846b74a8dccddd843113109e1116b32";
};
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pythonhosted.org/pytz";
        license = licenses.mit;
        description = "World timezone definitions, modern and historical";
      };
    };

    "pyyaml" = python.mkDerivation {
      name = "pyyaml-3.11";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/75/5e/b84feba55e20f8da46ead76f14a3943c8cb722d40360702b2365b91dec00/PyYAML-3.11.tar.gz";
        sha256 = "c36c938a872e5ff494938b33b14aaa156cb439ec67548fcab3535bb78b0846e8";
};
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pyyaml.org/wiki/PyYAML";
        license = licenses.mit;
        description = "YAML parser and emitter for Python";
      };
    };

    "qrcode" = python.mkDerivation {
      name = "qrcode-5.3";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/87/16/99038537dc58c87b136779c0e06d46887ff5104eb8c64989aac1ec8cba81/qrcode-5.3.tar.gz";
        sha256 = "4115ccee832620df16b659d4653568331015c718a754855caf5930805d76924e";
};
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."six"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/lincolnloop/python-qrcode";
        license = licenses.bsdOriginal;
        description = "QR Code image generator";
      };
    };

    "querystring-parser" = python.mkDerivation {
      name = "querystring-parser-1.2.4";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/4a/fa/f54f5662e0eababf0c49e92fd94bf178888562c0e7b677c8941bbbcd1bd6/querystring_parser-1.2.4.tar.gz";
        sha256 = "644fce1cffe0530453b43a83a38094dbe422ccba8c9b2f2a1c00280e14ca8a62";
};
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."six"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/bernii/querystring-parser";
        license = "UNKNOWN";
        description = "QueryString parser for Python/Django that correctly handles nested dictionaries";
      };
    };

    "rb" = python.mkDerivation {
      name = "rb-1.7";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/9b/46/836de43cf61c4d1d05b1ddda3311d045d254da64d6439150b74a44a7e4ae/rb-1.7.tar.gz";
        sha256 = "2911acac65fdd5aad0b97d3d2c8999ec859214f62bb6d5a220e0aa96828a58ea";
};
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."redis"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://github.com/getsentry/rb";
        license = "UNKNOWN";
        description = "rb, the redis blaster";
      };
    };

    "redis" = python.mkDerivation {
      name = "redis-2.10.5";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/68/44/5efe9e98ad83ef5b742ce62a15bea609ed5a0d1caf35b79257ddb324031a/redis-2.10.5.tar.gz";
        sha256 = "5dfbae6acfc54edf0a7a415b99e0b21c0a3c27a7f787b292eea727b1facc5533";
};
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://github.com/andymccurdy/redis-py";
        license = licenses.mit;
        description = "Python client for Redis key-value store";
      };
    };

    "redis-py-cluster" = python.mkDerivation {
      name = "redis-py-cluster-1.3.4";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/1d/4d/a0fcd8ff2d9fc81977810e5f5e2cda5a00086060a4484db1c361393206f0/redis-py-cluster-1.3.4.tar.gz";
        sha256 = "3189ddde3a04f86f4322026c45a159411bda8f84ababe2c8e8e1fbdcb025f358";
};
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."redis"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://github.com/grokzen/redis-py-cluster";
        license = licenses.mit;
        description = "Cluster library for redis 3.0.0 built on top of redis-py lib";
      };
    };

    "requests" = python.mkDerivation {
      name = "requests-2.20.1";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/40/35/298c36d839547b50822985a2cf0611b3b978a5ab7a5af5562b8ebe3e1369/requests-2.20.1.tar.gz";
        sha256 = "ea881206e59f41dbd0bd445437d792e43906703fff75ca8ff43ccdb11f33f263";
};
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."certifi"
        self."chardet"
        self."idna"
        self."urllib3"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://python-requests.org";
        license = licenses.asl20;
        description = "Python HTTP for Humans.";
      };
    };

    "requests-oauthlib" = python.mkDerivation {
      name = "requests-oauthlib-0.3.3";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/0f/8a/a7afc508dd7cf6883fb318bdf0c2a0fd65443e396ccd27977c6f146040a3/requests-oauthlib-0.3.3.tar.gz";
        sha256 = "37557b4de3eef50d2a4c65dc9382148b8331f04b1c637c414b3355feb0f007e9";
};
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."oauthlib"
        self."requests"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/requests/requests-oauthlib";
        license = "ISC";
        description = "OAuthlib authentication support for Requests.";
      };
    };

    "s3transfer" = python.mkDerivation {
      name = "s3transfer-0.1.13";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/9a/66/c6a5ae4dbbaf253bd662921b805e4972451a6d214d0dc9fb3300cb642320/s3transfer-0.1.13.tar.gz";
        sha256 = "90dc18e028989c609146e241ea153250be451e05ecc0c2832565231dacdf59c1";
};
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."botocore"
        self."futures"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/boto/s3transfer";
        license = licenses.asl20;
        description = "An Amazon S3 Transfer Manager";
      };
    };

    "selenium" = python.mkDerivation {
      name = "selenium-3.141.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/ed/9c/9030520bf6ff0b4c98988448a93c04fcbd5b13cd9520074d8ed53569ccfe/selenium-3.141.0.tar.gz";
        sha256 = "deaf32b60ad91a4611b98d8002757f29e6f2c2d5fcaf202e1c9ad06d6772300d";
};
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."urllib3"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/SeleniumHQ/selenium/";
        license = licenses.asl20;
        description = "Python bindings for Selenium";
      };
    };

    "semaphore" = python.mkDerivation {
      name = "semaphore-0.4.45";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/ea/58/d035780986cbe1405cdc37ab33d16942a90418fef9e350dfb12e332a8c16/semaphore-0.4.45.zip";
        sha256 = "e0b9c81e8672135a200768107857382a5354c57d038bab875c45f996e25bfbc2";
};
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."milksnake"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "UNKNOWN";
        license = licenses.mit;
        description = "A python library to access sentry relay functionality.";
      };
    };

    "sentry-sdk" = python.mkDerivation {
      name = "sentry-sdk-0.11.2";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/42/ae/3ba482ece5016937febe8ba4b9a7290429649ebbc4727175a072ba2d0eac/sentry-sdk-0.11.2.tar.gz";
        sha256 = "b4edcb1296fee107439345d0f8b23432b8732b7e28407f928367d0a4a36301a9";
};
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."certifi"
        self."urllib3"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/getsentry/sentry-python";
        license = licenses.bsdOriginal;
        description = "Python client for Sentry (https://getsentry.com)";
      };
    };

    "setproctitle" = python.mkDerivation {
      name = "setproctitle-1.1.10";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/5a/0d/dc0d2234aacba6cf1a729964383e3452c52096dc695581248b548786f2b3/setproctitle-1.1.10.tar.gz";
        sha256 = "6283b7a58477dd8478fbb9e76defb37968ee4ba47b05ec1c053cb39638bd7398";
};
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/dvarrazzo/py-setproctitle";
        license = licenses.bsdOriginal;
        description = "A Python module to customize the process title";
      };
    };

    "setuptools-scm" = python.mkDerivation {
      name = "setuptools-scm-3.3.3";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/83/44/53cad68ce686585d12222e6769682c4bdb9686808d2739671f9175e2938b/setuptools_scm-3.3.3.tar.gz";
        sha256 = "bd25e1fb5e4d603dcf490f1fde40fb4c595b357795674c3e5cb7f6217ab39ea5";
};
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/pypa/setuptools_scm/";
        license = licenses.mit;
        description = "the blessed package to manage your versions by scm tags";
      };
    };

    "simplejson" = python.mkDerivation {
      name = "simplejson-3.8.2";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/f0/07/26b519e6ebb03c2a74989f7571e6ae6b82e9d7d81b8de6fcdbfc643c7b58/simplejson-3.8.2.tar.gz";
        sha256 = "d58439c548433adcda98e695be53e526ba940a4b9c44fb9a05d92cd495cdd47f";
};
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://github.com/simplejson/simplejson";
        license = licenses.mit;
        description = "Simple, fast, extensible JSON encoder/decoder for Python";
      };
    };

    "six" = python.mkDerivation {
      name = "six-1.10.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/b3/b2/238e2590826bfdd113244a40d9d3eb26918bd798fc187e2360a8367068db/six-1.10.0.tar.gz";
        sha256 = "105f8d68616f8248e24bf0e9372ef04d3cc10104f1980f54d57b2ce73a5ad56a";
};
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pypi.python.org/pypi/six/";
        license = licenses.mit;
        description = "Python 2 and 3 compatibility utilities";
      };
    };

    "sqlparse" = python.mkDerivation {
      name = "sqlparse-0.1.19";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/9c/cc/3d8d34cfd0507dd3c278575e42baff2316a92513de0a87ac0ec9f32806c9/sqlparse-0.1.19.tar.gz";
        sha256 = "d896be1a1c7f24bffe08d7a64e6f0176b260e281c5f3685afe7826f8bada4ee8";
};
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/andialbrecht/sqlparse";
        license = licenses.bsdOriginal;
        description = "Non-validating SQL parser";
      };
    };

    "statsd" = python.mkDerivation {
      name = "statsd-3.1";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/b7/10/a1afbd9523c79a44686fb654ab6547007ae57a2ad669caa76f7c291324c7/statsd-3.1.tar.gz";
        sha256 = "fbae5feb33ae9394c275bc834ab94684b94de03acc8f36387bd0bf0c51ef28ee";
};
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/jsocol/pystatsd";
        license = licenses.mit;
        description = "A simple statsd client.";
      };
    };

    "strict-rfc3339" = python.mkDerivation {
      name = "strict-rfc3339-0.7";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/56/e4/879ef1dbd6ddea1c77c0078cd59b503368b0456bcca7d063a870ca2119d3/strict-rfc3339-0.7.tar.gz";
        sha256 = "5cad17bedfc3af57b399db0fed32771f18fc54bbd917e85546088607ac5e1277";
};
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://www.danielrichman.co.uk/libraries/strict-rfc3339.html";
        license = "GNU General Public License Version 3";
        description = "Strict, simple, lightweight RFC3339 functions";
      };
    };

    "structlog" = python.mkDerivation {
      name = "structlog-16.1.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/3d/d8/90e87637a53ebcb0bbc78b76bceea2f7e8bd98de80feefec7471e38dccf2/structlog-16.1.0.tar.gz";
        sha256 = "b44dfaadcbab84e6bb97bd9b263f61534a79611014679757cd93e2359ee7be01";
};
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."six"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://www.structlog.org/";
        license = licenses.mit;
        description = "Structured Logging for Python";
      };
    };

    "symbolic" = python.mkDerivation {
      name = "symbolic-6.1.4";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/bd/ff/3933b9b370685e0c95e648492fa3905129bfa108c740fbdd58dcd79dfaa0/symbolic-6.1.4.zip";
        sha256 = "5391e817a253928717704c183885039c6022b986e5ccae39f1545ac0650fb790";
};
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."milksnake"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "UNKNOWN";
        license = licenses.mit;
        description = "A python library for dealing with symbol files and more.";
      };
    };

    "toronado" = python.mkDerivation {
      name = "toronado-0.0.11";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/72/7d/988c46ca0405b1bc86d87314d81151b814f67608288cae0c19aed1c170a7/toronado-0.0.11.tar.gz";
        sha256 = "7985dc9a13c969fa1372d600455a86709fb6a124dca58c759b6b42e892ddb0a8";
};
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."cssselect"
        self."cssutils"
        self."lxml"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "UNKNOWN";
        license = licenses.asl20;
        description = "Fast lxml-based CSS stylesheet inliner.";
      };
    };

    "ua-parser" = python.mkDerivation {
      name = "ua-parser-0.7.3";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/a3/b4/3d31176d3cb2807635175004e0381fb72351173ec8c9c043b80399cf33a6/ua-parser-0.7.3.tar.gz";
        sha256 = "0aafb05a67b621eb4d69f6c1c3972f2d9443982bcd9132a8b665d90cd48a1add";
};
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/ua-parser/uap-python";
        license = "LICENSE.txt";
        description = "Python port of Browserscope's user agent parser";
      };
    };

    "unidiff" = python.mkDerivation {
      name = "unidiff-0.5.5";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/29/f0/f6a6fc44cb158e2132a139146c3f5d05b0e1bd6eeb720776a57a49c260fc/unidiff-0.5.5.tar.gz";
        sha256 = "9c9ab5fb96b6988b4cd5def6b275492442c04a570900d33aa6373105780025bc";
};
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://github.com/matiasb/python-unidiff";
        license = licenses.mit;
        description = "Unified diff parsing/metadata extraction library.";
      };
    };

    "urllib3" = python.mkDerivation {
      name = "urllib3-1.24.2";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/fd/fa/b21f4f03176463a6cccdb612a5ff71b927e5224e83483012747c12fc5d62/urllib3-1.24.2.tar.gz";
        sha256 = "9a247273df709c4fedb38c711e44292304f73f39ab01beda9f6b9fc375669ac3";
};
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://urllib3.readthedocs.io/";
        license = licenses.mit;
        description = "HTTP library with thread-safe connection pooling, file post, and more.";
      };
    };

    "uwsgi" = python.mkDerivation {
      name = "uwsgi-2.0.18";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/e7/1e/3dcca007f974fe4eb369bf1b8629d5e342bb3055e2001b2e5340aaefae7a/uwsgi-2.0.18.tar.gz";
        sha256 = "4972ac538800fb2d421027f49b4a1869b66048839507ccf0aa2fda792d99f583";
};
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://uwsgi-docs.readthedocs.io/en/latest/";
        license = "GPLv2+";
        description = "The uWSGI server";
      };
    };
  };
  localOverridesFile = ./requirements_override.nix;
  localOverrides = import localOverridesFile { inherit pkgs python; };
  commonOverrides = [
    
  ];
  paramOverrides = [
    (overrides { inherit pkgs python; })
  ];
  allOverrides =
    (if (builtins.pathExists localOverridesFile)
     then [localOverrides] else [] ) ++ commonOverrides ++ paramOverrides;

in python.withPackages
   (fix' (pkgs.lib.fold
            extends
            generated
            allOverrides
         )
   )