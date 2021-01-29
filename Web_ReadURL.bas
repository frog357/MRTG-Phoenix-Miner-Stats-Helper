Attribute VB_Name = "Web_ReadURL"
Option Explicit

'These constants are used for WININET.DLL
Private Const INTERNET_OPEN_TYPE_PRECONFIG = 0
Private Const INTERNET_OPEN_TYPE_DIRECT = 1
Private Const INTERNET_OPEN_TYPE_PROXY = 3
Private Const scUserAgent = "VB"
Private Const INTERNET_FLAG_RELOAD = &H80000000
Private Declare Function InternetOpen _
    Lib "WININET.DLL" _
    Alias "InternetOpenA" _
    ( _
    ByVal sAgent As String, _
    ByVal lAccessType As Long, _
    ByVal sProxyName As String, _
    ByVal sProxyBypass As String, _
    ByVal lFlags As Long _
    ) _
    As Long
Private Declare Function InternetOpenUrl _
    Lib "WININET.DLL" _
    Alias "InternetOpenUrlA" _
    ( _
    ByVal hOpen As Long, _
    ByVal sUrl As String, _
    ByVal sHeaders As String, _
    ByVal lLength As Long, _
    ByVal lFlags As Long, _
    ByVal lContext As Long _
    ) _
    As Long
Private Declare Function InternetReadFile _
    Lib "WININET.DLL" _
    ( _
    ByVal hFile As Long, _
    ByVal sBuffer As String, _
    ByVal lNumBytesToRead As Long, _
    lNumberOfBytesRead As Long _
    ) _
    As Integer
Private Declare Function InternetCloseHandle _
    Lib "WININET.DLL" _
    ( _
    ByVal hInet As Long _
    ) _
    As Integer
Private Declare Function PathIsURL _
    Lib "shlwapi" _
    Alias "PathIsURLA" _
    ( _
    ByVal pszPath As String _
    ) _
    As Long

'        sCmd = ReadURL(sCmd)    '

Public Function ReadURL(sUrl As String) As String
On Error GoTo ErrOut
'Created by:
'http://www.pgacon.com/visualbasic.htm
'Comments by:
'http://www.freddyt.com
    Dim s As String                     'Return from Webpage.
    Dim hOpen As Long                   'Handle to InternetOpen
    Dim hOpenUrl As Long                'Handle to InternetOpenURL
    Dim bDoLoop As Boolean              'Check if we keep looping.
    Dim bRet As Boolean                 'Return value used by InternetReadFile
    Dim sReadBuffer As String * 2048    'Return from Webpage.
    Dim lNumberOfBytesRead As Long      '# of bytes read from Webpage.
    
    'Open handle to URL.
    hOpen = InternetOpen(scUserAgent, INTERNET_OPEN_TYPE_PRECONFIG, vbNullString, vbNullString, 0)
    hOpenUrl = InternetOpenUrl(hOpen, sUrl, vbNullString, 0, INTERNET_FLAG_RELOAD, 0)
    
    'Request file from URL.
    bDoLoop = True
    While bDoLoop
        sReadBuffer = vbNullString
        bRet = InternetReadFile(hOpenUrl, sReadBuffer, Len(sReadBuffer), lNumberOfBytesRead)
        s = s & Left$(sReadBuffer, lNumberOfBytesRead)
        'Check if we're done.
        If Not CBool(lNumberOfBytesRead) Then bDoLoop = False
    Wend
    
    'Close handle to URL.
    If hOpenUrl <> 0 Then InternetCloseHandle hOpenUrl
    If hOpen <> 0 Then InternetCloseHandle hOpen

    'Return the return ;)
    ReadURL = s
    Exit Function
ErrOut:
    ReadURL = ""
    Err.Clear
End Function
