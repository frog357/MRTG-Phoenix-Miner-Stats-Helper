Attribute VB_Name = "cmdReadWrite"
Option Explicit

Private Const STD_INPUT_HANDLE As Long = -10
Private Const STD_OUTPUT_HANDLE As Long = -11

Private Declare Function GetStdInHandle Lib "kernel32" _
        Alias "GetStdHandle" _
       (Optional ByVal HandleType As Long = STD_INPUT_HANDLE) As Long

Private Declare Function GetStdOutHandle Lib "kernel32" _
        Alias "GetStdHandle" _
       (Optional ByVal HandleType As Long = STD_OUTPUT_HANDLE) As Long

Private Declare Function WriteFile Lib "kernel32" _
       (ByVal hFile As Long, _
        ByVal lpBuffer As String, _
        ByVal cToWrite As Long, _
        ByRef cWritten As Long, _
        Optional ByVal lpOverlapped As Long) As Long

Private Declare Function ReadFile Lib "kernel32" _
       (ByVal hFile As Long, _
        ByVal lpBuffer As String, _
        ByVal cToRead As Long, _
        ByRef cRead As Long, _
        Optional ByVal lpOverlapped As Long) As Long

Public Function WriteLine(sText As String) As Long
    WriteFile GetStdOutHandle, ByVal sText, Len(sText), WriteLine
End Function

Public Function ReadLine() As String
    Dim lRead As Long
    ReadLine = String$(1024, vbNullChar)
    If ReadFile(GetStdInHandle, ReadLine, 1024&, lRead) Then
        ReadLine = Left$(ReadLine, lRead - 2)
    Else
        ReadLine = vbNullString
    End If
End Function

