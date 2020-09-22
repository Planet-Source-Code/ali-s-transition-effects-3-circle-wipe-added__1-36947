VERSION 5.00
Begin VB.Form Form1 
   Caption         =   "Transition Effects"
   ClientHeight    =   8940
   ClientLeft      =   1635
   ClientTop       =   3375
   ClientWidth     =   12315
   Icon            =   "frmTransEffects.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   8940
   ScaleWidth      =   12315
   StartUpPosition =   2  'CenterScreen
   Begin VB.Frame Frame6 
      Caption         =   "Other"
      Height          =   975
      Left            =   120
      TabIndex        =   22
      Top             =   7920
      Width           =   2295
      Begin VB.TextBox Text3 
         Alignment       =   2  'Center
         Height          =   285
         Left            =   1080
         TabIndex        =   24
         Text            =   "10"
         Top             =   240
         Width           =   975
      End
      Begin VB.Label Label2 
         Caption         =   "Bar Size"
         Height          =   255
         Left            =   120
         TabIndex        =   23
         Top             =   240
         Width           =   855
      End
   End
   Begin VB.Frame Frame5 
      Caption         =   "Steps/Draw per Refresh"
      Height          =   855
      Left            =   120
      TabIndex        =   20
      Top             =   3840
      Width           =   2295
      Begin VB.TextBox Text2 
         Alignment       =   2  'Center
         Height          =   285
         Left            =   360
         TabIndex        =   21
         Text            =   "1"
         Top             =   360
         Width           =   1455
      End
   End
   Begin VB.CommandButton cmdStart 
      Caption         =   "Start"
      Height          =   495
      Left            =   2520
      TabIndex        =   18
      Top             =   240
      Width           =   975
   End
   Begin VB.Frame Frame4 
      Caption         =   "Push Mode"
      Height          =   1095
      Left            =   120
      TabIndex        =   14
      Top             =   6720
      Width           =   2295
      Begin VB.OptionButton Option2 
         Caption         =   "Move"
         Height          =   255
         Index           =   2
         Left            =   120
         TabIndex        =   17
         Top             =   720
         Width           =   1815
      End
      Begin VB.OptionButton Option2 
         Caption         =   "Hide"
         Height          =   255
         Index           =   1
         Left            =   120
         TabIndex        =   16
         Top             =   480
         Width           =   1815
      End
      Begin VB.OptionButton Option2 
         Caption         =   "Push"
         Height          =   255
         Index           =   0
         Left            =   120
         TabIndex        =   15
         Top             =   240
         Width           =   1815
      End
   End
   Begin VB.Frame Frame3 
      Caption         =   "Select Speed"
      Height          =   975
      Left            =   120
      TabIndex        =   11
      Top             =   2760
      Width           =   2295
      Begin VB.TextBox Text1 
         Alignment       =   2  'Center
         Height          =   285
         Left            =   600
         TabIndex        =   13
         Text            =   "1"
         Top             =   600
         Width           =   975
      End
      Begin VB.Label Label1 
         Caption         =   "Tick count (fastest=1) :"
         Height          =   255
         Left            =   120
         TabIndex        =   12
         Top             =   360
         Width           =   1815
      End
   End
   Begin VB.Frame Frame2 
      Caption         =   "Select Side"
      Height          =   1815
      Left            =   120
      TabIndex        =   4
      Top             =   4800
      Width           =   2295
      Begin VB.OptionButton Option1 
         Caption         =   "Down"
         Height          =   255
         Index           =   5
         Left            =   120
         TabIndex        =   10
         Top             =   1440
         Width           =   1815
      End
      Begin VB.OptionButton Option1 
         Caption         =   "Up"
         Height          =   255
         Index           =   4
         Left            =   120
         TabIndex        =   9
         Top             =   1200
         Width           =   1815
      End
      Begin VB.OptionButton Option1 
         Caption         =   "Right"
         Height          =   255
         Index           =   3
         Left            =   120
         TabIndex        =   8
         Top             =   960
         Width           =   1815
      End
      Begin VB.OptionButton Option1 
         Caption         =   "Left"
         Height          =   255
         Index           =   2
         Left            =   120
         TabIndex        =   7
         Top             =   720
         Width           =   1815
      End
      Begin VB.OptionButton Option1 
         Caption         =   "Horizontal"
         Height          =   255
         Index           =   1
         Left            =   120
         TabIndex        =   6
         Top             =   480
         Width           =   1815
      End
      Begin VB.OptionButton Option1 
         Caption         =   "Vertical"
         Height          =   255
         Index           =   0
         Left            =   120
         TabIndex        =   5
         Top             =   240
         Width           =   1815
      End
   End
   Begin VB.Frame Frame1 
      Caption         =   "Select effect"
      Height          =   2535
      Left            =   120
      TabIndex        =   3
      Top             =   120
      Width           =   2295
      Begin VB.ListBox List1 
         Height          =   2010
         Left            =   120
         TabIndex        =   19
         Top             =   360
         Width           =   2055
      End
   End
   Begin VB.PictureBox Picture3 
      AutoRedraw      =   -1  'True
      AutoSize        =   -1  'True
      Height          =   240
      Left            =   3600
      ScaleHeight     =   180
      ScaleWidth      =   345
      TabIndex        =   2
      Top             =   480
      Visible         =   0   'False
      Width           =   405
   End
   Begin VB.PictureBox Picture1 
      AutoRedraw      =   -1  'True
      AutoSize        =   -1  'True
      Height          =   7260
      Left            =   2520
      Picture         =   "frmTransEffects.frx":0442
      ScaleHeight     =   7200
      ScaleWidth      =   9600
      TabIndex        =   0
      Top             =   1200
      Width           =   9660
   End
   Begin VB.PictureBox Picture2 
      AutoRedraw      =   -1  'True
      AutoSize        =   -1  'True
      Height          =   7260
      Left            =   2520
      Picture         =   "frmTransEffects.frx":177D
      ScaleHeight     =   7200
      ScaleWidth      =   9600
      TabIndex        =   1
      Top             =   960
      Visible         =   0   'False
      Width           =   9660
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'   Transition Effects By Mohammed Ali Sohrabi ,ali6236@yahoo.com
'   Cool Transition for your programs!
'   See Notes on the module
Public StopProgram As Boolean
Private Enum SideSelecting
    Off = 0
    HV = 1
    LRDU = 2
    All = 3
