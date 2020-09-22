Attribute VB_Name = "modTransEffects"
Public Const WHITE_BRUSH = 0
Public Const BLACK_BRUSH = 4
Public Declare Function Rectangle Lib "gdi32" (ByVal hdc As Long, ByVal X1 As Long, ByVal Y1 As Long, ByVal X2 As Long, ByVal Y2 As Long) As Long
Public Declare Function CreateSolidBrush Lib "gdi32" (ByVal crColor As Long) As Long

'   Transition Effects By Mohammed Ali Sohrabi ,ali6236@yahoo.com
'   Ver 3
'   Cool Transition for your program!
'   You can use this module in your program just put my name in about section!
'   *********
'   Please feedback.(for everything!)
Option Explicit

Public Enum SideUD_Enum
    sUp = 1
    sDown = 2
End Enum
Public Enum SideLR_Enum
    sLeft = 1
    sRight = 2
End Enum
Public Enum Side_all
    aUp = 1
    aDown = 2
    aLeft = 4
    aRight = 8
End Enum
Public Enum Side_HV
    VerticalSide = 1
    HorizontalSide = 2
End Enum
Public Enum PushModeEnum
    Pushing = 1
    Hiding = 2
    Moving = 3
End Enum

Public Declare Function GetTickCount Lib "kernel32" () As Long
Public Const MS_DELAY = 1
Public mblnRunning As Boolean, Ended As Boolean
Public mlngTimer As Long
Public lngSpeed As Long

Private Type POINTAPI
        X As Long
        Y As Long
End Type

Private Declare Function CreateCompatibleBitmap Lib "gdi32" (ByVal hdc As Long, ByVal nWidth As Long, ByVal nHeight As Long) As Long
Private Declare Function CreateCompatibleDC Lib "gdi32" (ByVal hdc As Long) As Long
Private Declare Function SelectObject Lib "gdi32" (ByVal hdc As Long, ByVal hObject As Long) As Long
Private Declare Function LineTo Lib "gdi32" (ByVal hdc As Long, ByVal X As Long, ByVal Y As Long) As Long
Private Declare Function DeleteDC Lib "gdi32" (ByVal hdc As Long) As Long
Private Declare Function DeleteObject Lib "gdi32" (ByVal hObject As Long) As Long
Private Declare Function MoveToEx Lib "gdi32" (ByVal hdc As Long, ByVal X As Long, ByVal Y As Long, lpPoint As POINTAPI) As Long
Private Declare Function Ellipse Lib "gdi32" (ByVal hdc As Long, ByVal X1 As Long, ByVal Y1 As Long, ByVal X2 As Long, ByVal Y2 As Long) As Long
Public Declare Function GetStockObject Lib "gdi32" (ByVal nIndex As Long) As Long


Public Sub RandomLines(DestPic As PictureBox, NewPic As PictureBox, Optional Side As Side_HV = VerticalSide, Optional RefreshRate As Long = 0)
    If IsReady Then
        Ended = False
        Dim pxWidth As Long, pxHeight As Long
        Dim ScreenTX As Long, ScreenTY As Long
        Dim X_Arr() As Long, XLeng As Long
        Dim r1 As Long, i As Long, j As Long, t As Long
        Dim RRate As Long, Cntr As Long
        
        ScreenTX = Screen.TwipsPerPixelX
        ScreenTY = Screen.TwipsPerPixelY
        pxWidth = DestPic.Width \ ScreenTX
        pxHeight = DestPic.Height \ ScreenTY
        
        If Side = VerticalSide Then
            XLeng = pxWidth
        Else
            XLeng = pxHeight
        End If
        ReDim X_Arr(XLeng)
        'Create Table
        For i = 1 To XLeng
            X_Arr(i) = i
        Next
        'Mixing table!
        For j = 1 To 3
            For i = 1 To XLeng
                r1 = CInt(Rnd * XLeng)
                t = X_Arr(r1)
                X_Arr(r1) = X_Arr(i)
                X_Arr(i) = t
            Next
        Next
        mblnRunning = True
            'Loop starts here
            Do While mblnRunning
                If mlngTimer + lngSpeed <= GetTickCount() Then
                    'BitBlting
                    For RRate = 0 To RefreshRate
                        If Cntr >= XLeng Then
                            'we want to stop
                            mblnRunning = False
                            'Set new picture, you can use bitblt too.
                            Set DestPic.Picture = NewPic.Picture
                            Exit Sub
                        End If
                        If Side = VerticalSide Then
                            BitBlt DestPic.hdc, X_Arr(Cntr), 0, 1, pxHeight, NewPic.hdc, X_Arr(Cntr), 0, SRCCOPY
                        Else
                            BitBlt DestPic.hdc, 0, X_Arr(Cntr), pxWidth, 1, NewPic.hdc, 0, X_Arr(Cntr), SRCCOPY
                        End If
                        Cntr = Cntr + 1
                    Next
                    'Refresh Picture
                    DestPic.Refresh
                    'Refresh Timer
                    mlngTimer = GetTickCount()  'Reset the timer variable
                End If
            DoEvents
            Loop
        mblnRunning = False
    End If
    Ended = True
