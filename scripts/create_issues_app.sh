#!/usr/bin/env bash
# Crea automáticamente los Issues del repositorio Frontend `app_sido` usando GitHub CLI (`gh`).
# Ejecutar dentro de la carpeta `app_sido/`:
#   bash scripts/create_issues_app.sh

set -euo pipefail

echo "Creando etiquetas (labels) en el repositorio app_sido..."
for label in "v2" "opcional" "core" "flutter" "web" "android" "ios" "feature" "design" "ui-ux" "auth" "deals" "search" "charts" "comparison" "differentiator" "watchlist" "notifications" "fcm" "testing" "monitoring" "release" "beta" "recommendations" "size:S" "size:M" "size:L"; do
  gh label create "$label" --force >/dev/null 2>&1 || true
done

python3 - <<'PY'
import csv
import subprocess

with open("github_issues_app.csv", newline="", encoding="utf-8") as f:
    for row in csv.DictReader(f):
        labels = [l.strip() for l in row["Labels"].split(",") if l.strip()]
        body = (
            f"### Metadatos (`app_sido` - Web / Android / iOS)\n"
            f"- **ID**: `{row['ID']}`\n"
            f"- **Módulo / Fase**: {row['Phase']}\n"
            f"- **Etapa**: {row['Stage']}\n"
            f"- **Tamaño**: `{row['Size']}`\n"
            f"- **Dependencias**: `{row['Dependencies']}`\n"
            f"- **Estado inicial**: {row['Status']}\n\n"
            f"### Rama Git Asignada\n"
            f"```bash\n"
            f"git checkout -b {row['Branch']}\n"
            f"```\n\n"
            f"### Entregable\n"
            f"- [ ] {row['Deliverable']}\n\n"
            f"> Ver criterios de aceptación detallados en `ISSUES_APP_SIDO.md`."
        )
        cmd = ["gh", "issue", "create", "--title", row["Title"], "--body", body]
        for label in labels:
            cmd.extend(["--label", label])
        print(f"Creando en app_sido: {row['Title']} -> {row['Branch']}")
        subprocess.run(cmd, check=True)
PY
