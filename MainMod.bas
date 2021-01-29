Attribute VB_Name = "MainMod"
Option Explicit

Public Sub Main()
    Dim sCMD As String, i As Long, iTop As Long, iCount As Long, sFile As String, sPrefix As String, sSplitFile() As String, iFindEnd As Long, iFindEnd2 As Long
    Dim output1 As String
    sCMD = Command$()
    'sCMD = "CB127.0.0.1"
    
    'normal cmd looks like:
    'BAminer020 (outputs gpu1 speed in mh/s)
    'AAminer001 (outputs total rig speed in mh/s)
    
    If Not Len(sCMD) > 5 And Not Len(sCMD) < 20 Then End 'Exit if incorrect command line detected.
    If Not InStr(1, sCMD, ":", vbBinaryCompare) > 0 Then sCMD = sCMD & ":3333"
    
    'Letter prefix tells which data point and source ie: GPU to poll or request data from.
    'A=RIG (combined total when available) (n/a for temp or fan speed).
    'B=GPU1
    'C=GPU2
    'D=GPU3
    'E=GPU4
    'F=GPU5
    'G=GPU6
    'H=GPU7
    'I=GPU8
    'J=GPU9
    'K=GPU10
    'L=GPU11
    'M=GPU12
    'N=GPU13
    'O=GPU14
    'P=GPU15
    'Q=GPU16
    'R=GPU17
    'S=GPU18
    'T=GPU19
    'U=GPU20
    'V=GPU21
    'W=GPU22
    'X=GPU23
    'Y=GPU24
    'Z=GPU25
    
    'Second letter tells which command to report from.
    'A=Mh/s
    'B=Temp (f)
    'C=Temp (c)
    'D=Power
    'E=Fan Speed
    sFile = ReadURL("http://" & Right$(sCMD, Len(sCMD) - 2)) 'Remove the 2 letter command prefix from the URL.
    sFile = Replace$(sFile, """#55FFFF""", "")
    sFile = Replace$(sFile, """#AAAAAA""", "")
    sFile = Replace$(sFile, """#FF55FF""", "")
    sFile = Replace$(sFile, """#55FF55""", "")
    sFile = Replace$(sFile, """#FFFFFF""", "")
    sFile = Replace$(sFile, "<font color=>", "")
    sFile = Replace$(sFile, "</font>", "")
    sFile = Replace$(sFile, "<br>", "")

    sSplitFile = Split(sFile, vbLf)
    iTop = UBound(sSplitFile)
    If Not iTop > 0 Then End
    For i = 1 To iTop
        If Len(sSplitFile(i - 1)) > 5 Then
            sPrefix = Left$(sSplitFile(i - 1), 6)
        End If
'        If StrComp(sPrefix, "Eth: N") = 0 Then 'Eth: New job #000000 from host.domain.tld; diff: 0000MH
'            'maybe track difficulty?
'        End If
        If StrComp(sPrefix, "Eth sp") = 0 Then 'Eth speed: 11.111 MH/s, shares: 1234/1/1, time: 38:23
            If StrComp(Mid$(sCMD, 1, 1), "A") = 0 And StrComp(Mid$(sCMD, 2, 1), "A") = 0 Then 'IF CMD1=A(Rig Speed) and CMD2=A(MH/s), show rig speed and quit.
                iFindEnd = InStr(1, sSplitFile(i - 1), ",")
                output1 = Mid$(sSplitFile(i - 1), 12, iFindEnd - 12)
                output1 = Replace$(output1, " MH/s", "")
                If Len(output1) > 1 And IsNumeric(output1) = True Then Exit For Else output1 = "" 'greater than 0.00mh/s...
            End If
            
