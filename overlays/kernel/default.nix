self: super:
let
  config = import ./config.nix;
  buildLinux = (cfg: super.buildLinux rec {
    version = "5.0.7";
    modDirVersion = "5.0.7";
    extraMeta.branch = "5.0";
    src = super.fetchurl {
      url = "mirror://kernel/linux/kernel/v5.x/linux-${version}.tar.xz";
      sha256 = "1v2lxwamnfm879a9qi9fwp5zyvlzjw9qa0aizidjbiwz5dk7gq8n";
    };
    ignoreConfigErrors = true;
    extraConfig = cfg;
    kernelPatches = with super.kernelPatches; [
      bridge_stp_helper
      modinst_arg_list_too_long
    ];
  });

  raven = buildLinux (with config; ''
    ${ryzen}
    DRM_NOUVEAU n
    DRM_I915 n
    DRM_RADEON n
    DRM_AMD_DC y
    DRM_AMD_DC_DCN1_0 y
    NR_CPUS 8
    ${exclude.uncommon}
    ${exclude.fs}
    ${exclude.net}
    ${exclude.wlan}
  '');

  slim = buildLinux (with config; ''
    ${ryzen}
    ${exclude.uncommon}
    ${exclude.fs}
    ${exclude.net}
    ${exclude.wlan}
  '');

  gag3w = buildLinux (with config; ''
    KALLSYMS_ALL y 
    ${ryzen}
    DRM_NOUVEAU n 
    DRM_I915 n 
    DRM_RADEON n
    DRM_AMDGPU_SI y
    DRM_AMDGPU_CIK y
    DRM_AMD_DC_PRE_VEGA y
    NR_CPUS 16 
    BT n
    ${exclude.uncommon}
    ${exclude.fs}
    ${exclude.net}
    ${exclude.wlan}
  '');

in {
    linuxPackages_plumelo   = super.linuxPackagesFor super.buildLinux;
    linuxPackages_raven     = super.linuxPackagesFor raven;
    linuxPackages_slim      = super.linuxPackagesFor slim;
    linuxPackages_gag3w     = super.linuxPackagesFor gag3w;
}
