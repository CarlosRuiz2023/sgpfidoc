Public Class funciones
    Public strMensajeError As String

    Public Function LeerRequest(ByVal Parametro As String, ByVal objRequest As HttpRequest) As String
        Dim variable As String
        If objRequest.QueryString.Count > 0 Then
            variable = objRequest.QueryString(Parametro)
        ElseIf objRequest.Form.Count > 0 Then
            variable = objRequest.Form(Parametro)
        Else
            variable = "0"
        End If
        Return variable
    End Function

    ''' <summary>
    ''' envia fecha para regresarla con el formato para consulta de sqlserver
    ''' </summary>
    ''' <param name="Fecha"></param>
    ''' <returns></returns>
    ''' <remarks></remarks>
    Public Function FechaAAAAMMDD(ByVal Fecha As Date) As String
        Dim cHoy = DatePart(DateInterval.Year, Fecha) & "/" & _
                   DatePart(DateInterval.Month, Fecha).ToString.PadLeft(2, "0"c) & "/" _
                   & DatePart(DateInterval.Day, Fecha)
        Return cHoy
    End Function

    Public Function NumAletra(ByVal value As Double) As String
        Select Case value
            Case 0 : NumAletra = "CERO"
            Case 1 : NumAletra = "UN"
            Case 2 : NumAletra = "DOS"
            Case 3 : NumAletra = "TRES"
            Case 4 : NumAletra = "CUATRO"
            Case 5 : NumAletra = "CINCO"
            Case 6 : NumAletra = "SEIS"
            Case 7 : NumAletra = "SIETE"
            Case 8 : NumAletra = "OCHO"
            Case 9 : NumAletra = "NUEVE"
            Case 10 : NumAletra = "DIEZ"
            Case 11 : NumAletra = "ONCE"
            Case 12 : NumAletra = "DOCE"
            Case 13 : NumAletra = "TRECE"
            Case 14 : NumAletra = "CATORCE"
            Case 15 : NumAletra = "QUINCE"
            Case Is < 20 : NumAletra = "DIECI" & NumAletra(value - 10)
            Case 20 : NumAletra = "VEINTE"
            Case Is < 30 : NumAletra = "VEINTI" & NumAletra(value - 20)
            Case 30 : NumAletra = "TREINTA"
            Case 40 : NumAletra = "CUARENTA"
            Case 50 : NumAletra = "CINCUENTA"
            Case 60 : NumAletra = "SESENTA"
            Case 70 : NumAletra = "SETENTA"
            Case 80 : NumAletra = "OCHENTA"
            Case 90 : NumAletra = "NOVENTA"
            Case Is < 100 : NumAletra = NumAletra(Int(value \ 10) * 10) & " Y " & NumAletra(value Mod 10)
            Case 100 : NumAletra = "CIEN"
            Case Is < 200 : NumAletra = "CIENTO " & NumAletra(value - 100)
            Case 200, 300, 400, 600, 800 : NumAletra = NumAletra(Int(value \ 100)) & "CIENTOS"
            Case 500 : NumAletra = "QUINIENTOS"
            Case 700 : NumAletra = "SETECIENTOS"
            Case 900 : NumAletra = "NOVECIENTOS"
            Case Is < 1000 : NumAletra = NumAletra(Int(value \ 100) * 100) & " " & NumAletra(value Mod 100)
            Case 1000 : NumAletra = "MIL"
            Case Is < 2000 : NumAletra = "MIL " & NumAletra(value Mod 1000)
            Case Is < 1000000 : NumAletra = NumAletra(Int(value \ 1000)) & " MIL"
                If value Mod 1000 Then NumAletra = NumAletra & " " & NumAletra(value Mod 1000)
            Case 1000000 : NumAletra = "UN MILLON"
            Case Is < 2000000 : NumAletra = "UN MILLON " & NumAletra(value Mod 1000000)
            Case Is < 1000000000000.0# : NumAletra = NumAletra(Int(value / 1000000)) & " MILLONES "
                If (value - Int(value / 1000000) * 1000000) Then NumAletra = NumAletra & " " & NumAletra(value - Int(value / 1000000) * 1000000)
            Case 1000000000000.0# : NumAletra = "UN BILLON"
            Case Is < 2000000000000.0# : NumAletra = "UN BILLON " & NumAletra(value - Int(value / 1000000000000.0#) * 1000000000000.0#)
            Case Else : NumAletra = NumAletra(Int(value / 1000000000000.0#)) & " BILLONES"
                If (value - Int(value / 1000000000000.0#) * 1000000000000.0#) Then NumAletra = NumAletra & " " & NumAletra(value - Int(value / 1000000000000.0#) * 1000000000000.0#)
        End Select
    End Function

#Region "Funciones para FECHAS"
    ''' <summary>
    ''' Devuelve la fecha con formato DD de "mes" de "año"
    ''' </summary>
    ''' <param name="fecha"></param>
    ''' <returns></returns>
    ''' <remarks></remarks>
    Public Function FechaMiFormato(ByVal fecha As Date) As String
        Dim nMes As Integer
        Dim DesMes As String = ""
        nMes = Month(fecha)
        Select Case nMes
            Case 1
                DesMes = "Enero"
            Case 2
                DesMes = "Febrero"
            Case 3
                DesMes = "Marzo"
            Case 4
                DesMes = "Abril"
            Case 5
                DesMes = "Mayo"
            Case 6
                DesMes = "Junio"
            Case 7
                DesMes = "Julio"
            Case 8
                DesMes = "Agosto"
            Case 9
                DesMes = "Septiembre"
            Case 10
                DesMes = "Octubre"
            Case 11
                DesMes = "Noviembre"
            Case 12
                DesMes = "Diciembre"
        End Select
        FechaMiFormato = Day(fecha).ToString & " de " & DesMes & " de " & Year(fecha)
    End Function

    ''' <summary>
    ''' Devuelve la fecha con formato "dia" de "mes" del "año"
    ''' </summary>
    ''' <param name="fecha"></param>
    ''' <returns></returns>
    ''' <remarks></remarks>
    Public Function FechaFormatoLetras(ByVal fecha As Date, Optional ByVal AddWordPresente As Boolean = False) As String
        Dim nMes As Integer
        Dim DesMes As String = ""
        nMes = Month(fecha)
        Select Case nMes
            Case 1
                DesMes = "Enero"
            Case 2
                DesMes = "Febrero"
            Case 3
                DesMes = "Marzo"
            Case 4
                DesMes = "Abril"
            Case 5
                DesMes = "Mayo"
            Case 6
                DesMes = "Junio"
            Case 7
                DesMes = "Julio"
            Case 8
                DesMes = "Agosto"
            Case 9
                DesMes = "Septiembre"
            Case 10
                DesMes = "Octubre"
            Case 11
                DesMes = "Noviembre"
            Case 12
                DesMes = "Diciembre"
        End Select
        If AddWordPresente Then
            FechaFormatoLetras = NumAletra(Day(fecha).ToString).ToLower & " de " & DesMes.ToLower & " del presente"
        Else
            FechaFormatoLetras = NumAletra(Day(fecha).ToString).ToLower & " de " & DesMes.ToLower & " del " & Year(fecha)
        End If
    End Function

    Public Function NomMes(ByVal fecha As Date) As String
        Dim nombremes As String = ""
        Select Case Month(fecha)
            Case 1
                nombremes = "Enero"
            Case 2
                nombremes = "Febrero"
            Case 3
                nombremes = "Marzo"
            Case 4
                nombremes = "Abril"
            Case 5
                nombremes = "Mayo"
            Case 6
                nombremes = "Junio"
            Case 7
                nombremes = "Julio"
            Case 8
                nombremes = "Agosto"
            Case 9
                nombremes = "Septiembre"
            Case 10
                nombremes = "Octubre"
            Case 11
                nombremes = "Noviembre"
            Case 12
                nombremes = "Diciembre"
        End Select
        NomMes = nombremes
    End Function

    ''' <summary>
    ''' Calcula la fecha sin contemplar sabados y domingos
    ''' </summary>
    ''' <param name="Fecha"></param>
    ''' <param name="nDias"></param>
    ''' <returns></returns>
    ''' <remarks></remarks>
    Public Function SumaDiasLaborables(ByVal Fecha As Date, ByVal nDias As Integer) As Date
        Dim i As Integer = 0
        While i < nDias
            Fecha = Fecha.AddDays(1)
            If Fecha.DayOfWeek = 0 Or Fecha.DayOfWeek = 6 Then
                nDias = nDias + 1
            End If
            i = i + 1
        End While

        Return Fecha
    End Function
    ''' <summary>
    ''' Suma los meses checando que si cae en sabado o domingo, se pasará hasta el lunes
    ''' </summary>
    ''' <param name="Fecha"></param>
    ''' <param name="nMeses"></param>
    ''' <returns></returns>
    ''' <remarks></remarks>
    Public Function SumaMes(ByVal Fecha As Date, ByVal nMeses As Integer) As Date
        Dim i As Integer = 0
        Fecha = Fecha.AddMonths(nMeses)
        If Fecha.DayOfWeek = 0 Or Fecha.DayOfWeek = 6 Then
            Fecha.AddDays(1)
        End If
        If Fecha.DayOfWeek = 0 Or Fecha.DayOfWeek = 6 Then
            Fecha.AddDays(1)
        End If
        Return Fecha
    End Function

    ''' <summary>
    ''' Determina si una fecha es correcta y que el año sea mayor a 1900
    ''' </summary>
    ''' <param name="Fecha"></param>
    ''' <returns></returns>
    ''' <remarks></remarks>
    Public Function EsFecha(ByVal Fecha As String) As Boolean
        Dim paso = True
        If Not IsDate(Fecha) Then
            paso = False
        End If
        If IsDate(Fecha) Then
            If Year(CDate(Fecha)) < 1900 Then
                paso = False
            End If
        End If
        Return paso
    End Function

#End Region

    Public Function validar_Mail(ByVal sMail As String) As Boolean
        ' retorna true o false   
        Return Regex.IsMatch(sMail, _
                "^([\w-]+\.)*?[\w-]+@[\w-]+\.([\w-]+\.)*?[\w]+$")
    End Function
    Public Function validar_URL(ByVal pURL As String) As Boolean
        Dim re As Regex = New Regex( _
            "^(https?|ftp|file)://[-A-Z0-9+&@#/%?=~_|!:,.;]*[-A-Z0-9+&@#/%=~_|]", _
            RegexOptions.IgnoreCase)

        Dim m As Match = re.Match(pURL)

        If m.Captures.Count = 0 Then
            validar_URL = False
        Else
            validar_URL = True
        End If
    End Function
    Public Function validar_Hora(ByVal sHora As String) As Boolean
        ' retorna true o false   
        'HH:MM:SS
        'Return Regex.IsMatch(sHora, "[0-2][0-9]\:[0-6][0-9]\:[0-5][0-9]")
        'HH:MM
        Return Regex.IsMatch(sHora, "[0-2][0-9]\:[0-6][0-9]")
    End Function

#Region "Funciones para Encriptar y DesEntriptar"
    Private Function ConvToHex(ByVal x As Integer) As String
        If x > 9 Then
            ConvToHex = Chr(x + 55)
        Else
            ConvToHex = CStr(x)
        End If
    End Function

    ' función que codifica el dato  
    Function Encriptar(ByVal Texto As String) As String
        ' Dim Clave As String, i As Integer, Pass2 As String
        ' Dim CAR As String, Codigo As String
        'Clave = "%ü&/@#$A"
        'Pass2 = ""

        'For i = 1 To Len(Texto)
        'CAR = Mid(Texto, i, 1)
        'Codigo = Mid(Clave, ((i - 1) Mod Len(Clave)) + 1, 1)
        'Pass2 = Pass2 & Microsoft.VisualBasic.Strings.Right("0" & Hex(Asc(Codigo) Xor Asc(CAR)), 2)
        'Next i
        Encriptar = Texto
    End Function


    Function DesEncriptar(ByVal Texto As String) As String
        Dim Clave As String, i As Integer, Pass2 As String
        Dim CAR As String, Codigo As String
        Dim j As Integer

        Clave = "%ü&/@#$A"
        Pass2 = ""
        j = 1
        For i = 1 To Len(Texto) Step 2
            CAR = Mid(Texto, i, 2)
            Codigo = Mid(Clave, ((j - 1) Mod Len(Clave)) + 1, 1)
            Pass2 = Pass2 & Chr(Asc(Codigo) Xor Val("&h" + CAR))
            j = j + 1
        Next i
        DesEncriptar = Pass2
    End Function

#End Region
End Class