End Enum

Private Sub cmdStart_Click()
    Static StartMode As Boolean
    If Not StartMode Then
        If Not IsReady Then Exit Sub
        cmdStart.Caption = "Stop"
        StartMode = True
        RunEffect
        StartMode = False
        If StopProgram Then Exit Sub
        Set Picture2.Picture = Picture3.Picture
        Set Picture3.Picture = Picture1.Picture
        cmdStart.Caption = "Start"
    Else
        mblnRunning = False
        cmdStart.Caption = "Start"
        StartMode = False
        Set Picture1.Picture = Picture2.Picture
    End If
End Sub

Private Sub Command1_Click(Index As Integer)
'Random Lines
'**********************************
'   Need New Picture : Yes
'   Need Old Picture : No
'   Sides            : Vertical - Horizontal
'**********************************
'   Push Modes       : Disable
'   Refresh Rate     : Enable
'   Step             : Disable
'**********************************
'   Notes:
'   RefreshRate : number of lines in each refresh
If Not IsReady Then Exit Sub
    lngSpeed = 1
    If Index = 0 Then
        RandomLines Picture1, Picture2, VerticalSide, 0
    Else
        'the speed is 1, but it is slow, we use RefreshRate for faster result...
        RandomLines Picture1, Picture2, HorizontalSide, 2
    End If
    If StopProgram Then Exit Sub
    Set Picture2.Picture = Picture3.Picture
    Set Picture3.Picture = Picture1.Picture
