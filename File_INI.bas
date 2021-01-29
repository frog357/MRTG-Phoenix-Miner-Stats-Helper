Attribute VB_Name = "ReadWrite_INI"
Option Explicit

Private Declare Function GetPrivateProfileString Lib "kernel32" Alias _
                        "GetPrivateProfileStringA" _
                        ( _
                        ByVal lpApplicationName As String, _
                        ByVal lpKeyName As Any, _
                        ByVal lpDefault As String, _
                        ByVal lpReturnedString As String, _
                        ByVal nSize As Long, _
                        ByVal lpFileName As String _
                        ) _
                        As Long

Private Declare Function WritePrivateProfileString Lib "kernel32" Alias _
                        "WritePrivateProfileStringA" _
                        ( _
                        ByVal lpApplicationName As String, _
                        ByVal lpKeyName As Any, _
                        ByVal lpString As Any, _
                        ByVal lpFileName As String _
                        ) _
                        As Long

Private Declare Function WritePrivateProfileSection Lib "kernel32" Alias _
                        "WritePrivateProfileSectionA" _
                        ( _
                        ByVal lpAppName As String, _
                        ByVal lpString As String, _
                        ByVal lpFileName As String _
                        ) _
                        As Long

Public Function ReadINIFile(strINIFile As String, strSection As String, strKey As String) As String
    Dim strValue As String, sln As Long, sFile As String
    strValue = Space(255)
    sFile = strINIFile
    sln = GetPrivateProfileString(strSection, strKey, "0", strValue, Len(strValue), sFile)
    strValue = Left(strValue, sln)
    ReadINIFile = strValue
End Function

Public Function WriteINIFile(strINIFile As String, strSection As String, strKey As String, ByVal strValue As String) As Long
    Dim sln As Long, sFile As String
    sFile = strINIFile
    sln = WritePrivateProfileString(strSection, strKey, strValue, sFile)
    WriteINIFile = sln
End Function

Public Function DeleteSection(strINIFile As String, strSection As String) As Long
    Dim sln As Long, sFile As String
    sFile = strINIFile
    sln = WritePrivateProfileSection(strSection, vbNullString, sFile)
    DeleteSection = sln
End Function