End Sub

Public Sub Slide(DestPic As PictureBox, PrevPic As PictureBox, NewPic As PictureBox, Optional Side As Side_all = aUp, Optional Steps As Long = 1)
'Not Completed : Left and Right
    If IsReady Then
        Ended = False
        Dim pxWidth As Long, pxHeight As Long
        Dim ScreenTX As Long, ScreenTY As Long
        Dim r1 As Long, i As Long, j As Long, t As Long
        Dim RRate As Long, Cntr As Long
        Dim XLeng As Long
        
        Set DestPic.Picture = PrevPic.Picture
        ScreenTX = Screen.TwipsPerPixelX
        ScreenTY = Screen.TwipsPerPixelY
        pxWidth = DestPic.Width \ ScreenTX
        pxHeight = DestPic.Height \ ScreenTY
        
        If Side > 2 Then
            XLeng = pxWidth \ 2
        Else
            XLeng = pxHeight \ 2
        End If
        mblnRunning = True
            'Loop starts here
            Do While mblnRunning
                If mlngTimer + lngSpeed <= GetTickCount() Then
                    If Side = aUp Then
                        'Prev Picture go up
                        BitBlt DestPic.hdc, 0, 0, pxWidth, pxHeight - Cntr, PrevPic.hdc, 0, Cntr, SRCCOPY
                        'New pic go down
                        BitBlt DestPic.hdc, 0, pxHeight - Cntr, pxWidth, Cntr, NewPic.hdc, 0, pxHeight - (2 * Cntr), SRCCOPY
                    ElseIf Side = aDown Then
                        'Prev pic go up
                        BitBlt DestPic.hdc, 0, Cntr, pxWidth, pxHeight - Cntr, PrevPic.hdc, 0, 0, SRCCOPY
                        'New pic come down
                        BitBlt DestPic.hdc, 0, 0, pxWidth, Cntr, NewPic.hdc, 0, Cntr, SRCCOPY
                    ElseIf Side = aLeft Then
                    ElseIf Side = aRight Then
                    End If
                    Cntr = Cntr + Steps
                    'Refresh Picture
                    DestPic.Refresh
                    'Refresh Timer
                    mlngTimer = GetTickCount()  'Reset the timer variable
                    'BitBlting
                    If Cntr >= XLeng Then
                        'we want to stop loop and then restart another loop!
                        mblnRunning = False
                    End If
                End If
            DoEvents
            Loop
            mblnRunning = True
            'Loop starts here
            Do While mblnRunning
                If mlngTimer + lngSpeed <= GetTickCount() Then
                    'BitBlting
                    If Cntr < 0 Then
                        'we want to stop
                        mblnRunning = False
                        'Set new picture, you can use bitblt too.
                        Set DestPic.Picture = NewPic.Picture
                        Exit Sub
                    End If
                    If Side = aUp Then
                        'Prev
                        BitBlt DestPic.hdc, 0, 0, pxWidth, Cntr, PrevPic.hdc, 0, Cntr, SRCCOPY
                        'New
                        BitBlt DestPic.hdc, 0, Cntr, pxWidth, pxHeight - Cntr, NewPic.hdc, 0, 0, SRCCOPY
                    ElseIf Side = aDown Then
                        'Prev pic go up
                        BitBlt DestPic.hdc, 0, Cntr, pxWidth, pxHeight - Cntr, PrevPic.hdc, 0, 0, SRCCOPY
                        'New pic come down
                        BitBlt DestPic.hdc, 0, 0, pxWidth, pxHeight - Cntr, NewPic.hdc, 0, Cntr, SRCCOPY
                    ElseIf Side = aLeft Then
                    ElseIf Side = aRight Then
                    End If
                    Cntr = Cntr - Steps
                    'Refresh Picture
                    DestPic.Refresh
                    'Refresh Timer
                    mlngTimer = GetTickCount()  'Reset the timer variable
                End If
            DoEvents
            Loop
        mblnRunning = False
    End If
    Ended = True
End Sub


Public Function IsReady() As Boolean
    IsReady = Not mblnRunning
