Imports System.Data
Imports System.Data.OleDb
Imports System.Data.SqlClient
Imports System.IO
Imports System.Web.Script.Services
Imports System.Web.Services
Imports Npgsql


' Para permitir que se llame a este servicio web desde un script, usando ASP.NET AJAX, quite la marca de comentario de la línea siguiente.
<System.Web.Script.Services.ScriptService()> _
<WebService(Namespace:="http://192.168.1.5/fidoc")> _
<WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)> _
<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Public Class WebServiceCalCol
    Inherits System.Web.Services.WebService

    Public Conn As SqlConnection = New SqlConnection("Data Source=192.168.1.4;Initial Catalog=fidoc;user id=usrfidoc;password=pwdfidoc;")

    <WebMethod(Description:="Retorna sector,subsector,nombre_actual,nombre_ant de las colonias de DU")> _
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json, XmlSerializeString:=True)>
    Public Function GetColoniasS(idcolonia As Integer) As String
        Dim constr As String = ConfigurationManager.ConnectionStrings("cf5").ConnectionString
        Dim ds As DataSet = New DataSet()

        Using con As New NpgsqlConnection(constr)
            Using cmd As New NpgsqlCommand("public2.sp_coloniassq", con)
                Dim adapt As NpgsqlDataAdapter = New NpgsqlDataAdapter(cmd)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@idcolonia", idcolonia)
                adapt.Fill(ds, "colonia")
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
    Public Function GetColoniasSIFIDOC() As String
        Dim constr As String = ConfigurationManager.ConnectionStrings("cf6").ConnectionString
        Dim ds As DataSet = New DataSet()

        Dim strSQL As String = "select * from colonias order by col_nom"

        Using con As New OleDbConnection(constr)
            Using cmd As New OleDbCommand(strSQL, con)
                Dim adapt As OleDbDataAdapter = New OleDbDataAdapter(cmd)
                adapt.Fill(ds, "colonias_sifidoc")
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






    <WebMethod(Description:="Retorna sector,subsector,nombre_actual,nombre_ant de las colonias de DU")> _
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json, XmlSerializeString:=True)>
    Public Function GetColoniaS() As String
        Dim query As String = "select SECFNO AS CveSector,SSCFNO as CveSubsector,NOMFNO as Colonia from [192.1.1.4].LCSDESUR2.dbo.DEUPFCOL order by Colonia"
        Dim custDA As SqlDataAdapter = New SqlDataAdapter(query, Conn)
        Dim custDS As DataSet = New DataSet()

        custDA.MissingSchemaAction = MissingSchemaAction.AddWithKey
        custDA.Fill(custDS, "ColoniasDU")
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

    <WebMethod(Description:="Retorna sector,subsector,nombre_actual,nombre_ant de las calles de DU")> _
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json, XmlSerializeString:=True)>
    Public Function GetCalles(parametro As String) As String
        Dim query As String = "select A.SECCNO AS CveSector,A.SSCCNO as CveSubsector,(convert(varchar,A.SECCNO) + convert(varchar,A.SSCCNO)) as parametro, A.CLACNO as CveCalle,A.NACCNO as Calle,A.NANCNO AS CALLEANT from [192.1.1.4].LCSDESUR2.dbo.DEUPFCAL as A where (convert(varchar,A.SECCNO) + convert(varchar,A.SSCCNO))='" + parametro + "' order by Calle"
        Dim custDA As SqlDataAdapter = New SqlDataAdapter(query, Conn)
        Dim custDS As DataSet = New DataSet()

        custDA.MissingSchemaAction = MissingSchemaAction.AddWithKey
        custDA.Fill(custDS, "CallesDU")
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

End Class