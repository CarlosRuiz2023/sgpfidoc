Imports System.Data
Imports System.Data.SqlClient
Imports System.IO
Imports System.Web.Script.Services
Imports System.Web.Services
Imports Npgsql


' Para permitir que se llame a este servicio web desde un script, usando ASP.NET AJAX, quite la marca de comentario de la línea siguiente.
<System.Web.Script.Services.ScriptService()> _
<WebService(Namespace:="http://tempuri.org/")> _
<WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)> _
<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Public Class WebServiceRelCoopPred
    Inherits System.Web.Services.WebService

    Public Conn As SqlConnection = New SqlConnection("Data Source=192.168.1.4;Initial Catalog=fidoc;user id=upfidoc;password=pwdfidoc;")

    <WebMethod(Description:="Retorna sector,subsector,nombre_actual,nombre_ant de las colonias de DU")> _
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json, XmlSerializeString:=True)>
    Public Function ConsultaRelCoopPredio() As String
        Dim query As String = "select cidrelpred,crelacionpredio from cRelCoopPredio where celiminado = 0"
        Dim custDA As SqlDataAdapter = New SqlDataAdapter(query, Conn)
        Dim custDS As DataSet = New DataSet()
        custDA.MissingSchemaAction = MissingSchemaAction.AddWithKey
        custDA.Fill(custDS, "AllRelPred")
        Try
            Dim sb = New StringBuilder()
            Using writer = New StringWriter(sb)
                custDS.WriteXml(writer)
                Dim xml As String = sb.ToString()
                Return xml
            End Using
        Catch ex As Exception
            Return "Error " & ex.Message
        End Try
    End Function

    <WebMethod(Description:="Retorna sector,subsector,nombre_actual,nombre_ant de las colonias de DU")> _
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json, XmlSerializeString:=True)>
    Public Function ConsultaRelCoopPredioP(accion As String) As String
        Dim constr As String = ConfigurationManager.ConnectionStrings("cf5").ConnectionString
        Dim ds As DataSet = New DataSet()
        Dim numerror As Integer = 0
        Dim messerror As String = Nothing

        Using con As New NpgsqlConnection(constr)
            Using cmd As New NpgsqlCommand("public2.sp_relacionpredio", con)
                Dim custDA As NpgsqlDataAdapter = New NpgsqlDataAdapter(cmd)
                cmd.Parameters.AddWithValue("@accion", accion)
                cmd.CommandType = CommandType.StoredProcedure
                custDA.Fill(ds, "relpredio")

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

End Class