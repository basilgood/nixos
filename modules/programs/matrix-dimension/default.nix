{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.services.matrix-dimension;
  configJSON = pkgs.writeText "config.json" (builtins.toJSON cfg.config);
  configYAML =
    pkgs.runCommand "config.yaml"
      { preferLocalBuild = true; } ''
      ${pkgs.remarshal}/bin/json2yaml -i ${configJSON} -o $out
    '';
  configFile = builtins.readFile configYAML;
in
{
  options = {
    services.matrix-dimension = {
      enable = mkEnableOption "Matrix-dimension";

      config = mkOption {
        type = types.nullOr types.attrs;
        default = null;
      };
    };
  };
  config = mkIf cfg.enable {
    environment.systemPackages = [ pkgs.matrix-dimension ];
    environment.etc."dimension/config.yaml".text = ''
      ${configFile}
    '';
    systemd.packages = [ pkgs.nodejs ];
    systemd.services.matrix-dimension = {
      description = "Integrations server for Matrix.org";
      wantedBy = [ "default.target" ];
      after = [ "network.target" ];
      serviceConfig = {
        ExecStart = "${pkgs.nodejs}/bin/node build/app/index.js";
        WorkingDirectory = "${pkgs.matrix-dimension}/lib/node_modules/matrix-dimension";
        Environment = "NODE_ENV=production";
        Restart = "always";
        RestartSec = 60;
        StandardOutput = "syslog";
        StandardError = "syslog";
        SyslogIdentifier = "matrix-dimension";
        User = "matrix-dimension";
        Group = "matrix-dimension";
      };
    };
  };

}