End Sub

Private Sub Command10_Click(Index As Integer)
'**** when i run this section my computer restarts!
'**** please enable and run, and say me about your computer....

'Stretching
'**********************************
'   Need New Picture : Yes
'   Need Old Picture : Yes
'   Sides            : Vertical - Horizontal
'**********************************
'   Push Modes       : Enable (Push,Hide)
'   Refresh Rate     : Enable
'   Step             : Enable
'**********************************
'   Notes:
'   Stretch is a slow effect,
'   Just use for small pictures, with large steps
'   and use push mode just when you need,
If Not IsReady Then Exit Sub
    lngSpeed = 1
    If Index = 0 Then
        Stretching_Wipe_In Picture1, Picture3, Picture2, HorizontalSide, 5, 0, Pushing
    Else
        Stretching_Wipe_In Picture1, Picture3, Picture2, VerticalSide, 5, 0, Hiding
    End If
    If StopProgram Then Exit Sub
    Set Picture2.Picture = Picture3.Picture
    Set Picture3.Picture = Picture1.Picture
End Sub

Private Sub Command2_Click(Index As Integer)
'Slide
'**********************************
'   Need New Picture : Yes
'   Need Old Picture : Yes
'   Sides            : All Sides (Up and Down are completed)
'**********************************
'   Push Modes       : Disable
'   Refresh Rate     : Disable
'   Step             : Enable
'**********************************
'   Notes: Just use Up and Down,
'          I will complete other sides as soon as possible!
If Not IsReady Then Exit Sub
    lngSpeed = 1
    If Index = 0 Then
        Slide Picture1, Picture3, Picture2, aUp, 3
    Else
        Slide Picture1, Picture3, Picture2, aDown, 3
    End If
    If StopProgram Then Exit Sub
    Set Picture2.Picture = Picture3.Picture
    Set Picture3.Picture = Picture1.Picture
End Sub

Private Sub Command3_Click(Index As Integer)
'Stretching
'**********************************
'   Need New Picture : Yes
'   Need Old Picture : Yes
'   Sides            : Left - Right
'**********************************
'   Push Modes       : Enable (Push,Move)
'   Refresh Rate     : Enable
'   Step             : Enable
'**********************************
'   Notes:
'   Stretch is a slow effect,
'   Just use for small pictures, with large steps
'   and use push mode just when you need,
If Not IsReady Then Exit Sub
    lngSpeed = 1
    If Index = 0 Then
        Stretching Picture1, Picture3, Picture2, sRight, 5, 0, Pushing
    Else
        Stretching Picture1, Picture3, Picture2, sLeft, 5, 0, Moving
    End If
    If StopProgram Then Exit Sub
    Set Picture2.Picture = Picture3.Picture
    Set Picture3.Picture = Picture1.Picture
End Sub

Private Sub Command4_Click(Index As Integer)
'Wipe
'**********************************
'   Need New Picture : Yes
'   Need Old Picture : No
'   Sides            : All (Left,Right,Up,Down)
'**********************************
'   Push Modes       : Disable
'   Refresh Rate     : Disable
'   Step             : Enable
'**********************************
If Not IsReady Then Exit Sub
    lngSpeed = 1
    Wipe Picture1, Picture2, 2 ^ Index, 3 '!!!! i'm using ^ !!! it's better to use select case
    If StopProgram Then Exit Sub
    Set Picture2.Picture = Picture3.Picture
    Set Picture3.Picture = Picture1.Picture
End Sub

Private Sub Command5_Click(Index As Integer)
'Wipe In
'**********************************
'   Need New Picture : Yes
'   Need Old Picture : No
'   Sides            : Vertical and Horizontal
'**********************************
'   Push Modes       : Disable
'   Refresh Rate     : Disable
'   Step             : Enable
'**********************************
'   Notes:
'   This is like two normal wipe.