End Function
Public Sub Stretching(DestPic As PictureBox, PrevPic As PictureBox, NewPic As PictureBox, Optional Side As SideLR_Enum = sLeft, Optional Step_all As Long = 1, Optional RefreshRate As Long = 0, Optional PushMode As PushModeEnum)
    If IsReady Then
        Ended = False
        Dim pxWidth As Long, pxHeight As Long
        Dim ScreenTX As Long, ScreenTY As Long
        Dim XLeng As Long
        Dim r1 As Long, i As Long, j As Long, t As Long
        Dim RRate As Long, Cntr As Long
        
        ScreenTX = Screen.TwipsPerPixelX
        ScreenTY = Screen.TwipsPerPixelY
        pxWidth = DestPic.ScaleWidth \ ScreenTX
        pxHeight = DestPic.ScaleHeight \ ScreenTY
        
        XLeng = pxWidth
        SetStretchBltMode DestPic.hdc, 4 'This is ColorOnColor(3)
                                         'HalfTone (4) mode is better but slower and need to call SetBrushOrgEx
        mblnRunning = True
            'Loop starts here
            Do While mblnRunning
                If mlngTimer + lngSpeed <= GetTickCount() Then
                    'BitBlting
                    For RRate = 0 To RefreshRate
                        If Cntr >= XLeng Then
                            'we want to stop
                            mblnRunning = False
                            'Set new picture, you can use bitblt too.
                            Set DestPic.Picture = NewPic.Picture
                            Exit Sub
                        End If
                        Select Case Side
                        Case sLeft
                            StretchBlt DestPic.hdc, 0, 0, Cntr, pxHeight, NewPic.hdc, 0, 0, pxWidth, pxHeight, SRCCOPY
                            If PushMode = 1 Then
                                'Push
                                StretchBlt DestPic.hdc, Cntr, 0, pxWidth - Cntr, pxHeight, PrevPic.hdc, 0, 0, pxWidth, pxHeight, SRCCOPY
                            ElseIf PushMode = 3 Then
                                'Move
                                BitBlt DestPic.hdc, Cntr, 0, pxWidth - Cntr, pxHeight, PrevPic.hdc, 0, 0, SRCCOPY
                            End If
                        Case sRight
                            StretchBlt DestPic.hdc, pxWidth - Cntr, 0, Cntr, pxHeight, NewPic.hdc, 0, 0, pxWidth, pxHeight, SRCCOPY
                            If PushMode = 1 Then
                                'Push
                                StretchBlt DestPic.hdc, 0, 0, pxWidth - Cntr, pxHeight, PrevPic.hdc, 0, 0, pxWidth, pxHeight, SRCCOPY
                            ElseIf PushMode = 3 Then
                                'Move
                                BitBlt DestPic.hdc, 0, 0, pxWidth - Cntr, pxHeight, PrevPic.hdc, Cntr, 0, SRCCOPY
                            End If
                        End Select
                        Cntr = Cntr + Step_all
                    Next
                    'Refresh Picture
                    DestPic.Refresh
                    'Refresh Timer
                    mlngTimer = GetTickCount()  'Reset the timer variable
                End If
            DoEvents
            Loop
        mblnRunning = False
    End If
    Ended = True
End Sub
Public Sub Wipe(DestPic As PictureBox, NewPic As PictureBox, Optional Side As Side_all = aUp, Optional Steps As Long = 1)
    If IsReady Then
        Ended = False
        Dim pxWidth As Long, pxHeight As Long
        Dim ScreenTX As Long, ScreenTY As Long
        Dim XLeng As Long
        Dim r1 As Long, i As Long, j As Long, t As Long
        Dim Cntr As Long
        
        ScreenTX = Screen.TwipsPerPixelX
        ScreenTY = Screen.TwipsPerPixelY
        pxWidth = DestPic.Width \ ScreenTX
        pxHeight = DestPic.Height \ ScreenTY
        
        If Side < aLeft Then
            XLeng = pxHeight
        Else
            XLeng = pxWidth
        End If
        mblnRunning = True
            'Loop starts here
            Do While mblnRunning
                If mlngTimer + lngSpeed <= GetTickCount() Then
                    'BitBlting
                    If Cntr >= XLeng Then
                        'we want to stop
                        mblnRunning = False
                        'Set new picture, you can use bitblt too.
                        Set DestPic.Picture = NewPic.Picture
                        Exit Sub
                    End If
                    Select Case Side
                    Case aUp
                        BitBlt DestPic.hdc, 0, 0, pxWidth, Cntr, NewPic.hdc, 0, 0, SRCCOPY
                    Case aDown
                        BitBlt DestPic.hdc, 0, pxHeight - Cntr, pxWidth, Cntr, NewPic.hdc, 0, pxHeight - Cntr, SRCCOPY
                    Case aLeft
                        BitBlt DestPic.hdc, 0, 0, Cntr, pxHeight, NewPic.hdc, 0, 0, SRCCOPY
                    Case aRight
                        BitBlt DestPic.hdc, pxWidth - Cntr, 0, Cntr, pxHeight, NewPic.hdc, pxWidth - Cntr, 0, SRCCOPY
                    End Select
                    Cntr = Cntr + Steps
                    'Refresh Picture
                    DestPic.Refresh
                    'Refresh Timer
                    mlngTimer = GetTickCount()  'Reset the timer variable
                End If
            DoEvents
            Loop
        mblnRunning = False
    End If
    Ended = True
