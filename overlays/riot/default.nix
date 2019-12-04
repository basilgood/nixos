self: super:
with super;
let
  conf = ''
    {
        "default_hs_url": "http://localhost:8008",
        "default_is_url": "",
        "disable_custom_urls": false,
        "disable_guests": true,
        "disable_login_language_selector": false,
        "disable_3pid_login": true,
        "brand": "Riot",
        "integrations_ui_url": "",
        "integrations_rest_url": "",
        "integrations_jitsi_widget_url": "",
        "bug_report_endpoint_url": "",
        "features": {
            "feature_groups": "labs",
            "feature_pinning": "labs"
        },
        "default_federate": true,
        "default_theme": "light",
        "roomDirectory": {
            "servers": [
                "localhost"
            ]
        },
        "welcomeUserId": "@riot-bot:localhost",
        "enable_presence_by_hs_url": {
            "http://localhost": false
        }
    }
  '';
in {
  riot-web = riot-web.override {
    conf = conf;
  };
}
