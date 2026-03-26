#!/usr/bin/env bash

# Generates all ffmpeg Finder Quick Action .workflow bundles.
# Run this once: bash generate.sh
# Then double-click each .workflow file to install, or copy them to
#   ~/Library/Services/

set -euo pipefail

OUTDIR="$(cd "$(dirname "$0")" && pwd)/workflows"
mkdir -p "$OUTDIR"

# ---------------------------------------------------------------------------
# make_workflow <name> <script>
#   Creates <name>.workflow with a Run Shell Script Automator action.
#   The script receives file paths as $@ (one per selected file).
# ---------------------------------------------------------------------------
make_workflow() {
  local name="$1"
  local script="$2"

  local bundle="$OUTDIR/${name}.workflow"
  mkdir -p "$bundle/Contents"

  # Escape the script for XML
  local escaped
  escaped="$(printf '%s' "$script" | sed \
    -e 's/&/\&amp;/g' \
    -e 's/</\&lt;/g' \
    -e 's/>/\&gt;/g' \
    -e 's/"/\&quot;/g')"

  cat > "$bundle/Contents/document.wflow" <<WFLOW
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>AMApplicationBuild</key>
	<string>521.1</string>
	<key>AMApplicationVersion</key>
	<string>2.10</string>
	<key>AMDocumentVersion</key>
	<string>2</string>
	<key>actions</key>
	<array>
		<dict>
			<key>action</key>
			<dict>
				<key>AMAccepts</key>
				<dict>
					<key>Container</key>
					<string>List</string>
					<key>Optional</key>
					<true/>
					<key>Types</key>
					<array>
						<string>com.apple.cocoa.path</string>
					</array>
				</dict>
				<key>AMActionVersion</key>
				<string>2.0.3</string>
				<key>AMApplication</key>
				<array>
					<string>Finder</string>
				</array>
				<key>AMParameterProperties</key>
				<dict>
					<key>COMMAND_STRING</key>
					<dict/>
					<key>CheckedForUserDefaultShell</key>
					<dict/>
					<key>inputMethod</key>
					<dict/>
					<key>shell</key>
					<dict/>
					<key>source</key>
					<dict/>
				</dict>
				<key>AMProvides</key>
				<dict>
					<key>Container</key>
					<string>List</string>
					<key>Types</key>
					<array>
						<string>com.apple.cocoa.path</string>
					</array>
				</dict>
				<key>ActionBundlePath</key>
				<string>/System/Library/Automator/Run Shell Script.action</string>
				<key>ActionName</key>
				<string>Run Shell Script</string>
				<key>ActionParameters</key>
				<dict>
					<key>COMMAND_STRING</key>
					<string>$escaped</string>
					<key>CheckedForUserDefaultShell</key>
					<true/>
					<key>inputMethod</key>
					<integer>1</integer>
					<key>shell</key>
					<string>/bin/bash</string>
					<key>source</key>
					<string></string>
				</dict>
				<key>BundleIdentifier</key>
				<string>com.apple.RunShellScript</string>
				<key>CFBundleVersion</key>
				<string>2.0.3</string>
				<key>CanShowSelectedItemsWhenRun</key>
				<false/>
				<key>CanShowWhenRun</key>
				<true/>
				<key>Category</key>
				<array>
					<string>AMCategoryUtilities</string>
				</array>
				<key>Class Name</key>
				<string>RunShellScriptAction</string>
				<key>InputUUID</key>
				<string>$(uuidgen)</string>
				<key>Keywords</key>
				<array>
					<string>Shell</string>
					<string>Script</string>
					<string>Command</string>
					<string>Run</string>
					<string>Unix</string>
				</array>
				<key>OutputUUID</key>
				<string>$(uuidgen)</string>
				<key>UUID</key>
				<string>$(uuidgen)</string>
				<key>UnlocalizedApplications</key>
				<array>
					<string>Automator</string>
				</array>
				<key>arguments</key>
				<dict>
					<key>0</key>
					<dict>
						<key>default value</key>
						<integer>0</integer>
						<key>name</key>
						<string>inputMethod</string>
						<key>required</key>
						<string>0</string>
						<key>type</key>
						<string>0</string>
						<key>uuid</key>
						<string>0</string>
					</dict>
					<key>1</key>
					<dict>
						<key>default value</key>
						<string></string>
						<key>name</key>
						<string>shell</string>
						<key>required</key>
						<string>0</string>
						<key>type</key>
						<string>0</string>
						<key>uuid</key>
						<string>1</string>
					</dict>
					<key>2</key>
					<dict>
						<key>default value</key>
						<string></string>
						<key>name</key>
						<string>source</string>
						<key>required</key>
						<string>0</string>
						<key>type</key>
						<string>0</string>
						<key>uuid</key>
						<string>2</string>
					</dict>
				</dict>
				<key>isViewVisible</key>
				<true/>
				<key>location</key>
				<string>309.000000:378.000000</string>
				<key>nibPath</key>
				<string>/System/Library/Automator/Run Shell Script.action/Contents/Resources/English.lproj/main.nib</string>
			</dict>
			<key>isViewVisible</key>
			<true/>
		</dict>
	</array>
	<key>connectors</key>
	<dict/>
	<key>workflowMetaData</key>
	<dict>
		<key>applicationBundleIDsByPath</key>
		<dict/>
		<key>applicationPaths</key>
		<array/>
		<key>inputTypeIdentifier</key>
		<string>com.apple.Automator.fileSystemObject</string>
		<key>outputTypeIdentifier</key>
		<string>com.apple.Automator.nothing</string>
		<key>presentationMode</key>
		<integer>11</integer>
		<key>processesInput</key>
		<integer>0</integer>
		<key>serviceInputTypeIdentifier</key>
		<string>com.apple.Automator.fileSystemObject</string>
		<key>serviceOutputTypeIdentifier</key>
		<string>com.apple.Automator.nothing</string>
		<key>serviceProcessesInput</key>
		<integer>0</integer>
		<key>shouldShowSelectedItemsWhenRun</key>
		<false/>
		<key>shouldShowWhenRun</key>
		<true/>
		<key>subtypes</key>
		<array>
			<dict>
				<key>outputBinding</key>
				<dict/>
			</dict>
		</array>
		<key>workflowTypeIdentifier</key>
		<string>com.apple.Automator.servicesMenu</string>
	</dict>
</dict>
</plist>
WFLOW

  cat > "$bundle/Contents/Info.plist" <<INFO
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>CFBundleName</key>
	<string>${name}</string>
	<key>CFBundleIdentifier</key>
	<string>com.user.ffmpeg.$(echo "$name" | tr ' /' '-.')</string>
	<key>CFBundleVersion</key>
	<string>1.0</string>
	<key>NSServices</key>
	<array>
		<dict>
			<key>NSMenuItem</key>
			<dict>
				<key>default</key>
				<string>${name}</string>
			</dict>
			<key>NSMessage</key>
			<string>runWorkflowAsService</string>
			<key>NSSendFileTypes</key>
			<array>
				<string>public.item</string>
			</array>
		</dict>
	</array>
</dict>
</plist>
INFO

  echo "  Created: ${name}.workflow"
}