End Sub

Public Sub Wipe_In(DestPic As PictureBox, NewPic As PictureBox, Optional Side As Side_HV = VerticalSide, Optional Steps As Long = 1)
    If IsReady Then
        Ended = False
        Dim pxWidth As Long, pxHeight As Long
        Dim ScreenTX As Long, ScreenTY As Long
        Dim XLeng As Long
        Dim r1 As Long, i As Long, j As Long, t As Long
        Dim Cntr As Long
        
        ScreenTX = Screen.TwipsPerPixelX
        ScreenTY = Screen.TwipsPerPixelY
        pxWidth = DestPic.Width \ ScreenTX
        pxHeight = DestPic.Height \ ScreenTY
        
        If Side = VerticalSide Then
            XLeng = pxHeight / 2
        Else
            XLeng = pxWidth / 2
        End If
        mblnRunning = True
            'Loop starts here
            Do While mblnRunning
                If mlngTimer + lngSpeed <= GetTickCount() Then
                    'BitBlting
                    If Cntr >= XLeng Then
                        'we want to stop
                        mblnRunning = False
                        'Set new picture, you can use bitblt too.
                        Set DestPic.Picture = NewPic.Picture
                        Exit Sub
                    End If
                    If Side = VerticalSide Then
                        BitBlt DestPic.hdc, 0, 0, pxWidth, Cntr, NewPic.hdc, 0, 0, SRCCOPY
                        BitBlt DestPic.hdc, 0, pxHeight - Cntr, pxWidth, Cntr, NewPic.hdc, 0, pxHeight - Cntr, SRCCOPY
                    ElseIf Side = HorizontalSide Then
                        BitBlt DestPic.hdc, 0, 0, Cntr, pxHeight, NewPic.hdc, 0, 0, SRCCOPY
                        BitBlt DestPic.hdc, pxWidth - Cntr, 0, Cntr, pxHeight, NewPic.hdc, pxWidth - Cntr, 0, SRCCOPY
                    End If
                    Cntr = Cntr + Steps
                    'Refresh Picture
                    DestPic.Refresh
                    'Refresh Timer
                    mlngTimer = GetTickCount()  'Reset the timer variable
                End If
            DoEvents
            Loop
        mblnRunning = False
    End If
    Ended = True
End Sub
Public Sub Wipe_Out(DestPic As PictureBox, NewPic As PictureBox, Optional Side As Side_HV = VerticalSide, Optional Steps As Long = 1)
    If IsReady Then
        Ended = False
        Dim pxWidth As Long, pxHeight As Long
        Dim ScreenTX As Long, ScreenTY As Long
        Dim XLeng As Long
        Dim r1 As Long, i As Long, j As Long, t As Long
        Dim Cntr As Long
        
        ScreenTX = Screen.TwipsPerPixelX
        ScreenTY = Screen.TwipsPerPixelY
        pxWidth = DestPic.Width \ ScreenTX
        pxHeight = DestPic.Height \ ScreenTY
        
        If Side = VerticalSide Then
            XLeng = pxHeight / 2
        Else
            XLeng = pxWidth / 2
        End If
        mblnRunning = True
            'Loop starts here
            Do While mblnRunning
                If mlngTimer + lngSpeed <= GetTickCount() Then
                    'BitBlting
                    If Cntr >= XLeng Then
                        'we want to stop
                        mblnRunning = False
                        'Set new picture, you can use bitblt too.
                        Set DestPic.Picture = NewPic.Picture
                        Exit Sub
                    End If
                    If Side = VerticalSide Then
                        BitBlt DestPic.hdc, 0, XLeng - Cntr, pxWidth, Cntr, NewPic.hdc, 0, XLeng - Cntr, SRCCOPY
                        BitBlt DestPic.hdc, 0, XLeng, pxWidth, Cntr, NewPic.hdc, 0, XLeng, SRCCOPY
                    ElseIf Side = HorizontalSide Then
                        BitBlt DestPic.hdc, XLeng - Cntr, 0, Cntr, pxHeight, NewPic.hdc, XLeng - Cntr, 0, SRCCOPY
                        BitBlt DestPic.hdc, XLeng, 0, Cntr, pxHeight, NewPic.hdc, XLeng, 0, SRCCOPY
                    End If
                    Cntr = Cntr + Steps
                    'Refresh Picture
                    DestPic.Refresh
                    'Refresh Timer
                    mlngTimer = GetTickCount()  'Reset the timer variable
                End If
            DoEvents
            Loop
        mblnRunning = False
    End If
    Ended = True
