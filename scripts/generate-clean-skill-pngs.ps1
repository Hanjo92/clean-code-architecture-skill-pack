Add-Type -AssemblyName System.Drawing

function Get-ColorFromHex {
    param([string]$Hex)
    $hex = $Hex.TrimStart('#')
    [System.Drawing.Color]::FromArgb(
        255,
        [Convert]::ToInt32($hex.Substring(0, 2), 16),
        [Convert]::ToInt32($hex.Substring(2, 2), 16),
        [Convert]::ToInt32($hex.Substring(4, 2), 16)
    )
}

function Get-DarkerColor {
    param([System.Drawing.Color]$Color, [double]$Factor)
    [System.Drawing.Color]::FromArgb(
        255,
        [Math]::Round($Color.R * $Factor),
        [Math]::Round($Color.G * $Factor),
        [Math]::Round($Color.B * $Factor)
    )
}

function New-RoundedRectPath {
    param([float]$X, [float]$Y, [float]$Width, [float]$Height, [float]$Radius)
    $path = New-Object System.Drawing.Drawing2D.GraphicsPath
    $diameter = $Radius * 2
    $path.AddArc($X, $Y, $diameter, $diameter, 180, 90)
    $path.AddArc($X + $Width - $diameter, $Y, $diameter, $diameter, 270, 90)
    $path.AddArc($X + $Width - $diameter, $Y + $Height - $diameter, $diameter, $diameter, 0, 90)
    $path.AddArc($X, $Y + $Height - $diameter, $diameter, $diameter, 90, 90)
    $path.CloseFigure()
    return $path
}

function Set-GraphicsQuality {
    param([System.Drawing.Graphics]$Graphics)
    $Graphics.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
    $Graphics.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
    $Graphics.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
}

function Draw-BrandFrame {
    param(
        [System.Drawing.Graphics]$Graphics,
        [float]$Width,
        [float]$Height,
        [System.Drawing.Color]$Background
    )
    $cream = Get-ColorFromHex '#F6F4EE'
    $full = New-RoundedRectPath 0 0 $Width $Height ($Height * 0.25)
    $inner = New-RoundedRectPath ($Width * 0.125) ($Height * 0.125) ($Width * 0.75) ($Height * 0.75) ($Height * 0.22)
    $bgBrush = New-Object System.Drawing.SolidBrush($Background)
    $innerBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(20, $cream))
    $borderPen = New-Object System.Drawing.Pen -ArgumentList ([System.Drawing.Color]::FromArgb(46, $cream)), ([single]([Math]::Max(2, $Width * 0.016)))
    $dotBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(56, $cream))

    $Graphics.FillPath($bgBrush, $full)
    $Graphics.FillPath($innerBrush, $inner)
    $Graphics.DrawPath($borderPen, $inner)
    $dotSize = $Width * 0.125
    $Graphics.FillEllipse($dotBrush, $Width * 0.69, $Height * 0.19, $dotSize, $dotSize)

    $bgBrush.Dispose()
    $innerBrush.Dispose()
    $borderPen.Dispose()
    $dotBrush.Dispose()
    $full.Dispose()
    $inner.Dispose()
}

function Draw-FoundationMark {
    param([System.Drawing.Graphics]$Graphics, [float]$Scale, [float]$OffsetX, [float]$OffsetY, [System.Drawing.Color]$Cream)
    $pen1 = New-Object System.Drawing.Pen -ArgumentList $Cream, ([single](4 * $Scale))
    $pen2 = New-Object System.Drawing.Pen -ArgumentList $Cream, ([single](3 * $Scale))
    $fill = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(40, $Cream))
    $dot = New-Object System.Drawing.SolidBrush($Cream)
    $outer = New-RoundedRectPath (18 * $Scale + $OffsetX) (18 * $Scale + $OffsetY) (28 * $Scale) (28 * $Scale) (9 * $Scale)
    $inner = New-RoundedRectPath (25 * $Scale + $OffsetX) (25 * $Scale + $OffsetY) (14 * $Scale) (14 * $Scale) (4 * $Scale)
    $Graphics.DrawPath($pen1, $outer)
    $Graphics.FillPath($fill, $inner)
    $Graphics.DrawPath($pen2, $inner)
    $Graphics.FillEllipse($dot, 29.5 * $Scale + $OffsetX, 29.5 * $Scale + $OffsetY, 5 * $Scale, 5 * $Scale)
    $pen1.Dispose(); $pen2.Dispose(); $fill.Dispose(); $dot.Dispose(); $outer.Dispose(); $inner.Dispose()
}

