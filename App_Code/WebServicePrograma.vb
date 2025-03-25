Imports System.Data
Imports System.Data.OleDb
Imports System.IO
Imports System.Web.Script.Services
Imports System.Web.Services
Imports Npgsql


' Para permitir que se llame a este servicio web desde un script, usando ASP.NET AJAX, quite la marca de comentario de la línea siguiente.
<System.Web.Script.Services.ScriptService()> _
<WebService(Namespace:="http://tempuri.org/")> _
<WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)> _
<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Public Class WebServicePrograma
    Inherits System.Web.Services.WebService


    <WebMethod(Description:="Actualizar el registro del documento")> _
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json, XmlSerializeString:=True)>
    Public Function GetProg(accion As Integer, idprog As Integer) As String
        Dim constr As String = ConfigurationManager.ConnectionStrings("cf5").ConnectionString
        Dim ds As DataSet = New DataSet()

        Using con As New NpgsqlConnection(constr)
            Using cmd As New NpgsqlCommand("sp_progq", con)
                Dim adapt As NpgsqlDataAdapter = New NpgsqlDataAdapter(cmd)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@accionx", accion)
                cmd.Parameters.AddWithValue("@idprogx", idprog)
                adapt.Fill(ds, "Prog")
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



    <WebMethod(Description:="Retorna los nombres de colonias de la BD de SIFIDOC")> _
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json, XmlSerializeString:=True)>
    Public Function GetProgramaSIFIDOC() As String
        Dim constr As String = ConfigurationManager.ConnectionStrings("cf6").ConnectionString
        Dim ds As DataSet = New DataSet()

        Dim strSQL As String = "select * from programa order by pro_nom"

        Using con As New OleDbConnection(constr)
            Using cmd As New OleDbCommand(strSQL, con)
                Dim adapt As OleDbDataAdapter = New OleDbDataAdapter(cmd)
                adapt.Fill(ds, "programa_sifidoc")
            End Using
        End Using
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

    End Function


    <WebMethod(Description:="Retorna los nombres de colonias de la BD de SIFIDOC")> _
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json, XmlSerializeString:=True)>
    Public Function GetSistemaSIFIDOC() As String
        Dim constr As String = ConfigurationManager.ConnectionStrings("cf6").ConnectionString
        Dim ds As DataSet = New DataSet()

        Dim strSQL As String = "select * from sistema order by sis_nom"

        Using con As New OleDbConnection(constr)
            Using cmd As New OleDbCommand(strSQL, con)
                Dim adapt As OleDbDataAdapter = New OleDbDataAdapter(cmd)
                adapt.Fill(ds, "sistema_sifidoc")
            End Using
        End Using
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

    End Function


End Class