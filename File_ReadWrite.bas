Attribute VB_Name = "ReadWrite_File"
Option Explicit

Public Function FileText(ByVal filename As String) As String
    Dim handle As Integer
     
    ' ensure that the file exists
    If Len(Dir$(filename)) = 0 Then
        Exit Function
    End If
     
    ' open in binary mode
    handle = FreeFile
    Open filename$ For Binary As #handle
    ' read the string and close the file
    FileText = Space$(LOF(handle))
    Get #handle, , FileText
    Close #handle
End Function

Public Function SaveFile(txtFile As String, ByVal MyText As String)
    Dim FileNum As Integer

    FileNum = FreeFile()

    Open txtFile For Output As FileNum
    Print #FileNum, MyText;
    Close FileNum
End Function

Public Function AppendFile(txtFile As String, ByVal MyText As String)
On Error GoTo DamnErr
    Dim FileNum As Integer
    FileNum = FreeFile()
    Open txtFile For Append As FileNum
    Print #FileNum, MyText;
    Close FileNum
    Exit Function
DamnErr:
    Err.Clear
    Resume Next
End Function
 