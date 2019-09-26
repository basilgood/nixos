{ buildEnv, makeWrapper, lib, buildPythonPackage, fetchPypi, djangorestframework
, parsimonious, redis, ua-parser, setproctitle, enum34, cryptography, mmh3
, email_reply_parser, uwsgi, python-openid, rb, loremipsum, pytest-html
, toronado, croniter, percy, honcho, django-jsonfield, django-templatetag-sugar
, django-picklefield, oauth2, lxml, cssselect, cssutils, semaphore, dateutil
, requests, pytestrunner, python-utils, sentry-sdk, jmespath, docutils, urllib3
, zlib, msgpack, unidiff, httplib2, six, pytest, django, pillow, mistune
, botocore, boto3, progressbar2, querystring_parser, python-u2flib-server
, qrcode, memcached, statsd, click, redis-py-cluster, strict-rfc3339
, psycopg2-binary, celery, django-sudo, sqlparse, symbolic, pyyaml, selenium
, django-crispy-forms, pytest-django, setuptools-scm, requests_oauthlib
, simplejson, hiredis, petname, mock, structlog, BeautifulSoup, jsonschema, exam
}:

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
    mmh3
    email_reply_parser
    uwsgi
    python-openid
    parsimonious
    rb
    ua-parser
    loremipsum
    setproctitle
    python-u2flib-server
    pytest
    pytest-html
    toronado
    django
    semaphore
    qrcode
    croniter
    percy
    honcho
    sentry-sdk
    redis
    pillow
    django-jsonfield
    six
    msgpack
    unidiff
    django-templatetag-sugar
    django-picklefield
    oauth2
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
    django-sudo
    sqlparse
    symbolic
    pyyaml
    selenium
    boto3
    django-crispy-forms
    pytest-django
    requests_oauthlib
    simplejson
    hiredis
    petname
    mock
    structlog
    BeautifulSoup
    jsonschema
    exam
  ];
}
