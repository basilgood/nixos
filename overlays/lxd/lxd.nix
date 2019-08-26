{ stdenv, pkgconfig, lxc, buildGoPackage, fetchurl
, makeWrapper, acl, rsync, gnutar, xz, btrfs-progs, gzip, dnsmasq
, squashfsTools, iproute, iptables, ebtables, libcap, dqlite
, sqlite-replication
, writeShellScriptBin, apparmor-profiles, apparmor-parser
, criu
, bash
}:

buildGoPackage rec {
  pname = "lxd";
  version = "3.16";

  goPackagePath = "github.com/lxc/lxd";

  src = fetchurl {
    url = "https://github.com/lxc/lxd/releases/download/${pname}-${version}/${pname}-${version}.tar.gz";
    sha256 = "14v2mmzgrviqs3llzv792ygclgcknq7p927x8xbjv6dags5vmjcg";
  };

  preBuild = ''
    # unpack vendor
    pushd go/src/github.com/lxc/lxd
    rm _dist/src/github.com/lxc/lxd
    cp -r _dist/src/* ../../..
    rm -r _dist
    popd
  '';

  buildFlags = [ "-tags libsqlite3" ];

  postInstall = ''
    # test binaries, code generation
    rm $bin/bin/{deps,macaroon-identity,generate}

    wrapProgram $bin/bin/lxd --prefix PATH : ${stdenv.lib.makeBinPath [
      acl rsync gnutar xz btrfs-progs gzip dnsmasq squashfsTools iproute iptables ebtables bash criu
      (writeShellScriptBin "apparmor_parser" ''
        exec '${apparmor-parser}/bin/apparmor_parser' -I '${apparmor-profiles}/etc/apparmor.d' "$@"
      '')
    ]}

    mkdir -p "$bin/share/bash-completion/completions/"
    cp -av go/src/github.com/lxc/lxd/scripts/bash/lxd-client "$bin/share/bash-completion/completions/lxc"
  '';

  nativeBuildInputs = [ pkgconfig makeWrapper ];
  buildInputs = [ lxc acl libcap dqlite sqlite-replication ];

  meta = with stdenv.lib; {
    description = "Daemon based on liblxc offering a REST API to manage containers";
    homepage = https://linuxcontainers.org/lxd/;
    license = licenses.asl20;
    maintainers = with maintainers; [ fpletz ];
    platforms = platforms.linux;
  };
}
