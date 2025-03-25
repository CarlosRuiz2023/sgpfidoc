Imports System.Data
Imports System.IO
Imports System.Web.Script.Services
Imports System.Web.Services
Imports Npgsql


' Para permitir que se llame a este servicio web desde un script, usando ASP.NET AJAX, quite la marca de comentario de la línea siguiente.
<System.Web.Script.Services.ScriptService()> _
<WebService(Namespace:="http://tempuri.org/")> _
<WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)> _
<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Public Class WebServicePredio
    Inherits System.Web.Services.WebService


    <WebMethod(Description:="Retorna datos de un predio seleccionado")> _
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json, XmlSerializeString:=True)>
    Public Function GetPredio(objPredio As clsPredio) As String
        Dim constr As String = ConfigurationManager.ConnectionStrings("cf5").ConnectionString
        Dim pidx As Integer = 0
        Dim numerror As Integer = 0
        Dim messerror As String = Nothing
        Dim ds As DataSet = New DataSet()


        Using con As New NpgsqlConnection(constr)
            Using cmd As New NpgsqlCommand("public2.sp_predio", con)
                Dim adapt As NpgsqlDataAdapter = New NpgsqlDataAdapter(cmd)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@pidx", objPredio.pid)
                cmd.Parameters.AddWithValue("@cupx", objPredio.cup)
                cmd.Parameters.AddWithValue("@fecha_crx", objPredio.fecha_cr)
                cmd.Parameters.AddWithValue("@fecha_mox", objPredio.fecha_mo)
                cmd.Parameters.AddWithValue("@usrcrex", objPredio.usrcre)
                cmd.Parameters.AddWithValue("@usrmodx", objPredio.usrmod)
                cmd.Parameters.AddWithValue("@tipox", objPredio.tipo)
                cmd.Parameters.AddWithValue("@tipoprediox", objPredio.tipopredio)
                cmd.Parameters.AddWithValue("@ctapredialx", objPredio.ctapredial)
                cmd.Parameters.AddWithValue("@ctaimuvix", objPredio.ctaimuvi)
                cmd.Parameters.AddWithValue("@observaciox", objPredio.observacio)
                cmd.Parameters.AddWithValue("@usoprediox", objPredio.usopredio)
                cmd.Parameters.AddWithValue("@r20x", objPredio.r20)
                cmd.Parameters.AddWithValue("@nooficialx", objPredio.nooficial)
                cmd.Parameters.AddWithValue("@sapalx", objPredio.sapal)
                cmd.Parameters.AddWithValue("@geomx", objPredio.geom)
                cmd.Parameters.AddWithValue("@mznax", objPredio.mzna)
                cmd.Parameters.AddWithValue("@lotex", objPredio.lote)
                cmd.Parameters.AddWithValue("@accionx", objPredio.accion)
                If objPredio.accion = "consultapredio" Or objPredio.accion = "consultaprediopid" Then
                    adapt.Fill(ds, "Predio")
                Else
                    cmd.Connection = con
                    con.Open()
                    cmd.ExecuteNonQuery()
                End If
                Try
                    Dim sb = New StringBuilder()
                    Using writer = New StringWriter(sb)
                        ds.WriteXml(writer)
                        Dim xml As String = sb.ToString()
                        Return xml
                    End Using
                Catch ex As Exception
                    Return "Error " & ex.Message
                End Try
                con.Close()
            End Using
        End Using
    End Function

    <WebMethod(Description:="Retorna sector,subsector,nombre_actual,nombre_ant de las colonias de DU")> _
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json, XmlSerializeString:=True)>
    Public Function GetFrentesPredio(pid As String) As String
        Dim constr As String = ConfigurationManager.ConnectionStrings("cf5").ConnectionString
        Dim dt As DataSet = New DataSet()
        Using con As New NpgsqlConnection(constr)
            Using cmd As New NpgsqlCommand("select count(*) as numfrentes from frentes where pid=" + pid, con)
                Dim adapt As NpgsqlDataAdapter = New NpgsqlDataAdapter(cmd)
                adapt.MissingSchemaAction = MissingSchemaAction.AddWithKey
                adapt.Fill(dt, "frentesxp")
            End Using
        End Using

        Try
            Dim sb = New StringBuilder()
            Using writer = New StringWriter(sb)
                dt.WriteXml(writer)
                Dim xml As String = sb.ToString()
                Return xml
            End Using
        Catch ex As Exception
            Return "Error " & ex.Message
        End Try

    End Function


    <WebMethod(Description:="Retorna sector,subsector,nombre_actual,nombre_ant de las colonias de DU")> _
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json, XmlSerializeString:=True)>
    Public Function GetNumPredio(ctapredial As String) As String
        Dim constr As String = ConfigurationManager.ConnectionStrings("cf5").ConnectionString
        Dim dt As DataSet = New DataSet()
        Using con As New NpgsqlConnection(constr)
            Using cmd As New NpgsqlCommand("sp_predio_q", con)
                Dim adapt As NpgsqlDataAdapter = New NpgsqlDataAdapter(cmd)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@ctapredial_in", ctapredial)
                adapt.Fill(dt, "predio")
            End Using

            Try
                Dim sb = New StringBuilder()
                Using writer = New StringWriter(sb)
                    dt.WriteXml(writer)
                    Dim xml As String = sb.ToString()
                    Return xml
                End Using
            Catch ex As Exception
                Return "Error " & ex.Message
            End Try
        End Using
    End Function

    <WebMethod(Description:="Retorna sector,subsector,nombre_actual,nombre_ant de las colonias de DU")> _
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json, XmlSerializeString:=True)>
    Public Function GetFrentesObrasxPredio(pid As String) As String
        Dim constr As String = ConfigurationManager.ConnectionStrings("cf5").ConnectionString
        Dim dt As DataSet = New DataSet()
        Using con As New NpgsqlConnection(constr)
            Using cmd As New NpgsqlCommand("select fid,pid,oid from frentes as a where a.pid=" + pid, con)
                Dim adapt As NpgsqlDataAdapter = New NpgsqlDataAdapter(cmd)
                adapt.MissingSchemaAction = MissingSchemaAction.AddWithKey
                adapt.Fill(dt, "frentesxp")
            End Using
        End Using

        Try
            Dim sb = New StringBuilder()
            Using writer = New StringWriter(sb)
                dt.WriteXml(writer)
                Dim xml As String = sb.ToString()
                Return xml
            End Using
        Catch ex As Exception
            Return "Error " & ex.Message
        End Try

    End Function

End Class