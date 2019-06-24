self: super:
with super; {
  st = st.overrideAttrs (attrs: {
    name = "st-0.8.2";

    src = fetchgit {
      url = "https://git.suckless.org/st";
      rev = "caa1d8fbea2b92bca24652af0fee874bdbbbb3e5";
      sha256 = "13q9n8h3ypsnldysy8vhrcvk8v29qbb2x4mhbxy4mslmjyfzpi04";
    };

    patches = [
      ./st-scrollback-0.8.2.diff
      ./st-scrollback-mouse-0.8.2.diff
      ./st-clipboard-20180309-c5ba9c0.diff
      # ./onedark.diff
      ./st-nordtheme-0.8.2.diff
      ./st-vertcenter-20180320-6ac8c8a.diff
      ./st-anysize-0.8.1.diff
      ./st-bold-is-not-bright-20190127-3be4cf1.diff
      ./font.diff
    ];
  });
}