function Draw-RouterMark {
    param([System.Drawing.Graphics]$Graphics, [float]$Scale, [float]$OffsetX, [float]$OffsetY, [System.Drawing.Color]$Cream)
    $pen = New-Object System.Drawing.Pen -ArgumentList $Cream, ([single](4 * $Scale))
    $pen.StartCap = [System.Drawing.Drawing2D.LineCap]::Round
    $pen.EndCap = [System.Drawing.Drawing2D.LineCap]::Round
    $brush = New-Object System.Drawing.SolidBrush($Cream)
    $Graphics.FillEllipse($brush, 16 * $Scale + $OffsetX, 18 * $Scale + $OffsetY, 8 * $Scale, 8 * $Scale)
    $Graphics.FillEllipse($brush, 40 * $Scale + $OffsetX, 18 * $Scale + $OffsetY, 8 * $Scale, 8 * $Scale)
    $Graphics.FillEllipse($brush, 28 * $Scale + $OffsetX, 38 * $Scale + $OffsetY, 8 * $Scale, 8 * $Scale)
    $Graphics.DrawLine($pen, 24 * $Scale + $OffsetX, 22 * $Scale + $OffsetY, 28 * $Scale + $OffsetX, 22 * $Scale + $OffsetY)
    $Graphics.DrawBezier($pen, 28 * $Scale + $OffsetX, 22 * $Scale + $OffsetY, 32 * $Scale + $OffsetX, 22 * $Scale + $OffsetY, 32 * $Scale + $OffsetX, 30 * $Scale + $OffsetY, 32 * $Scale + $OffsetX, 42 * $Scale + $OffsetY)
    $Graphics.DrawLine($pen, 40 * $Scale + $OffsetX, 22 * $Scale + $OffsetY, 36 * $Scale + $OffsetX, 22 * $Scale + $OffsetY)
    $Graphics.DrawBezier($pen, 36 * $Scale + $OffsetX, 22 * $Scale + $OffsetY, 32 * $Scale + $OffsetX, 22 * $Scale + $OffsetY, 32 * $Scale + $OffsetX, 30 * $Scale + $OffsetY, 32 * $Scale + $OffsetX, 42 * $Scale + $OffsetY)
    $pen.Dispose(); $brush.Dispose()
}

function Draw-RefactorMark {
    param([System.Drawing.Graphics]$Graphics, [float]$Scale, [float]$OffsetX, [float]$OffsetY, [System.Drawing.Color]$Cream)
    $pen = New-Object System.Drawing.Pen -ArgumentList $Cream, ([single](4 * $Scale))
    $pen.StartCap = [System.Drawing.Drawing2D.LineCap]::Round
    $pen.EndCap = [System.Drawing.Drawing2D.LineCap]::Round
    $pen.LineJoin = [System.Drawing.Drawing2D.LineJoin]::Round
    $Graphics.DrawLine($pen, 18 * $Scale + $OffsetX, 18 * $Scale + $OffsetY, 30 * $Scale + $OffsetX, 18 * $Scale + $OffsetY)
    $Graphics.DrawLine($pen, 20 * $Scale + $OffsetX, 44 * $Scale + $OffsetY, 28 * $Scale + $OffsetX, 36 * $Scale + $OffsetY)
    $Graphics.DrawLine($pen, 28 * $Scale + $OffsetX, 36 * $Scale + $OffsetY, 42 * $Scale + $OffsetX, 22 * $Scale + $OffsetY)
    $Graphics.DrawLine($pen, 42 * $Scale + $OffsetX, 22 * $Scale + $OffsetY, 48 * $Scale + $OffsetX, 28 * $Scale + $OffsetY)
    $Graphics.DrawLine($pen, 34 * $Scale + $OffsetX, 42 * $Scale + $OffsetY, 48 * $Scale + $OffsetX, 28 * $Scale + $OffsetY)
    $Graphics.DrawLine($pen, 20 * $Scale + $OffsetX, 44 * $Scale + $OffsetY, 20 * $Scale + $OffsetX, 50 * $Scale + $OffsetY)
    $Graphics.DrawLine($pen, 20 * $Scale + $OffsetX, 50 * $Scale + $OffsetY, 26 * $Scale + $OffsetX, 50 * $Scale + $OffsetY)
    $pen.Dispose()
}

