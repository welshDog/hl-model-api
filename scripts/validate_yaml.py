import yaml
import sys
from pathlib import Path

p = Path('.github/workflows/publish-image.yml')
if not p.exists():
    print('ERROR: file not found:', p)
    sys.exit(2)

try:
    yaml.safe_load(p.read_text())
    print('ok')
except Exception as e:
    print('ERROR:', type(e).__name__, e)
    sys.exit(1)