If Not IsReady Then Exit Sub
    lngSpeed = 1
    Wipe_In Picture1, Picture2, Index + 1, 3
    If StopProgram Then Exit Sub
    Set Picture2.Picture = Picture3.Picture
    Set Picture3.Picture = Picture1.Picture
End Sub

Private Sub Command6_Click(Index As Integer)
'Wipe Out
'**********************************
'   Need New Picture : Yes
'   Need Old Picture : No
'   Sides            : Vertical and Horizontal
'**********************************
'   Push Modes       : Disable
'   Refresh Rate     : Disable
'   Step             : Enable
'**********************************
'   Notes:
'   like wipe in....

If Not IsReady Then Exit Sub
    lngSpeed = 1
    Wipe_Out Picture1, Picture2, Index + 1, 3
    If StopProgram Then Exit Sub
    Set Picture2.Picture = Picture3.Picture
    Set Picture3.Picture = Picture1.Picture
End Sub

Private Sub Command7_Click(Index As Integer)
'Bar Draw
'**********************************
'   Need New Picture : Yes
'   Need Old Picture : No
'   Sides            : Vertical and Horizontal
'**********************************
'   Push Modes       : Disable
'   Refresh Rate     : Disable
'   Step             : Enable
'**********************************
'   Notes:

If Not IsReady Then Exit Sub
    lngSpeed = 1
    Static way As Boolean
    Bars_Draw Picture1, Picture2, Index + 1, 5, 15
    If StopProgram Then Exit Sub
    Set Picture2.Picture = Picture3.Picture
    Set Picture3.Picture = Picture1.Picture
End Sub

Private Sub Command8_Click(Index As Integer)
'Bar Move
'**********************************
'   Need New Picture : Yes
'   Need Old Picture : No
'   Sides            : Vertical and Horizontal
'**********************************
'   Push Modes       : Disable
'   Refresh Rate     : Disable
'   Step             : Enable
'**********************************
'   Notes:
'   like wipe in....

If Not IsReady Then Exit Sub
    lngSpeed = 1
    Static way As Boolean
    Bars_Move Picture1, Picture2, Index + 1, 4, 10
    If StopProgram Then Exit Sub
    Set Picture2.Picture = Picture3.Picture
    Set Picture3.Picture = Picture1.Picture
End Sub

Private Sub Command9_Click(Index As Integer)
'Wipe
'**********************************
'   Need New Picture : Yes
'   Need Old Picture : No
'   Sides            : All (Left,Right,Up,Down)
'**********************************
'   Push Modes       : Disable
'   Refresh Rate     : Disable
'   Step             : Enable
'**********************************
If Not IsReady Then Exit Sub
    lngSpeed = 1
    'Bars_OneSide Picture1, Picture2, 2 ^ Index, 1, 20
    MaskEffect Picture1, Picture2, 1, Me.hdc
    If StopProgram Then Exit Sub
    Set Picture2.Picture = Picture3.Picture
    Set Picture3.Picture = Picture1.Picture
End Sub

Private Sub Form_Load()
    With List1
        .AddItem "Wipe (Normal)"
        .AddItem "Wipe In"
        .AddItem "Wipe Out"
        .AddItem "Stretch Wipe"
        .AddItem "Stretch Wipe In"
        .AddItem "Random Lines"
        .AddItem "Bars Draw"
        .AddItem "Bars Move"
        .AddItem "Slide"
        .AddItem "Bar Wipe"
        .AddItem "Radial Wipe (mask)"
        .AddItem "Circle Wipe (mask)"
        .AddItem "Side Radial Wipe (mask)"
        .AddItem "Triangle Wipe (mask)"
        .AddItem "Middle Wipe (mask)"
    End With
    StopProgram = False
    Set Picture3.Picture = Picture1.Picture
    lngSpeed = 1
    List1.ListIndex = 0
End Sub

Private Sub Form_QueryUnload(Cancel As Integer, UnloadMode As Integer)
    mblnRunning = False
    StopProgram = True
    Unload Me
End Sub