function Draw-BuildMark {
    param([System.Drawing.Graphics]$Graphics, [float]$Scale, [float]$OffsetX, [float]$OffsetY, [System.Drawing.Color]$Cream)
    $pen = New-Object System.Drawing.Pen -ArgumentList $Cream, ([single](4 * $Scale))
    $pen.StartCap = [System.Drawing.Drawing2D.LineCap]::Round
    $pen.EndCap = [System.Drawing.Drawing2D.LineCap]::Round
    $pen.LineJoin = [System.Drawing.Drawing2D.LineJoin]::Round
    $r1 = New-RoundedRectPath (16 * $Scale + $OffsetX) (20 * $Scale + $OffsetY) (12 * $Scale) (24 * $Scale) (4 * $Scale)
    $r2 = New-RoundedRectPath (36 * $Scale + $OffsetX) (16 * $Scale + $OffsetY) (12 * $Scale) (12 * $Scale) (4 * $Scale)
    $r3 = New-RoundedRectPath (36 * $Scale + $OffsetX) (36 * $Scale + $OffsetY) (12 * $Scale) (12 * $Scale) (4 * $Scale)
    $Graphics.DrawPath($pen, $r1); $Graphics.DrawPath($pen, $r2); $Graphics.DrawPath($pen, $r3)
    $Graphics.DrawLine($pen, 28 * $Scale + $OffsetX, 32 * $Scale + $OffsetY, 36 * $Scale + $OffsetX, 32 * $Scale + $OffsetY)
    $Graphics.DrawLine($pen, 42 * $Scale + $OffsetX, 28 * $Scale + $OffsetY, 42 * $Scale + $OffsetX, 36 * $Scale + $OffsetY)
    $pen.Dispose(); $r1.Dispose(); $r2.Dispose(); $r3.Dispose()
}

function Draw-Mark {
    param([System.Drawing.Graphics]$Graphics, [string]$Kind, [float]$Scale, [float]$OffsetX, [float]$OffsetY, [System.Drawing.Color]$Cream)
    switch ($Kind) {
        'foundation' { Draw-FoundationMark $Graphics $Scale $OffsetX $OffsetY $Cream }
        'router' { Draw-RouterMark $Graphics $Scale $OffsetX $OffsetY $Cream }
        'refactor' { Draw-RefactorMark $Graphics $Scale $OffsetX $OffsetY $Cream }
        'build' { Draw-BuildMark $Graphics $Scale $OffsetX $OffsetY $Cream }
    }
}

function Save-IconPng {
    param([string]$Path, [System.Drawing.Color]$Color, [string]$Kind)
    $size = 512
    $bmp = New-Object System.Drawing.Bitmap $size, $size
    $g = [System.Drawing.Graphics]::FromImage($bmp)
    Set-GraphicsQuality $g
    Draw-BrandFrame $g $size $size $Color
    $cream = Get-ColorFromHex '#F6F4EE'
    Draw-Mark $g $Kind ($size / 64) 0 0 $cream
    $bmp.Save($Path, [System.Drawing.Imaging.ImageFormat]::Png)
    $g.Dispose(); $bmp.Dispose()
}

function Save-LogoPng {
    param([string]$Path, [System.Drawing.Color]$Color, [string]$Kind)
    $width = 1600
    $height = 600
    $bmp = New-Object System.Drawing.Bitmap $width, $height
    $g = [System.Drawing.Graphics]::FromImage($bmp)
    Set-GraphicsQuality $g
    Draw-BrandFrame $g $width $height $Color
    $cream = Get-ColorFromHex '#F6F4EE'
    $panelColor = Get-DarkerColor $Color 0.78
    $panel = New-RoundedRectPath 130 130 340 340 88
    $panelBrush = New-Object System.Drawing.SolidBrush($panelColor)
    $g.FillPath($panelBrush, $panel)
    Draw-Mark $g $Kind (340 / 64) 130 130 $cream
    $panelBrush.Dispose(); $panel.Dispose()
    $pen = New-Object System.Drawing.Pen -ArgumentList $cream, ([single]40)
    $pen.StartCap = [System.Drawing.Drawing2D.LineCap]::Round
    $pen.EndCap = [System.Drawing.Drawing2D.LineCap]::Round
    $softPen = New-Object System.Drawing.Pen -ArgumentList ([System.Drawing.Color]::FromArgb(198, $cream)), ([single]40)
    $softPen.StartCap = [System.Drawing.Drawing2D.LineCap]::Round
    $softPen.EndCap = [System.Drawing.Drawing2D.LineCap]::Round
    $g.DrawLine($pen, 590, 230, 980, 230)
    $g.DrawLine($softPen, 590, 370, 1260, 370)
    $pen.Dispose(); $softPen.Dispose()
    $bmp.Save($Path, [System.Drawing.Imaging.ImageFormat]::Png)
    $g.Dispose(); $bmp.Dispose()
}

$skills = @(
    @{ path = 'D:\CleanCode\skills\clean-code-architecture-foundation\assets'; color = '#1F4B99'; kind = 'foundation' },
    @{ path = 'D:\CleanCode\skills\clean-code-architecture-router\assets'; color = '#0F766E'; kind = 'router' },
    @{ path = 'D:\CleanCode\skills\clean-code-diagnose-refactor\assets'; color = '#B45309'; kind = 'refactor' },
    @{ path = 'D:\CleanCode\skills\clean-architecture-requirements-build\assets'; color = '#256F3A'; kind = 'build' }
)

foreach ($skill in $skills) {
    $color = Get-ColorFromHex $skill.color
    Save-IconPng (Join-Path $skill.path 'icon.png') $color $skill.kind
    Save-LogoPng (Join-Path $skill.path 'logo.png') $color $skill.kind
}
