"""
Tiny helper script to port Claude plans to current working directory.
Note: Just a copy from point-in-time
"""

import os
import shutil
from datetime import datetime
from pathlib import Path

# Config
PLAN_SRC = Path.home() / ".claude" / "plans"
PLAN_DEST = Path.cwd() / ".plans"

def get_plans():
    if not PLAN_SRC.exists():
        print(f"Error: {PLAN_SRC} not found.")
        return []
    
    files = list(PLAN_SRC.glob("*.md"))
    # Sort by modification time (descending)
    files.sort(key=lambda x: x.stat().st_mtime, reverse=True)
    return files

def main():
    N_PLANS = 10
    plans = get_plans()
    if not plans:
        print("No plans found.")
        return

    print(f"\n--- Recent Claude Plans ---")
    for i, path in enumerate(plans[:N_PLANS], 1): 
        mtime = datetime.fromtimestamp(path.stat().st_mtime).strftime('%Y-%m-%d %H:%M')
        
        # Read first line or first 50 chars for preview
        with open(path, 'r') as f:
            preview = f.read(50).replace('\n', ' ').strip()
        
        print(f"{i:2}. {path.name:30} | {mtime} | {preview}...")

    try:
        choice = input("\nEnter number to port (or 'q' to quit): ")
        if choice.lower() == 'q': return
        
        idx = int(choice) - 1
        selected = plans[idx]
        
        PLAN_DEST.mkdir(exist_ok=True)
        dest_path = PLAN_DEST / selected.name
        
        shutil.copy2(selected, dest_path)
        print(f"✅ Ported to {dest_path}")
        
    except (ValueError, IndexError):
        print("Invalid selection.")

if __name__ == "__main__":
    main()