End Sub

Public Sub Bars_Draw(DestPic As PictureBox, NewPic As PictureBox, Optional Side As Side_HV = HorizontalSide, Optional Steps As Long = 1, Optional BarSize As Long = 10, Optional FirstBar_RightToLeft As Boolean = True)
    If IsReady Then
        Ended = False
        Dim pxWidth As Long, pxHeight As Long
        Dim ScreenTX As Long, ScreenTY As Long
        Dim XLeng As Long, OthXLeng As Long
        Dim tBars As Long, bltside As Boolean
        Dim Cntr As Long
        
        ScreenTX = Screen.TwipsPerPixelX
        ScreenTY = Screen.TwipsPerPixelY
        pxWidth = DestPic.Width \ ScreenTX
        pxHeight = DestPic.Height \ ScreenTY
        
        If Side = HorizontalSide Then
            XLeng = pxWidth
            OthXLeng = pxHeight
        Else
            XLeng = pxHeight
            OthXLeng = pxWidth
        End If
        mblnRunning = True
            'Loop starts here
            Do While mblnRunning
                If mlngTimer + lngSpeed <= GetTickCount() Then
                    'BitBlting
                    If Cntr >= XLeng Then
                        'we want to stop
                        mblnRunning = False
                        'Set new picture, you can use bitblt too.
                        Set DestPic.Picture = NewPic.Picture
                        Exit Sub
                    End If
                    bltside = FirstBar_RightToLeft
                    If Side = VerticalSide Then
                        For tBars = 0 To OthXLeng Step BarSize
                            If bltside Then
                                BitBlt DestPic.hdc, tBars, 0, BarSize, Cntr, NewPic.hdc, tBars, 0, SRCCOPY
                            Else
                                BitBlt DestPic.hdc, tBars, pxHeight - Cntr, BarSize, Cntr, NewPic.hdc, tBars, pxHeight - Cntr, SRCCOPY
                            End If
                            bltside = Not bltside
                        Next
                    Else
                        For tBars = 0 To OthXLeng Step BarSize
                            If bltside Then
                                BitBlt DestPic.hdc, 0, tBars, Cntr, BarSize, NewPic.hdc, 0, tBars, SRCCOPY
                            Else
                                BitBlt DestPic.hdc, pxWidth - Cntr, tBars, Cntr, BarSize, NewPic.hdc, pxWidth - Cntr, tBars, SRCCOPY
                            End If
                            bltside = Not bltside
                        Next
                    End If
                    Cntr = Cntr + Steps
                    'Refresh Picture
                    DestPic.Refresh
                    'Refresh Timer
                    mlngTimer = GetTickCount()  'Reset the timer variable
                End If
            DoEvents
            Loop
        mblnRunning = False
    End If
    Ended = True
End Sub