'            iFindEnd = InStr(iFindEnd, sSplitFile(i - 1), "shares:")
'            iFindEnd2 = InStr(iFindEnd, sSplitFile(i - 1), ",")
'            sValidShares = Split(Mid$(sSplitFile(i - 1), iFindEnd + Len("shares: "), iFindEnd2 - iFindEnd - Len("shares: ")), "/")(0)
'            sRejectedShares = Split(Mid$(sSplitFile(i - 1), iFindEnd + Len("shares: "), iFindEnd2 - iFindEnd - Len("shares: ")), "/")(1)
'            sIncorrectShares = Split(Mid$(sSplitFile(i - 1), iFindEnd + Len("shares: "), iFindEnd2 - iFindEnd - Len("shares: ")), "/")(2)
'            'MsgBox "Valid=" & sValidShares & vbCrLf & "Rejected=" & sRejectedShares & vbCrLf & "Incorrect=" & sIncorrectShares
'
'
'            iFindEnd = InStr(iFindEnd2, sSplitFile(i - 1), "time: ")
'            sTimeSpentMining = Mid$(sSplitFile(i - 1), iFindEnd + Len("time: "), Len(sSplitFile(i - 1)) - iFindEnd - Len("time: ") + 1)
'            'MsgBox sTimeSpentMining
            
            
        End If
        If StrComp(sPrefix, "GPUs: ") = 0 Then 'GPUs: 1: 31.464 MH/s (968) 2: 15.668 MH/s (508)
            'Replace their prefix of "#: " with our letter representation, ie: GPU2=C.
            'Reformatting the line to look like: B=31.464 MH/s (968), C=15.668 MH/s (508)
            If StrComp(Mid$(sCMD, 2, 1), "A") = 0 And StrComp(Mid$(sCMD, 1, 1), "A") <> 0 Then  'Report on MH/s for GPU not RIG
                
                sSplitFile(i - 1) = Replace$(sSplitFile(i - 1), "25: ", "Z=")
                sSplitFile(i - 1) = Replace$(sSplitFile(i - 1), "24: ", "Y=")
                sSplitFile(i - 1) = Replace$(sSplitFile(i - 1), "23: ", "X=")
                sSplitFile(i - 1) = Replace$(sSplitFile(i - 1), "22: ", "W=")
                sSplitFile(i - 1) = Replace$(sSplitFile(i - 1), "21: ", "V=")
                sSplitFile(i - 1) = Replace$(sSplitFile(i - 1), "20: ", "U=")
                sSplitFile(i - 1) = Replace$(sSplitFile(i - 1), "19: ", "T=")
                sSplitFile(i - 1) = Replace$(sSplitFile(i - 1), "18: ", "S=")
                sSplitFile(i - 1) = Replace$(sSplitFile(i - 1), "17: ", "R=")
                sSplitFile(i - 1) = Replace$(sSplitFile(i - 1), "16: ", "Q=")
                sSplitFile(i - 1) = Replace$(sSplitFile(i - 1), "15: ", "P=")
                sSplitFile(i - 1) = Replace$(sSplitFile(i - 1), "14: ", "O=")
                sSplitFile(i - 1) = Replace$(sSplitFile(i - 1), "13: ", "N=")
                sSplitFile(i - 1) = Replace$(sSplitFile(i - 1), "12: ", "M=")
                sSplitFile(i - 1) = Replace$(sSplitFile(i - 1), "11: ", "L=")
                sSplitFile(i - 1) = Replace$(sSplitFile(i - 1), "10: ", "K=")
                sSplitFile(i - 1) = Replace$(sSplitFile(i - 1), "9: ", "J=")
                sSplitFile(i - 1) = Replace$(sSplitFile(i - 1), "8: ", "I=")
                sSplitFile(i - 1) = Replace$(sSplitFile(i - 1), "7: ", "H=")
                sSplitFile(i - 1) = Replace$(sSplitFile(i - 1), "6: ", "G=")
                sSplitFile(i - 1) = Replace$(sSplitFile(i - 1), "5: ", "F=")
                sSplitFile(i - 1) = Replace$(sSplitFile(i - 1), "4: ", "E=")
                sSplitFile(i - 1) = Replace$(sSplitFile(i - 1), "3: ", "D=")
                sSplitFile(i - 1) = Replace$(sSplitFile(i - 1), "2: ", "C=")
                sSplitFile(i - 1) = Replace$(sSplitFile(i - 1), "1: ", "B=")
                
                Dim thisListGPUs() As String
                sSplitFile(i - 1) = Replace$(sSplitFile(i - 1), "GPUs: ", "")
                iFindEnd = InStr(1, sSplitFile(i - 1), Mid$(sCMD, 1, 1) & "=", vbBinaryCompare)
                If iFindEnd > 0 Then 'We found the GPU requested.
                    If StrComp(Mid$(sCMD, 2, 1), "A") = 0 Then 'Report on MH/s
                        iFindEnd2 = InStr(iFindEnd, sSplitFile(i - 1), " ", vbBinaryCompare)
                        output1 = Trim$(Mid$(sSplitFile(i - 1), iFindEnd + 2, iFindEnd2 - iFindEnd - 1)) 'Add 3 to start of mid to skip past prefix of B=

                        If IsNumeric(output1) = True And Len(output1) > 0 Then Exit For Else output1 = ""
                    End If
                End If
            
            End If

