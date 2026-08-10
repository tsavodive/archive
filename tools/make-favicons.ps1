param([string]$src, [string]$dir)

# ASCII-only on purpose: PowerShell 5.1 reads .ps1 as ANSI without a BOM,
# so non-ASCII paths/comments inside the file get mangled. Paths come in as args.

Add-Type -AssemblyName System.Drawing

function Get-ResizedBitmap([string]$path, [int]$size) {
  $img = [System.Drawing.Image]::FromFile($path)
  # 24bpp: the source is an opaque photo, so an alpha channel only wastes bytes.
  $bmp = New-Object System.Drawing.Bitmap $size, $size, ([System.Drawing.Imaging.PixelFormat]::Format24bppRgb)
  $g   = [System.Drawing.Graphics]::FromImage($bmp)
  $g.CompositingQuality = 'HighQuality'
  $g.InterpolationMode  = 'HighQualityBicubic'
  $g.SmoothingMode      = 'HighQuality'
  $g.PixelOffsetMode    = 'HighQuality'
  $g.DrawImage($img, 0, 0, $size, $size)
  $g.Dispose(); $img.Dispose()
  return $bmp
}

function Get-ResizedJpeg([string]$path, [int]$size, [int]$quality) {
  $bmp = Get-ResizedBitmap $path $size
  $enc = [System.Drawing.Imaging.ImageCodecInfo]::GetImageEncoders() | Where-Object { $_.MimeType -eq 'image/jpeg' }
  $ps  = New-Object System.Drawing.Imaging.EncoderParameters 1
  $ps.Param[0] = New-Object System.Drawing.Imaging.EncoderParameter ([System.Drawing.Imaging.Encoder]::Quality), ([Int64]$quality)
  $ms = New-Object System.IO.MemoryStream
  $bmp.Save($ms, $enc, $ps)
  $bytes = $ms.ToArray()
  $ms.Dispose(); $ps.Dispose(); $bmp.Dispose()
  return ,$bytes
}

function Get-ResizedPng([string]$path, [int]$size) {
  $bmp = Get-ResizedBitmap $path $size
  $ms  = New-Object System.IO.MemoryStream
  $bmp.Save($ms, [System.Drawing.Imaging.ImageFormat]::Png)
  $bytes = $ms.ToArray()
  $ms.Dispose(); $bmp.Dispose()
  return ,$bytes
}

# --- 1. plain PNG icons ---
$targets = [ordered]@{
  'favicon-96x96.png'            = 96
  'apple-touch-icon.png'         = 180
  'web-app-manifest-192x192.png' = 192
  'web-app-manifest-512x512.png' = 512
}
foreach ($name in $targets.Keys) {
  $bytes = Get-ResizedPng $src $targets[$name]
  [System.IO.File]::WriteAllBytes((Join-Path $dir $name), $bytes)
  "  {0,-30} {1,4}px  {2,7} bytes" -f $name, $targets[$name], $bytes.Length
}

# --- 2. favicon.ico : ICONDIR + ICONDIRENTRY[N] + PNG payloads ---
$sizes  = @(16, 32, 48)
$images = @()
foreach ($s in $sizes) { $images += ,(Get-ResizedPng $src $s) }

$ms = New-Object System.IO.MemoryStream
$bw = New-Object System.IO.BinaryWriter $ms
$bw.Write([UInt16]0)            # reserved
$bw.Write([UInt16]1)            # type = icon
$bw.Write([UInt16]$sizes.Count)

$offset = 6 + (16 * $sizes.Count)
for ($i = 0; $i -lt $sizes.Count; $i++) {
  $bw.Write([Byte]$sizes[$i])   # width  (0 means 256)
  $bw.Write([Byte]$sizes[$i])   # height
  $bw.Write([Byte]0)            # palette size
  $bw.Write([Byte]0)            # reserved
  $bw.Write([UInt16]1)          # color planes
  $bw.Write([UInt16]32)         # bits per pixel
  $bw.Write([UInt32]$images[$i].Length)
  $bw.Write([UInt32]$offset)
  $offset += $images[$i].Length
}
foreach ($im in $images) { $bw.Write($im) }
$bw.Flush()
$icoBytes = $ms.ToArray()
[System.IO.File]::WriteAllBytes((Join-Path $dir 'favicon.ico'), $icoBytes)
"  {0,-30} {1,6}  {2,7} bytes" -f 'favicon.ico', '16/32/48', $icoBytes.Length
$bw.Dispose(); $ms.Dispose()

# --- 3. favicon.svg : SVG wrapper around a base64 JPEG ---
# Chrome prefers the SVG icon when present, so the theme default must be
# replaced here too or the old image keeps showing.
# This file is fetched on every page view, so keep it small: a 96px JPEG is
# already ~5x the pixels a browser tab renders (16-20px).
$jpg64 = [Convert]::ToBase64String((Get-ResizedJpeg $src 96 88))
$svg = '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512" width="512" height="512"><image href="data:image/jpeg;base64,' + $jpg64 + '" width="512" height="512"/></svg>'
[System.IO.File]::WriteAllText((Join-Path $dir 'favicon.svg'), $svg, (New-Object System.Text.UTF8Encoding $false))
"  {0,-30} {1,6}  {2,7} bytes" -f 'favicon.svg', '96px', $svg.Length