Public Sub Bars_Move(DestPic As PictureBox, NewPic As PictureBox, Optional Side As Side_HV = HorizontalSide, Optional Steps As Long = 1, Optional BarSize As Long = 10, Optional FirstBar_RightToLeft As Boolean = True)
    If IsReady Then
        Ended = False
        Dim pxWidth As Long, pxHeight As Long
        Dim ScreenTX As Long, ScreenTY As Long
        Dim XLeng As Long, OthXLeng As Long
        Dim tBars As Long, bltside As Boolean
        Dim Cntr As Long
        
        ScreenTX = Screen.TwipsPerPixelX
        ScreenTY = Screen.TwipsPerPixelY
        pxWidth = DestPic.Width \ ScreenTX
        pxHeight = DestPic.Height \ ScreenTY
        
        If Side = HorizontalSide Then
            XLeng = pxWidth
            OthXLeng = pxHeight
        Else
            XLeng = pxHeight
            OthXLeng = pxWidth
        End If
        mblnRunning = True
            'Loop starts here
            Do While mblnRunning
                If mlngTimer + lngSpeed <= GetTickCount() Then
                    'BitBlting
                    If Cntr >= XLeng Then
                        'we want to stop
                        mblnRunning = False
                        'Set new picture, you can use bitblt too.
                        Set DestPic.Picture = NewPic.Picture
                        Exit Sub
                    End If
                    bltside = FirstBar_RightToLeft
                    If Side = VerticalSide Then
                        For tBars = 0 To OthXLeng Step BarSize
                            If bltside Then
                                BitBlt DestPic.hdc, tBars, 0, BarSize, Cntr, NewPic.hdc, tBars, pxHeight - Cntr, SRCCOPY
                            Else
                                BitBlt DestPic.hdc, tBars, pxHeight - Cntr, BarSize, Cntr, NewPic.hdc, tBars, 0, SRCCOPY
                            End If
                            bltside = Not bltside
                        Next
                    Else
                        For tBars = 0 To OthXLeng Step BarSize
                            If bltside Then
                                BitBlt DestPic.hdc, 0, tBars, Cntr, BarSize, NewPic.hdc, pxWidth - Cntr, tBars, SRCCOPY
                            Else
                                BitBlt DestPic.hdc, pxWidth - Cntr, tBars, Cntr, BarSize, NewPic.hdc, 0, tBars, SRCCOPY
                            End If
                            bltside = Not bltside
                        Next
                    End If
                    Cntr = Cntr + Steps
                    'Refresh Picture
                    DestPic.Refresh
                    'Refresh Timer
                    mlngTimer = GetTickCount()  'Reset the timer variable
                End If
            DoEvents
            Loop
        mblnRunning = False
    End If
    Ended = True
End Sub

Public Sub Bars_Wipe(DestPic As PictureBox, NewPic As PictureBox, Optional Side As Side_all = aUp, Optional Steps As Long = 1, Optional BarSize As Long = 10)
    If IsReady Then
        Ended = False
        Dim pxWidth As Long, pxHeight As Long
        Dim ScreenTX As Long, ScreenTY As Long
        Dim XLeng As Long
        Dim tBars As Long
        Dim Cntr As Long
        
        ScreenTX = Screen.TwipsPerPixelX
        ScreenTY = Screen.TwipsPerPixelY
        pxWidth = DestPic.Width \ ScreenTX
        pxHeight = DestPic.Height \ ScreenTY
        
        mblnRunning = True
            'Loop starts here
            Do While mblnRunning
                If mlngTimer + lngSpeed <= GetTickCount() Then
                    'BitBlting
                    If Cntr >= BarSize Then
                        'we want to stop
                        mblnRunning = False
                        'Set new picture, you can use bitblt too.
                        Set DestPic.Picture = NewPic.Picture
                        Exit Sub
                    End If
                    If Side < aLeft Then
                        For tBars = 0 To pxHeight Step BarSize
                            If Side = aUp Then
                                BitBlt DestPic.hdc, 0, tBars, pxWidth, Cntr, NewPic.hdc, 0, tBars, SRCCOPY
                            Else
                                BitBlt DestPic.hdc, 0, tBars + BarSize - Cntr, pxWidth, Cntr, NewPic.hdc, 0, tBars + BarSize - Cntr, SRCCOPY
                            End If
                        Next
                    Else
                        For tBars = 0 To pxWidth Step BarSize
                            If Side = aLeft Then
                                BitBlt DestPic.hdc, tBars, 0, Cntr, pxHeight, NewPic.hdc, tBars, 0, SRCCOPY
                            Else
                                BitBlt DestPic.hdc, tBars + BarSize - Cntr, 0, Cntr, pxHeight, NewPic.hdc, tBars + BarSize - Cntr, 0, SRCCOPY
                            End If
                        Next
                    End If
                    Cntr = Cntr + Steps
                    'Refresh Picture
                    DestPic.Refresh
                    'Refresh Timer
                    mlngTimer = GetTickCount()  'Reset the timer variable
                End If
            DoEvents
            Loop
        mblnRunning = False
    End If
    Ended = True
End Sub

