A relaxing little lava lamp for your dock.
To build from source, run:
pip3 install pyinstaller
cd source && pyinstaller main.py \
  --onefile \
  --windowed \
  --name "LavaLamp" \
  --add-data "anim:anim" \
  --icon=icon.ico