# ---------------------------------------------------------------------------
# Common helpers embedded in every script
# ---------------------------------------------------------------------------
PREAMBLE='
export PATH="/usr/local/bin:/opt/homebrew/bin:/usr/bin:/bin:$PATH"

notify() {
  osascript -e "display notification \"$2\" with title \"$1\""
}

ffmpeg_check() {
  if ! command -v ffmpeg &>/dev/null; then
    osascript -e "display alert \"ffmpeg not found\" message \"Install ffmpeg via Homebrew: brew install ffmpeg\" as critical"
    exit 1
  fi
}

ffmpeg_check
'

echo "Generating workflows into: $OUTDIR"

# ===========================================================================
# VIDEO CONVERSIONS
# ===========================================================================

make_workflow "Convert Video to MP4 (H.264)" "${PREAMBLE}"'
for f in "$@"; do
  dir=$(dirname "$f")
  base=$(basename "${f%.*}")
  out="$dir/${base}.mp4"
  notify "FFmpeg" "Converting to MP4 (H.264): $base"
  ffmpeg -i "$f" -c:v libx264 -preset fast -crf 22 -c:a aac -b:a 192k -movflags +faststart -y "$out" \
    && notify "FFmpeg Done" "Saved: ${base}.mp4" \
    || notify "FFmpeg Error" "Failed: $base"
done
'

make_workflow "Convert Video to MP4 (H.265 HEVC)" "${PREAMBLE}"'
for f in "$@"; do
  dir=$(dirname "$f")
  base=$(basename "${f%.*}")
  out="$dir/${base}_hevc.mp4"
  notify "FFmpeg" "Converting to MP4 (H.265): $base"
  ffmpeg -i "$f" -c:v libx265 -preset fast -crf 28 -c:a aac -b:a 192k -movflags +faststart -tag:v hvc1 -y "$out" \
    && notify "FFmpeg Done" "Saved: ${base}_hevc.mp4" \
    || notify "FFmpeg Error" "Failed: $base"