Public Sub Stretching_Wipe_In(DestPic As PictureBox, PrevPic As PictureBox, NewPic As PictureBox, Optional Side As Side_HV = HorizontalSide, Optional Step_all As Long = 1, Optional RefreshRate As Long = 0, Optional PushMode As PushModeEnum)
    If IsReady Then
        Ended = False
        Dim pxWidth As Long, pxHeight As Long
        Dim ScreenTX As Long, ScreenTY As Long
        Dim XLeng As Long
        Dim r1 As Long, i As Long, j As Long, t As Long
        Dim RRate As Long, Cntr As Long
        
        ScreenTX = Screen.TwipsPerPixelX
        ScreenTY = Screen.TwipsPerPixelY
        pxWidth = DestPic.Width \ ScreenTX
        pxHeight = DestPic.Height \ ScreenTY
        
        If Side = HorizontalSide Then
            XLeng = pxWidth \ 2
        Else
            XLeng = pxHeight \ 2
        End If
        SetStretchBltMode DestPic.hdc, 4
        mblnRunning = True
            'Loop starts here
            Do While mblnRunning
                If mlngTimer + lngSpeed <= GetTickCount() Then
                    'BitBlting
                    For RRate = 0 To RefreshRate
                        If Cntr >= XLeng Then
                            'we want to stop
                            mblnRunning = False
                            'Set new picture, you can use bitblt too.
                            Set DestPic.Picture = NewPic.Picture
                            Exit Sub
                        End If
                        If Side = HorizontalSide Then
                            StretchBlt DestPic.hdc, 0, 0, Cntr, pxHeight, NewPic.hdc, 0, 0, XLeng, pxHeight, SRCCOPY
                            StretchBlt DestPic.hdc, pxWidth - Cntr, 0, Cntr, pxHeight, NewPic.hdc, XLeng, 0, XLeng, pxHeight, SRCCOPY
                            If PushMode = Pushing Then
                                StretchBlt DestPic.hdc, Cntr, 0, pxWidth - Cntr - Cntr, pxHeight, PrevPic.hdc, 0, 0, pxWidth, pxHeight, SRCCOPY
                            End If
                        Else
                            StretchBlt DestPic.hdc, 0, 0, pxWidth, Cntr, NewPic.hdc, 0, 0, pxWidth, XLeng, SRCCOPY
                            StretchBlt DestPic.hdc, 0, pxHeight - Cntr - 1, pxWidth, Cntr, NewPic.hdc, 0, XLeng, pxWidth, XLeng, SRCCOPY
                            If PushMode = Pushing Then
                                StretchBlt DestPic.hdc, 0, Cntr, pxWidth, pxWidth - Cntr - Cntr, PrevPic.hdc, 0, 0, pxWidth, pxHeight, SRCCOPY
                            End If
                        End If
                        Cntr = Cntr + Step_all
                    Next
                    'Refresh Picture
                    DestPic.Refresh
                    'Refresh Timer
                    mlngTimer = GetTickCount()  'Reset the timer variable
                End If
            DoEvents
            Loop
        mblnRunning = False
    End If
    Ended = True
End Sub

