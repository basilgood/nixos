{ config, lib, pkgs, ... }:
with pkgs;
{
  environment.etc."lf/lfrc".text = ''
    set shell bash
    set shellopts '-eu'
    set ifs "\n"
    set scrolloff 10
    set previewer '${pistol}/bin/pistol'

    cmd open ''${{
      case $(${file}/bin/file --mime-type $f -b) in
        image/svg+xml) inkscape $fx;;
        image/*) ${sxiv}/bin/sxiv .;;
        application/pdf) ${zathura}/bin/zathura $fx;;
        text/*|application/json) $EDITOR $fx;;
        audio/*) ${mpv}/bin/mpv $fx;;
        video/*) ${mpv}/bin/mpv $fx;;
        *) for f in $fx; do setsid $OPENER $f > /dev/null 2> /dev/null & done;;
      esac
    }}
    map o open $f
    map x $$f
    map X !$f

    cmd rename %[ -e $1 ] && printf "file exists" || mv $f $1
    map r push :rename<space>
    map R $printf '%s\n' $fx | ${perl532Packages.vidir}/bin/vidir -

    map D delete
    map <delete> delete

    cmd newfold ''${{
      set -f
      read
      mkdir -- "$REPLY"
      mv -- $fx "$REPLY"
    }}

    cmd extract ''${{
      set -f
      case $f in
        *.tar.bz|*.tar.bz2|*.tbz|*.tbz2) ${gnutar}/bin/tar xjvf $f;;
        *.tar.gz|*.tgz) ${gnutar}/bin/tar xzvf $f;;
        *.tar.xz|*.txz) ${gnutar}/bin/tar xJvf $f;;
        *.tar) ${gnutar}/bin/tar -xvf "$f";;
        *.zip) ${unzip}/bin/unzip $f;;
        *.rar) ${unrar}/bin/unrar x $f;;
      esac
    }}

    cmd tar %${gnutar}/bin/tar cvf "$f.tar" "$f"
    cmd targz %${gnutar}/bin/tar cvzf "$f.tar.gz" "$f"
    cmd tarbz2 %${gnutar}/bin/tar cjvf "$f.tar.bz2" "$f"
    cmd zip %${gzip}/bin/zip -r "$f" "$f"

    map i ''${{BAT_PAGER="less -R" ${bat}/bin/bat $f}}
    map . set hidden!

    cmd usage ''${{${coreutils}/bin/du -h -d1 | ${less}/bin/less}}
  '';
  environment.systemPackages = [ lf ];
}