done
'

make_workflow "Convert Video to WebM (VP9)" "${PREAMBLE}"'
for f in "$@"; do
  dir=$(dirname "$f")
  base=$(basename "${f%.*}")
  out="$dir/${base}.webm"
  notify "FFmpeg" "Converting to WebM (VP9): $base"
  ffmpeg -i "$f" -c:v libvpx-vp9 -crf 30 -b:v 0 -c:a libopus -b:a 128k -y "$out" \
    && notify "FFmpeg Done" "Saved: ${base}.webm" \
    || notify "FFmpeg Error" "Failed: $base"
done
'

make_workflow "Convert Video to GIF" "${PREAMBLE}"'
for f in "$@"; do
  dir=$(dirname "$f")
  base=$(basename "${f%.*}")
  out="$dir/${base}.gif"
  palette="/tmp/${base}_palette.png"
  notify "FFmpeg" "Converting to GIF: $base"
  ffmpeg -i "$f" -vf "fps=15,scale=640:-1:flags=lanczos,palettegen" -y "$palette" && \
  ffmpeg -i "$f" -i "$palette" -filter_complex "fps=15,scale=640:-1:flags=lanczos[x];[x][1:v]paletteuse" -y "$out" \
    && notify "FFmpeg Done" "Saved: ${base}.gif" \
    || notify "FFmpeg Error" "Failed: $base"
  rm -f "$palette"
done
'

make_workflow "Convert Video to MKV" "${PREAMBLE}"'
for f in "$@"; do
  dir=$(dirname "$f")
  base=$(basename "${f%.*}")
  out="$dir/${base}.mkv"
  notify "FFmpeg" "Converting to MKV: $base"
  ffmpeg -i "$f" -c:v libx264 -preset fast -crf 22 -c:a aac -b:a 192k -y "$out" \
    && notify "FFmpeg Done" "Saved: ${base}.mkv" \
    || notify "FFmpeg Error" "Failed: $base"
done
'

make_workflow "Convert Video to AVI" "${PREAMBLE}"'
for f in "$@"; do
  dir=$(dirname "$f")
  base=$(basename "${f%.*}")
  out="$dir/${base}.avi"
  notify "FFmpeg" "Converting to AVI: $base"
  ffmpeg -i "$f" -c:v mpeg4 -q:v 6 -c:a mp3 -q:a 4 -y "$out" \
    && notify "FFmpeg Done" "Saved: ${base}.avi" \
    || notify "FFmpeg Error" "Failed: $base"
done
'

make_workflow "Convert Video to MOV (ProRes)" "${PREAMBLE}"'
for f in "$@"; do
  dir=$(dirname "$f")
  base=$(basename "${f%.*}")
  out="$dir/${base}_prores.mov"
  notify "FFmpeg" "Converting to MOV (ProRes): $base"
  ffmpeg -i "$f" -c:v prores_ks -profile:v 3 -c:a pcm_s16le -y "$out" \
    && notify "FFmpeg Done" "Saved: ${base}_prores.mov" \
    || notify "FFmpeg Error" "Failed: $base"
done
'

make_workflow "Extract Audio from Video as MP3" "${PREAMBLE}"'
for f in "$@"; do
  dir=$(dirname "$f")
  base=$(basename "${f%.*}")
  out="$dir/${base}.mp3"
  notify "FFmpeg" "Extracting audio: $base"
  ffmpeg -i "$f" -vn -c:a libmp3lame -q:a 2 -y "$out" \
    && notify "FFmpeg Done" "Saved: ${base}.mp3" \
    || notify "FFmpeg Error" "Failed: $base"
done
'

# ===========================================================================
# AUDIO CONVERSIONS
# ===========================================================================

make_workflow "Convert Audio to MP3" "${PREAMBLE}"'
for f in "$@"; do
  dir=$(dirname "$f")
  base=$(basename "${f%.*}")
  out="$dir/${base}.mp3"
  notify "FFmpeg" "Converting to MP3: $base"
  ffmpeg -i "$f" -c:a libmp3lame -q:a 2 -y "$out" \
    && notify "FFmpeg Done" "Saved: ${base}.mp3" \
    || notify "FFmpeg Error" "Failed: $base"
done
'