Private Sub List1_Click()
    OtherEnable False
    Text1.Text = 1
    Select Case List1.ListIndex
    Case 0
        'Wipe (Normal)
        StepEnable True
        PushEnable False
        SideEnable LRDU
        Text2.Text = 5
    Case 1
        'Wipe In
        StepEnable True
        PushEnable False
        SideEnable HV
        Text2.Text = 4
    Case 2
        'Wipe Out
        StepEnable True
        PushEnable False
        SideEnable HV
        Text2.Text = 4
    Case 3
        'Stretch
        StepEnable True
        PushEnable True
        SideEnable LRDU
        Text2.Text = 5
        Option1(4).Enabled = False
        Option1(5).Enabled = False
        Option2(0).Value = True
    Case 4
        MsgBox "Select another, this effect may have some errors...", vbCritical
        List1.ListIndex = 0
        Exit Sub
        'Stretch Wipe IN
        StepEnable True
        PushEnable True
        Option2(2).Enabled = False
        SideEnable HV
        Text2.Text = 5
        Option2(0).Value = True
    Case 5
        'Random lines
        StepEnable True
        PushEnable False
        SideEnable HV
        Text2.Text = 2
    Case 6
        'Bars Draw
        StepEnable True
        PushEnable False
        SideEnable HV
        OtherEnable True
        Text2.Text = 5
        Text3.Text = 1
        Option1(1).Value = True
    Case 7
        'Bars Move
        StepEnable True
        PushEnable False
        SideEnable HV
        OtherEnable True
        Text2.Text = 5
        Text3.Text = 1
        Option1(1).Value = True
    Case 8
        'Slide
        StepEnable True
        PushEnable False
        SideEnable LRDU
        Text2.Text = 8
        Option1(2).Enabled = False
        Option1(3).Enabled = False
        Option1(4).Value = True
    Case 9
        'Bars Wipe
        StepEnable True
        PushEnable False
        SideEnable LRDU
        OtherEnable True
        Text2.Text = 1
        Text3.Text = 20
        Text1.Text = 50
        Option1(4).Value = True
    Case 10 To 14
    'Mask Effects
        ' 1 - Radial Wipe
        ' 2 - Circle Wipe
        ' 3 - Side Radial Wipe
        StepEnable True
        PushEnable False
        SideEnable Off
        
        Select Case List1.ListIndex
        Case 10
            Text2.Text = 30
        Case 11
            Text2.Text = 5
        Case 12
            Text2.Text = 25
        Case 13
            Text2.Text = 10
        Case 14
            Text2.Text = 10
        End Select
    Case Else
    End Select
End Sub

Private Sub Text1_Change()
    If LenB(Text1.Text) = 0 Or Text1.Text = "0" Then Text1.Text = "1"
    lngSpeed = CLng(Text1.Text)
End Sub

Private Sub Text1_KeyPress(KeyAscii As Integer)
    If (KeyAscii < 48 Or KeyAscii > 57) And (KeyAscii <> 8) Then KeyAscii = 0
End Sub

Private Sub Text2_Change()
    If LenB(Text2.Text) = 0 Or Text2.Text = "0" Then
        Text2.Text = "1"
        Text2.SelLength = 1
    End If
End Sub
Private Sub StepEnable(Enable As Boolean)
    Frame5.Enabled = Enable
    Text2.Enabled = Enable
End Sub
Private Sub OtherEnable(Enable As Boolean)
    Frame6.Enabled = Enable
    Label2.Enabled = Enable
    Text3.Enabled = Enable
End Sub
Private Sub PushEnable(Enable As Boolean)
    Frame4.Enabled = Enable
    Option2(0).Enabled = Enable
    Option2(1).Enabled = Enable
    Option2(2).Enabled = Enable
End Sub

