Imports System

Module Program
    Sub Main(args As String())
        Dim lineCount = 499 ' 499
        Dim arr(lineCount, 3) As Integer
        Dim maxX As Integer = 0
        Dim maxY As Integer = 0
        ' get from standard in
        For i As Integer = 0 To lineCount
            Dim coord() As String = Split(Console.ReadLine(), " -> ")
            Dim first() As String = Split(coord(0), ",")
            Dim second() As String = Split(coord(1), ",")

            ' Dim newRow(3) as Integer
            Dim x1, y1, x2, y2 as Integer
            x1 = Convert.toInt32(first(0))
            y1 = Convert.toInt32(first(1))
            x2 = Convert.toInt32(second(0))
            y2 = Convert.toInt32(second(1))

            maxX = Math.Max(Math.Max(maxX, x1), x2)
            maxY = Math.Max(Math.Max(maxY, y1), y2)

            arr(i, 0) = x1
            arr(i, 1) = x2
            arr(i, 2) = y1
            arr(i, 3) = y2
            ' arr.Add(newRow)
            ' arr.Add(newRow)
            ' Console.WriteLine(i)
        Next

        ' Console.WriteLine(maxX) ' 989
        ' Console.WriteLine(maxY)
        Dim board(maxX, maxY) As Integer
        ' mark line on board
        For i As Integer = 0 To lineCount
            ' Console.WriteLine(arr(i, 0))
            If arr(i, 0) = arr(i, 1) Then
                ' Console.WriteLine(arr(i, 0))
                ' Console.WriteLine(arr(i, 2))
                ' Console.WriteLine(arr(i, 3))
                ' Dim maxer = Math.Max(arr(i, 2), arr(i, 3))
                ' Console.WriteLine(maxer)
                ' Exit For
                ' line from (i, 2) to (i, 3)
                If arr(i, 2) = Math.Max(arr(i, 2), arr(i, 3)) Then
                    For j As Integer = arr(i, 2) To arr(i, 3) Step -1
                        board(j, arr(i, 0)) += 1
                    Next
                Else
                    For j As Integer = arr(i, 2) To arr(i, 3)
                        board(j, arr(i, 0)) += 1
                    Next
                End If
            ElseIf arr(i, 2) = arr(i, 3) Then
                ' line from (i, 0) to (i, 1)
                If arr(i, 0) = Math.Max(arr(i, 0), arr(i, 1)) Then
                    For j As Integer = arr(i, 0) To arr(i, 1) Step -1
                        board(arr(i, 2), j) += 1
                    Next
                Else
                    For j As Integer = arr(i, 0) To arr(i, 1)
                        board(arr(i, 2), j) += 1
                    Next
                End If
            End If
        Next

        Dim counter = 0
        For i As Integer = 0 To maxX
            For j As Integer = 0 To maxY
                If board(i, j) > 1 Then
                    counter += 1
                End If
            Next
        Next
        Console.WriteLine(counter)
    End Sub
End Module