make_workflow "Convert Audio to AAC (M4A)" "${PREAMBLE}"'
for f in "$@"; do
  dir=$(dirname "$f")
  base=$(basename "${f%.*}")
  out="$dir/${base}.m4a"
  notify "FFmpeg" "Converting to AAC/M4A: $base"
  ffmpeg -i "$f" -c:a aac -b:a 256k -y "$out" \
    && notify "FFmpeg Done" "Saved: ${base}.m4a" \
    || notify "FFmpeg Error" "Failed: $base"
done
'

make_workflow "Convert Audio to FLAC" "${PREAMBLE}"'
for f in "$@"; do
  dir=$(dirname "$f")
  base=$(basename "${f%.*}")
  out="$dir/${base}.flac"
  notify "FFmpeg" "Converting to FLAC: $base"
  ffmpeg -i "$f" -c:a flac -compression_level 8 -y "$out" \
    && notify "FFmpeg Done" "Saved: ${base}.flac" \
    || notify "FFmpeg Error" "Failed: $base"
done
'

make_workflow "Convert Audio to WAV" "${PREAMBLE}"'
for f in "$@"; do
  dir=$(dirname "$f")
  base=$(basename "${f%.*}")
  out="$dir/${base}.wav"
  notify "FFmpeg" "Converting to WAV: $base"
  ffmpeg -i "$f" -c:a pcm_s16le -y "$out" \
    && notify "FFmpeg Done" "Saved: ${base}.wav" \
    || notify "FFmpeg Error" "Failed: $base"
done
'

make_workflow "Convert Audio to OGG Vorbis" "${PREAMBLE}"'
for f in "$@"; do
  dir=$(dirname "$f")
  base=$(basename "${f%.*}")
  out="$dir/${base}.ogg"
  notify "FFmpeg" "Converting to OGG Vorbis: $base"
  # Use libvorbis if available, otherwise fall back to the native vorbis encoder
  # (which requires -strict experimental on most builds)
  if ffmpeg -encoders 2>/dev/null | grep -q "libvorbis"; then
    enc_opts="-c:a libvorbis -q:a 5"
  else
    enc_opts="-c:a vorbis -strict experimental -q:a 5"
  fi
  ffmpeg -i "$f" $enc_opts -y "$out" \
    && notify "FFmpeg Done" "Saved: ${base}.ogg" \
    || notify "FFmpeg Error" "Failed: $base"
done
'

make_workflow "Convert Audio to OPUS" "${PREAMBLE}"'
for f in "$@"; do
  dir=$(dirname "$f")
  base=$(basename "${f%.*}")
  out="$dir/${base}.opus"
  notify "FFmpeg" "Converting to OPUS: $base"
  ffmpeg -i "$f" -c:a libopus -b:a 128k -y "$out" \
    && notify "FFmpeg Done" "Saved: ${base}.opus" \
    || notify "FFmpeg Error" "Failed: $base"
done
'

# ===========================================================================
# IMAGE SEQUENCE → VIDEO
# ===========================================================================

IMG_SEQ_SCRIPT="${PREAMBLE}"
IMG_SEQ_SCRIPT+='
# Expects the user to select any one image from the sequence.
# Detects the numeric padding pattern automatically (e.g. frame001.png -> frame%03d.png).
for f in "$@"; do
  dir=$(dirname "$f")
  base=$(basename "$f")

  # Build printf-style pattern: frame001.png -> frame%03d.png
  numpart=$(echo "$base" | grep -oE "[0-9]+" | head -1)
  if [ -n "$numpart" ]; then
    padlen=${#numpart}
    pattern=$(echo "$base" | sed -E "s/[0-9]+/%0${padlen}d/")
  else
    pattern="$base"
  fi

  out="$dir/output_sequence.mp4"
  notify "FFmpeg" "Converting image sequence to MP4"
  ffmpeg -framerate 24 -i "$dir/$pattern" \
    -c:v libx264 -preset fast -crf 22 -pix_fmt yuv420p -movflags +faststart -y "$out" \
    && notify "FFmpeg Done" "Saved: output_sequence.mp4" \
    || notify "FFmpeg Error" "Failed to convert sequence"
  break
done
'
make_workflow "Image Sequence to MP4" "$IMG_SEQ_SCRIPT"

echo ""
echo "Done! ${#} workflows generated in: $OUTDIR"
echo ""
echo "To install, either:"
echo "  1. Double-click each .workflow file in Finder"
echo "  2. Or copy them to ~/Library/Services/:"
echo "     cp -r $OUTDIR/*.workflow ~/Library/Services/"
echo ""
echo "Then right-click any file in Finder -> Quick Actions (or Services)"
echo "to see the new conversion options."