'
'            If StrComp(Mid$(sCMD, 1, 1), "A") = 0 And StrComp(Mid$(sCMD, 2, 1), "D") = 0 Then 'Rig Power
'                iFindEnd = InStr(1, sSplitFile(i - 1), "GPUs power", vbBinaryCompare)
'                If iFindEnd > 0 Then
'                    sSplitFile(i - 1) = Mid$(sSplitFile(i - 1), iFindEnd, Len(sSplitFile(i - 1)) - iFindEnd)
'                    output1 = Replace$(sSplitFile(i - 1), "GPUs power: ", "")
'                    output1 = Replace$(sSplitFile(i - 1), " W", "")
'                    If IsNumeric(output1) = True And Len(output1) > 0 Then Exit For Else output1 = "" 'If its not a number reset it to nothing.
'                End If
'            End If


        End If
        
'        If StrComp(sPrefix, "Eth: G") = 0 Then 'Eth: GPU1: ETH share found!
'            '
'        End If
'        If StrComp(sPrefix, "Eth: M") = 0 Then 'Eth: Mining ETH on host.pool.tld:port for 38:42
'            '** conflict with: Eth: Maximum difficulty of found share: 6140.4 GH (!)
'        End If
'        If StrComp(sPrefix, "Eth: S") = 0 Then 'Eth: Share actual difficulty: 19.4 GH (!)
'                '* conflict with prefix:
'            'Eth: Share accepted in 54 ms
'        End If
        If StrComp(sPrefix, "GPUs p") = 0 Then 'GPUs power: 163.3 W
            If StrComp(Mid$(sCMD, 1, 1), "A") = 0 And StrComp(Mid$(sCMD, 2, 1), "D") = 0 Then 'Rig Power
                output1 = Replace$(sSplitFile(i - 1), "GPUs power: ", "")
                output1 = Replace$(output1, " W", "")
                If IsNumeric(output1) = True And Len(output1) > 0 Then Exit For Else output1 = "" 'If its not a number reset it to nothing.
            End If
        End If
        If StrComp(sPrefix, "GPU1: ") = 0 Then 'GPU1: 61C 73% 100W, GPU2: 72C 66% 64W
            'ignore lines with (pcie #) as they are descriptors and not what we need.
            If StrComp(Mid$(sCMD, 2, 1), "A") <> 0 Then 'Any cmd2 except for Mh/s so this covers (temp, power, speed) unless we add another cmd2 entry in the future.
                If InStr(1, sSplitFile(i - 1), "(pcie") = 0 Then
                    sSplitFile(i - 1) = Replace$(sSplitFile(i - 1), "GPU25: ", "Z=")
                    sSplitFile(i - 1) = Replace$(sSplitFile(i - 1), "GPU24: ", "Y=")
                    sSplitFile(i - 1) = Replace$(sSplitFile(i - 1), "GPU23: ", "X=")
                    sSplitFile(i - 1) = Replace$(sSplitFile(i - 1), "GPU22: ", "W=")
                    sSplitFile(i - 1) = Replace$(sSplitFile(i - 1), "GPU21: ", "V=")
                    sSplitFile(i - 1) = Replace$(sSplitFile(i - 1), "GPU20: ", "U=")
                    sSplitFile(i - 1) = Replace$(sSplitFile(i - 1), "GPU19: ", "T=")
                    sSplitFile(i - 1) = Replace$(sSplitFile(i - 1), "GPU18: ", "S=")
                    sSplitFile(i - 1) = Replace$(sSplitFile(i - 1), "GPU17: ", "R=")
                    sSplitFile(i - 1) = Replace$(sSplitFile(i - 1), "GPU16: ", "Q=")
                    sSplitFile(i - 1) = Replace$(sSplitFile(i - 1), "GPU15: ", "P=")
                    sSplitFile(i - 1) = Replace$(sSplitFile(i - 1), "GPU14: ", "O=")
                    sSplitFile(i - 1) = Replace$(sSplitFile(i - 1), "GPU13: ", "N=")
                    sSplitFile(i - 1) = Replace$(sSplitFile(i - 1), "GPU12: ", "M=")
                    sSplitFile(i - 1) = Replace$(sSplitFile(i - 1), "GPU11: ", "L=")
                    sSplitFile(i - 1) = Replace$(sSplitFile(i - 1), "GPU10: ", "K=")
                    sSplitFile(i - 1) = Replace$(sSplitFile(i - 1), "GPU9: ", "J=")
                    sSplitFile(i - 1) = Replace$(sSplitFile(i - 1), "GPU8: ", "I=")
                    sSplitFile(i - 1) = Replace$(sSplitFile(i - 1), "GPU7: ", "H=")
                    sSplitFile(i - 1) = Replace$(sSplitFile(i - 1), "GPU6: ", "G=")
                    sSplitFile(i - 1) = Replace$(sSplitFile(i - 1), "GPU5: ", "F=")
                    sSplitFile(i - 1) = Replace$(sSplitFile(i - 1), "GPU4: ", "E=")
                    sSplitFile(i - 1) = Replace$(sSplitFile(i - 1), "GPU3: ", "D=")
                    sSplitFile(i - 1) = Replace$(sSplitFile(i - 1), "GPU2: ", "C=")
                    sSplitFile(i - 1) = Replace$(sSplitFile(i - 1), "GPU1: ", "B=")
                    iFindEnd = InStr(1, sSplitFile(i - 1), Mid$(sCMD, 1, 1) & "=")
                    If iFindEnd > 0 Then 'We found the GPU requested.
                        If StrComp(Mid$(sCMD, 2, 1), "B") = 0 Then 'Report on temps in F
                            '(X°C × 9/5) + 32 = °F
                            iFindEnd2 = InStr(iFindEnd + 1, sSplitFile(i - 1), "C")
                            output1 = Split( _
                                        Trim$( _
                                            Replace$( _
                                                Mid$( _
                                                    sSplitFile(i - 1), _
                                                    iFindEnd + 2, _
                                                    iFindEnd2 - iFindEnd + 2 _
                                                ), _
                                            "C", "") _
                                        ), _
                                       " ")(0)
                            If IsNumeric(output1) = True Then
                                'Safe to convert to F now.
                                output1 = (CDbl(output1) * 9 / 5) + 32
                                Exit For
                            End If
                        End If
                        If StrComp(Mid$(sCMD, 2, 1), "C") = 0 Then 'Report on temps in C
                            iFindEnd2 = InStr(iFindEnd + 1, sSplitFile(i - 1), "C")
                            output1 = Split( _
                                        Trim$( _
                                            Replace$( _
                                                Mid$( _
                                                    sSplitFile(i - 1), _
                                                    iFindEnd + 2, _
                                                    iFindEnd2 - iFindEnd + 2 _
                                                ), _
                                            "C", "") _
                                        ), _
                                       " ")(0)
                            If IsNumeric(output1) = True Then
                                'Safe to output in C now.
                                Exit For
                            End If
                        End If
                        If StrComp(Mid$(sCMD, 2, 1), "D") = 0 Then 'Report on power
                            iFindEnd2 = InStr(iFindEnd, sSplitFile(i - 1), "W") 'Find the W for watts usage for this GPU.
                            If iFindEnd2 > 0 Then
                                output1 = Replace$( _
                                            Mid$( _
                                                sSplitFile(i - 1), _
                                                InStr(iFindEnd, sSplitFile(i - 1), "%") + 1, _
                                                iFindEnd2 - InStr(iFindEnd, sSplitFile(i - 1), "%")), _
                                            "W", "")
                            Else
                                'some cases the card does not report the watts used. let's not crash here for that :)
                                output1 = "0"
                            End If
                            If Len(output1) > 0 And IsNumeric(output1) = True Then Exit For
                        End If
                        If StrComp(Mid$(sCMD, 2, 1), "E") = 0 Then 'Report on fan speed
                            iFindEnd2 = InStr(iFindEnd, sSplitFile(i - 1), "%") 'Find the % for % fan usage for this GPU.
                            output1 = Replace$( _
                                        Trim$( _
                                            Mid$(sSplitFile(i - 1), _
                                                InStr(iFindEnd + 1, sSplitFile(i - 1), "C", vbBinaryCompare) + 1, _
                                                iFindEnd2 - InStr(iFindEnd + 1, sSplitFile(i - 1), "C", vbBinaryCompare) _
                                            ) _
                                        ), "%", "")

                            If Len(output1) > 0 And IsNumeric(output1) = True Then Exit For
                        End If
                    End If
                End If
            End If
        End If
        
    Next i

        'MRTG wants our output to be:
        '#
        '#
        '0
        '0
        WriteLine output1 & vbCrLf & output1 & vbCrLf & 0 & vbCrLf & 0 & vbCrLf
        
End Sub