Private Sub SideEnable(Mode As SideSelecting)
    Dim i As Integer
    If Mode = 0 Then
        Frame2.Enabled = False
        For i = 0 To 5
            Option1(i).Enabled = False
        Next
    Else
        Frame2.Enabled = True
        If Mode And HV Then
            Option1(0).Enabled = True
            Option1(1).Enabled = True
            Option1(0).Value = True
        
            Option1(2).Enabled = False
            Option1(3).Enabled = False
            Option1(4).Enabled = False
            Option1(5).Enabled = False
        End If
        If Mode And LRDU Then
            Option1(0).Enabled = False
            Option1(1).Enabled = False

            Option1(2).Enabled = True
            Option1(3).Enabled = True
            Option1(4).Enabled = True
            Option1(5).Enabled = True
            Option1(2).Value = True
        End If
    End If
End Sub
Private Function GetSideLRDU() As Long
    If Option1(2).Value Then
        GetSideLRDU = 4
    ElseIf Option1(3).Value Then
        GetSideLRDU = 8
    ElseIf Option1(4).Value Then
        GetSideLRDU = 1
    ElseIf Option1(5).Value Then
        GetSideLRDU = 2
    End If
End Function
Private Function GetSideHV() As Long
    If Option1(0).Value Then
        GetSideHV = 1
    Else
        GetSideHV = 2
    End If
End Function
Private Function GetPushMode() As Long
    If Option2(0).Value Then
        GetPushMode = 1
    ElseIf Option2(1).Value Then
        GetPushMode = 2
    Else
        GetPushMode = 3
    End If
End Function
Private Sub RunEffect()
    Select Case List1.ListIndex
        Case 0
            'Normal Wipe
            Wipe Picture1, Picture2, GetSideLRDU, CLng(Text2.Text)
        Case 1
            'Wipe IN
            Wipe_In Picture1, Picture2, GetSideHV, CLng(Text2.Text)
        Case 2
            'Wipe Out
            Wipe_Out Picture1, Picture2, GetSideHV, CLng(Text2.Text)
        Case 3
            'Stretch
            Dim i As Long '*
            If Option1(2).Value Then i = 1 Else i = 2 '*
            Stretching Picture1, Picture3, Picture2, i, CLng(Text2.Text), , GetPushMode
        Case 4
            'Stretch Wipe In
            'Stretching_Wipe_In Picture1, Picture3, Picture2, GetSideHV, CLng(Text2.Text), , GetPushMode
        Case 5
            'Random Lines
            RandomLines Picture1, Picture2, GetSideHV, CLng(Text2.Text)
        Case 6
            'Bars Draw
            Bars_Draw Picture1, Picture2, GetSideHV, CLng(Text2.Text), CLng(Text3.Text)
        Case 7
            'Bars move
            Bars_Move Picture1, Picture2, GetSideHV, CLng(Text2.Text), CLng(Text3.Text)
        Case 8
            'Slide
            Slide Picture1, Picture3, Picture2, GetSideLRDU, CLng(Text2.Text)
        Case 9
            'Bars Wipe
            Bars_Wipe Picture1, Picture2, GetSideLRDU, CLng(Text2.Text), CLng(Text3.Text)
        Case 10
            'Radial Wipe (Mask)
            MaskEffect Picture1, Picture2, 1, Me.hdc, CLng(Text2.Text)
        Case 11
            'Circle Wipe (Mask)
            MaskEffect Picture1, Picture2, 2, Me.hdc, CLng(Text2.Text)
        Case 12
            'Side Radial Wipe (Mask)
            MaskEffect Picture1, Picture2, 3, Me.hdc, CLng(Text2.Text)
        Case 13
            'Triangle Wipe (mask)
            MaskEffect Picture1, Picture2, 4, Me.hdc, CLng(Text2.Text)
        Case 14
            'Middle Wipe (mask)
            MaskEffect Picture1, Picture2, 5, Me.hdc, CLng(Text2.Text)
    End Select
End Sub

Private Sub Text3_Change()
    If LenB(Text3.Text) = 0 Or Text3.Text = "0" Then
        Text3.Text = "1"
        Text3.SelLength = 1
    End If
End Sub
