VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "cFileNameInputter"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

Dim m_sTargetFolderPath As String
Dim m_sFilterWord As String
Dim m_sNotTargetWord As String
Dim m_sTargetExtension As String
Dim m_lTargetExtension As Long

'--------------------------------------------------------------------------------
'@brief : getter letter sTargetFolderPath
'@param : NULL
'@return: NULL
'--------------------------------------------------------------------------------
Public Property Get sTargetFolderPath() As String
    sTargetFolderPath = m_sTargetFolderPath
End Property

Public Property Let sTargetFolderPath(ByVal vsTargetFolderPath As String)
    m_sTargetFolderPath = vsTargetFolderPath
End Property

'--------------------------------------------------------------------------------
'@brief : getter letter sFilterWord
'@param : NULL
'@return: NULL
'--------------------------------------------------------------------------------
Public Property Get sFilterWord() As String
    sFilterWord = m_sFilterWord
End Property

Public Property Let sFilterWord(ByVal vsFilterWord As String)
    m_sFilterWord = vsFilterWord
End Property

'--------------------------------------------------------------------------------
'@brief : getter letter sNotTargetWord
'@param : NULL
'@return: NULL
'--------------------------------------------------------------------------------
Public Property Get sNotTargetWord() As String
    sNotTargetWord = m_sNotTargetWord
End Property

Public Property Let sNotTargetWord(ByVal vsNotTargetWord As String)
    m_sNotTargetWord = vsNotTargetWord
End Property

'--------------------------------------------------------------------------------
'@brief : getter letter lTargetExtension
'@param : NULL
'@return: NULL
'--------------------------------------------------------------------------------
Public Property Get lTargetExtension() As Long
    lTargetExtension = m_lTargetExtension
End Property

Public Property Let lTargetExtension(ByVal vlTargetExtension As Long)
    m_lTargetExtension = vlTargetExtension
End Property

'--------------------------------------------------------------------------------
'@brief : getter letter sTargetExtension
'@param : NULL
'@return: NULL
'--------------------------------------------------------------------------------
Public Property Get sTargetExtension() As String
    sTargetExtension = m_sTargetExtension
End Property

Public Property Let sTargetExtension(ByVal vsTargetExtension As String)
    m_sTargetExtension = vsTargetExtension
End Property

'--------------------------------------------------------------------------------
'@brief : initialize
'@param : NULL
'@return: NULL
'--------------------------------------------------------------------------------
Private Sub Class_initialize()
    m_sTargetFolderPath = ""
    m_sFilterWord = ""
    m_sNotTargetWord = ""
    m_sTargetExtension = ""
End Sub

'--------------------------------------------------------------------------------
'@brief : get extension
'@param : NULL
'@return: NULL
'--------------------------------------------------------------------------------
Private Sub getExtention()
    Select Case lTargetExtension
    Case E_EXTENSION.ALL
        sTargetExtension = "*.*"
    Case E_EXTENSION.XLS
        sTargetExtension = "*.xls"
    Case E_EXTENSION.XLSX
        sTargetExtension = "*.xlsx"
    Case E_EXTENSION.XLSM
        sTargetExtension = "*.xlsm"
    Case E_EXTENSION.TXT
        sTargetExtension = "*.txt"
    Case E_EXTENSION.PDF
        sTargetExtension = "*.pdf"
    End Select
End Sub

'--------------------------------------------------------------------------------
'@brief : check my value
'@param : NULL
'@return: True, False
'--------------------------------------------------------------------------------
Private Function checkMyValue()
    If "" = m_sTargetFolderPath Then
        checkMyValue = False
        Exit Function
    End If
    checkMyValue = True
End Function

'--------------------------------------------------------------------------------
'@brief : input file name
'@param : NULL
'@return: NULL
'--------------------------------------------------------------------------------
Public Sub InputFileName(ByVal siTarget As cSheetInfo)
    Dim sDirBuf As String
    Dim lCurRow As Long

    If Not checkMyValue Then
        Exit Sub
    End If
    Call getExtention

    sDirBuf = Dir(sTargetFolderPath & "\" & sTargetExtension)
    lCurRow = siTarget.lStartRow
    Do While sDirBuf <> ""
        If (sNotTargetWord <> "") And (sDirBuf Like "*" & sNotTargetWord & "*") Then
            GoTo Continue
        End If
        If sDirBuf Like "*" & sFilterWord & "*" Then
            siTarget.ws.Cells(lCurRow, siTarget.lTargetCol).Value = sDirBuf
            lCurRow = lCurRow + 1
        End If
Continue:
        sDirBuf = Dir()
    Loop
End Sub

'--------------------------------------------------------------------------------
'@brief : get file name array
'@param : NULL
'@return: NULL
'--------------------------------------------------------------------------------
Public Function GetFileNameArray() As String()
    Dim sDirBuf As String
    Dim lCurRow As Long
    Dim sFileNameArray() As String
    Dim lCntArray As Long
    
    If Not checkMyValue Then
        Exit Function
    End If
    Call getExtention

    lCntArray = 0
    ReDim Preserve sFileNameArray(lCntArray)
    sFileNameArray(lCntArray) = G_S_NOT_EXIST
    sDirBuf = Dir(sTargetFolderPath & "\" & sTargetExtension)
    Do While sDirBuf <> ""
        If (sNotTargetWord <> "") And (sDirBuf Like "*" & sNotTargetWord & "*") Then
            GoTo Continue
        End If
        If (sDirBuf Like "*" & sFilterWord & "*") Then
            ReDim Preserve sFileNameArray(lCntArray)
            sFileNameArray(lCntArray) = sDirBuf
            lCntArray = lCntArray + 1
        End If
Continue:
        sDirBuf = Dir()
    Loop
    GetFileNameArray = sFileNameArray
End Function