Public Sub MaskEffect(DestPic As PictureBox, NewPic As PictureBox, MaskIndex As Integer, FormHdc As Long, Optional Steps As Long = 10)
    If IsReady Then
        Ended = False
        Dim pxWidth As Long, pxHeight As Long
        Dim ScreenTX As Long, ScreenTY As Long
        Dim XLeng As Long
        Dim r1 As Double, i As Long, j As Long, t As Long
        Dim Cntr As Long
        
        ScreenTX = Screen.TwipsPerPixelX
        ScreenTY = Screen.TwipsPerPixelY
        pxWidth = DestPic.ScaleWidth \ ScreenTX
        pxHeight = DestPic.ScaleHeight \ ScreenTY
        
        Dim T1_hdc As Long, T2_hdc As Long
        Dim T1_bmp As Long, T2_bmp As Long
        Dim RetPnt As POINTAPI
        
        T1_hdc = CreateCompatibleDC(DestPic.hdc)
        T1_bmp = CreateCompatibleBitmap(DestPic.hdc, pxWidth + 2, pxHeight + 2)
        SelectObject T1_hdc, T1_bmp
        'Clear Pic
        For i = -1 To pxWidth
        MoveToEx T1_hdc, i, -1, RetPnt
        LineTo T1_hdc, i, pxHeight
        Next
        
        T2_hdc = CreateCompatibleDC(DestPic.hdc)
        T2_bmp = CreateCompatibleBitmap(DestPic.hdc, pxWidth + 2, pxHeight + 2)
        SelectObject T2_hdc, T2_bmp
        
        SelectObject T1_hdc, GetStockObject(6) 'White pen
        Dim MaxDPR As Long
        Select Case MaskIndex
        Case 1
            XLeng = (2 * pxWidth) + (2 * pxHeight)
        Case 2
            XLeng = CLng(Sqr((pxWidth / 2) ^ 2 + (pxHeight / 2) ^ 2))
        Case 3
            XLeng = pxWidth + pxHeight
        Case 4
            XLeng = pxWidth
        Case 5
            XLeng = pxWidth
        End Select
        Dim Now_side As Integer, Cntr2 As Long, DPR As Long
        mblnRunning = True
            'Loop starts here
            Do While mblnRunning
                If mlngTimer + lngSpeed <= GetTickCount() Then
                    'BitBlting
                    If Cntr >= XLeng Or Now_side = -1 Then
                        'We must Delete temporary hDC
                        DeleteDC T1_hdc
                        DeleteDC T2_hdc
                        DeleteObject T1_bmp
                        DeleteObject T2_bmp
                        'we want to stop
                        mblnRunning = False
                        'Set new picture, you can use bitblt too.
                        Set DestPic.Picture = NewPic.Picture
                        Exit Sub
                    End If
                    Select Case MaskIndex
                        Case 1
                        For DPR = 1 To Steps
                            'Radial Wipe
                            MoveToEx T1_hdc, pxWidth / 2, pxHeight / 2, RetPnt
                            Select Case Now_side
                            Case 0
                                LineTo T1_hdc, Cntr2, -1
                                If Cntr2 > pxWidth Then Cntr2 = 0: Now_side = 1
                            Case 1
                                LineTo T1_hdc, pxWidth, Cntr2
                                If Cntr2 > pxHeight Then Cntr2 = 0: Now_side = 2
                            Case 2
                                LineTo T1_hdc, pxWidth - Cntr2, pxHeight
                                If Cntr2 > pxWidth Then Cntr2 = 0: Now_side = 3
                            Case 3
                                LineTo T1_hdc, -1, pxHeight - Cntr2
                                If Cntr2 > pxHeight Then Cntr2 = 0: Now_side = -1
                            End Select
                            Cntr2 = Cntr2 + 1
                        Next
                            '*****************************************
                        Case 2
                            ' Circle Wipe
                            Cntr = Cntr - 1
                            For DPR = 1 To Steps
                            Ellipse T1_hdc, pxWidth / 2 - Cntr, pxHeight / 2 - Cntr, pxWidth / 2 + Cntr, pxHeight / 2 + Cntr
                            Cntr = Cntr + 1
                            Next
                        Case 3
                            'Side Radial Wipe
                            For DPR = 1 To Steps
                                MoveToEx T1_hdc, 0, 0, RetPnt
                                If Now_side = 0 Then
                                    If Cntr2 > pxWidth Then Cntr2 = 0: Now_side = 1
                                    LineTo T1_hdc, Cntr2, pxHeight
                                ElseIf Now_side = 1 Then
                                    If Cntr2 > pxHeight Then Cntr2 = 0: Now_side = -1
                                    LineTo T1_hdc, pxWidth, pxHeight - Cntr2
                                End If
                                Cntr2 = Cntr2 + 1
                            Next
                        Case 4
                            ' Triangles Wipe
                            For DPR = 1 To Steps
                                If Now_side = 0 Then
                                    Cntr2 = Cntr2 + 1
                                    If Cntr2 = pxWidth Then Now_side = -1
                                    t = ((Cntr2 / pxWidth) * pxHeight) + 1
                                    MoveToEx T1_hdc, Cntr2, 0, RetPnt
                                    LineTo T1_hdc, Cntr2, t
                                    MoveToEx T1_hdc, pxWidth - Cntr2, pxHeight, RetPnt
                                    LineTo T1_hdc, pxWidth - Cntr2, pxHeight - t
                                End If
                            Next
                        Case 5
                            For DPR = 1 To Steps
                                If Now_side = 0 Then
                                    If Cntr2 = XLeng Then Now_side = -1
                                    t = (Cntr2 / pxWidth) * pxHeight
                                    MoveToEx T1_hdc, pxWidth - Cntr2, -1, RetPnt
                                    LineTo T1_hdc, -1, pxHeight - t
                                    
                                    MoveToEx T1_hdc, pxWidth, t, RetPnt
                                    LineTo T1_hdc, Cntr2, pxHeight
                                    Cntr2 = Cntr2 + 1
                                End If
                            Next
                    End Select
                    BitBlt T2_hdc, 0, 0, pxWidth, pxHeight, T1_hdc, 0, 0, NOTSRCCOPY
                    BitBlt DestPic.hdc, 0, 0, pxWidth, pxHeight, T2_hdc, 0, 0, SRCAND
                    BitBlt T1_hdc, 0, 0, pxWidth, pxHeight, NewPic.hdc, 0, 0, SRCAND
                    BitBlt DestPic.hdc, 0, 0, pxWidth, pxHeight, T1_hdc, 0, 0, SRCPAINT
                    'BitBlt DestPic.hdc, 0, 0, pxWidth, pxHeight, T1_hdc, 0, 0, SRCCOPY
                    
                    Cntr = Cntr + 1
                    'Refresh Picture
                    DestPic.Refresh
                    'Refresh Timer
                    mlngTimer = GetTickCount()  'Reset the timer variable
                End If
            DoEvents
            Loop
        mblnRunning = False
    End If 'If IsReady
    Ended = True
End Sub
