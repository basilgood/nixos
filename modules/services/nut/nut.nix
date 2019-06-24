{ config, lib, pkgs, ... }:
{

  services.udev.packages = with pkgs; [
    nut
  ];

  power.ups= {
    enable = true;
    mode = "standalone";
    ups."TrippLite" = {
      driver= "usbhid-ups";
      port = "auto";
      description= "TrippLite";
    };
  };
  environment.etc = [
    {
      source = pkgs.writeText "upsd.conf"
      ''
        LISTEN 127.0.0.1 3493
        LISTEN ::1 3493
      '';
      target = "nut/upsd.conf";
    }

    {
      source = pkgs.writeText "upsmon.conf"
      ''
        MONITOR TrippLite@localhost:3493 1 admin mypass master
        MINSUPPLIES 1
        SHUTDOWNCMD "/run/current-system/sw/bin/shutdown -h +0"
        NOTIFYCMD /run/current-system/sw/bin/upssched
        POLLFREQ 5
        POLLFREQALERT 1
        HOSTSYNC 15
        DEADTIME 15

        NOTIFYMSG ONLINE  "UPS %s on line power"
        NOTIFYMSG ONBATT  "UPS %s on battery"
        NOTIFYMSG LOWBATT "UPS %s battery is low"
        NOTIFYMSG FSD   "UPS %s: forced shutdown in progress"
        NOTIFYMSG COMMOK  "Communications with UPS %s established"
        NOTIFYMSG COMMBAD "Communications with UPS %s lost"
        NOTIFYMSG SHUTDOWN  "Auto logout and shutdown proceeding"
        NOTIFYMSG REPLBATT  "UPS %s battery needs to be replaced"
        NOTIFYMSG NOCOMM  "UPS %s is unavailable"
        NOTIFYMSG NOPARENT  "upsmon parent process died - shutdown impossible"

        NOTIFYFLAG ONLINE SYSLOG+WALL+EXEC
        NOTIFYFLAG ONBATT SYSLOG+WALL+EXEC
        NOTIFYFLAG LOWBATT  SYSLOG+WALL
        NOTIFYFLAG FSD    SYSLOG+WALL+EXEC
        NOTIFYFLAG COMMOK SYSLOG+WALL+EXEC
        NOTIFYFLAG COMMBAD  SYSLOG+WALL+EXEC
        NOTIFYFLAG SHUTDOWN SYSLOG+WALL+EXEC
        NOTIFYFLAG REPLBATT SYSLOG+WALL
        NOTIFYFLAG NOCOMM SYSLOG+WALL+EXEC
        NOTIFYFLAG NOPARENT SYSLOG+WALL
      '';
      target = "nut/upsmon.conf";
    }

    {
      source = pkgs.writeText "upsd.users"
      ''
        [admin]
        password = mypass
        actions = SET
        instcmds = ALL
        upsmon master
      '';
      target ="nut/upsd.users";
    }
  ];

}
