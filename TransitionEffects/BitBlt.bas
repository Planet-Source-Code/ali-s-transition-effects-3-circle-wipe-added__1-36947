Attribute VB_Name = "BitBlt_mod"
Option Explicit

' Enumerated raster operation constants
Public Enum RasterOps

' Copies the source bitmap to destination bitmap
SRCCOPY = &HCC0020

' Combines pixels of the destination with source bitmap using the Boolean AND operator.
SRCAND = &H8800C6

' Combines pixels of the destination with source bitmap using the Boolean XOR operator.
SRCINVERT = &H660046
nXor = &H660046
' Combines pixels of the destination with source bitmap using the Boolean OR operator.
SRCPAINT = &HEE0086
nOR = &HEE0086
' Inverts the destination bitmap and then combines the results with the source bitmap
' using the Boolean AND operator.
SRCERASE = &H4400328

' Turns all output white.
WHITENESS = &HFF0062

' Turn output black.
BLACKNESS = &H42

NOTSRCCOPY = &H330008      ' (DWORD) dest = (NOT source)
NOTSRCERASE = &H1100A6     ' (DWORD) dest = (NOT src) AND (NOT dest)
MERGECOPY = &HC000CA       ' (DWORD) dest = (source AND pattern)
MERGEPAINT = &HBB0226      ' (DWORD) dest = (NOT source) OR dest
DSTINVERT = &H550009       ' (DWORD) dest = (NOT dest)

PATCOPY = &HF00021 ' (DWORD) dest = pattern
PATPAINT = &HFB0A09        ' (DWORD) dest = DPSnoo
PATINVERT = &H5A0049       ' (DWORD) dest = pattern XOR dest
R_WHITE = 16
End Enum
 
' BitBlt API Public Declaration
    Public Declare Function BitBlt Lib "gdi32" ( _
        ByVal hDestDC As Long, _
        ByVal x As Long, _
        ByVal y As Long, _
        ByVal nWidth As Long, _
        ByVal nHeight As Long, _
        ByVal hSrcDC As Long, _
        ByVal xSrc As Long, _
        ByVal ySrc As Long, _
        ByVal dwRop As RasterOps _
        ) As Long
 

Public Declare Function PatBlt Lib "gdi32" (ByVal hdc As Long, ByVal x As Long, ByVal y As Long, ByVal nWidth As Long, ByVal nHeight As Long, ByVal dwRop As RasterOps) As Long
Public Declare Function StretchBlt Lib "gdi32" (ByVal hdc As Long, ByVal x As Long, ByVal y As Long, ByVal nWidth As Long, ByVal nHeight As Long, ByVal hSrcDC As Long, ByVal xSrc As Long, ByVal ySrc As Long, ByVal nSrcWidth As Long, ByVal nSrcHeight As Long, ByVal dwRop As RasterOps) As Long
Public Declare Function SetStretchBltMode Lib "gdi32" (ByVal hdc As Long, ByVal nStretchMode As Long) As Long

