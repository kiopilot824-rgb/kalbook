# Railway deployment notes

This package preserves the original frontend/backend and adds a Railway deployment layer.

## Required Railway variables

Set these in Railway Variables:

- `RAILWAY_ENVIRONMENT=1`
- `IG_BASIC_USER` — username for the web UI
- `IG_BASIC_PASSWORD` — strong password for the web UI
- `IG_SESSIONID` — sessionid from your own authorized Instagram test account
- `IG_DS_USER_ID` — ds_user_id from the same session

Optional Instagram cookies:

- `IG_CSRFTOKEN`
- `IG_MID`
- `IG_IG_DID`
- `IG_DATR`

For persistent case artifacts, attach a Railway Volume and set:

`IG_ARTIFACT_ROOT=/data/artifacts`

## Important

The original project is documented as a localhost-only application. This Railway variant changes the bind address only when deployed with Railway and adds HTTP Basic Authentication before serving the application. Keep the service private where possible and use a dedicated authorized test account.

Do not commit `.env`, cookies, or artifacts.

## Deploy

1. Upload this folder to a private GitHub repository.
2. Create a Railway service from that repository.
3. Railway will use `Dockerfile`.
4. Add the variables above.
5. Deploy and open the generated Railway domain.
6. Your browser will request the Basic Auth username/password before the dashboard is served.

The original application remains otherwise unchanged, including its dashboard, People, Network graph, Target, Signals, Report, collectors, relationship engine, and exports.
