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
Public Class WebServiceDcto
    Inherits System.Web.Services.WebService



    <WebMethod(Description:="Retorna los documentos asignados a la solicitud")> _
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json, XmlSerializeString:=True)>
    Public Function GetDcto(idsol As Integer, iddcto As Integer) As String

        Dim constr As String = ConfigurationManager.ConnectionStrings("cf5").ConnectionString
        Dim query As String = "select *,Convert(char, mFecEnvio, 103) as mFechaEnvio,Convert(char, mFecRecibo, 103) as mFechaRecibe from mdcto as b where midsol =" & idsol & " and midDcto=" & iddcto

        Dim custDA As NpgsqlDataAdapter = New NpgsqlDataAdapter(query, constr)

        Dim custDS As DataSet = New DataSet()
        custDA.MissingSchemaAction = MissingSchemaAction.AddWithKey
        custDA.Fill(custDS, "Documento")
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


    <WebMethod(Description:="Retorna los tipos de documentos que existen")> _
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json, XmlSerializeString:=True)>
    Public Function GetTipoDcto(accion As Integer) As String
        Dim constr As String = ConfigurationManager.ConnectionStrings("cf5").ConnectionString
        Dim query As String = "select * from ctipodocumento where cidtipodoc NOT in (1)"
        Dim custDA As NpgsqlDataAdapter = New NpgsqlDataAdapter(query, constr)
        Dim custDS As DataSet = New DataSet()
        custDA.MissingSchemaAction = MissingSchemaAction.AddWithKey
        custDA.Fill(custDS, "TipoDcto")
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

    <WebMethod(Description:="Actualizar el registro del documento")> _
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json, XmlSerializeString:=True)>
    Public Function ActDcto(objDcto As clsDcto) As String
        Dim constr As String = ConfigurationManager.ConnectionStrings("cf5").ConnectionString
        Dim iddcto As Integer = 0
        Dim numerror As Integer = 0
        Dim messerror As String = Nothing

        Using con As New NpgsqlConnection(constr)
            Using cmd As New NpgsqlCommand("sp_dcto", con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@idsol", objDcto.idsol)
                cmd.Parameters.AddWithValue("@idref", objDcto.idref)
                cmd.Parameters.AddWithValue("@iddcto", objDcto.iddcto)
                cmd.Parameters.AddWithValue("@folio", objDcto.folio)
                cmd.Parameters.AddWithValue("@FecSolic", objDcto.FecSolic)
                cmd.Parameters.AddWithValue("@FecRecib", objDcto.FecRecib)
                cmd.Parameters.AddWithValue("@NumRecibe", objDcto.NumRecibe)
                cmd.Parameters.AddWithValue("@NomArchivo", objDcto.NomArchivo)
                cmd.Parameters.AddWithValue("@TipoDcto", objDcto.TipoDcto)
                cmd.Parameters.AddWithValue("@UsuCre", objDcto.UsuCre)
                cmd.Parameters.AddWithValue("@FecCre", objDcto.FecCre)
                cmd.Parameters.AddWithValue("@UsuMod", objDcto.UsuMod)
                cmd.Parameters.AddWithValue("@FecMod", objDcto.FecMod)
                cmd.Parameters.AddWithValue("@accion", objDcto.Accion)
                Dim parIdError As NpgsqlParameter = New NpgsqlParameter("@NoError", NpgsqlTypes.NpgsqlDbType.Integer) ' .Value = 0
                parIdError.Direction = ParameterDirection.Output

                Dim parDesError As NpgsqlParameter = New NpgsqlParameter("@DescError", NpgsqlTypes.NpgsqlDbType.Varchar, 1000) ' .Value = Space(1000)
                parDesError.Direction = ParameterDirection.Output

                Dim pariddcto As NpgsqlParameter = New NpgsqlParameter("@iddctoR", NpgsqlTypes.NpgsqlDbType.Integer) ' .Value = 0
                pariddcto.Direction = ParameterDirection.Output

                cmd.Parameters.Add(parIdError)
                cmd.Parameters.Add(parDesError)
                cmd.Parameters.Add(pariddcto)

                cmd.Connection = con
                con.Open()
                cmd.ExecuteNonQuery()

                numerror = cmd.Parameters("@NoError").Value()
                messerror = cmd.Parameters("@DescError").Value()
                iddcto = cmd.Parameters("@iddctoR").Value()
                con.Close()
            End Using
        End Using
        Try
            Return "Registro de Documento guardado "
        Catch ex As Exception
            Return "Error " & ex.Message
        End Try
    End Function

    <WebMethod(Description:="Recaba todas los documentos de las solicitudes")>
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json)>
    Public Function GetDctos(pPageSize As Integer, pCurrentPage As Integer, pSortColumn As String, pSortOrder As String, idsol As Integer) As JQGridJsonResponseDcto
        Return GetDctosJSon(pPageSize, pCurrentPage, pSortColumn, pSortOrder, idsol)

    End Function

    Private Function GetDctosJSon(pPageSize As Integer, pPageNumber As Integer, pSortColumn As String, pSorterOrder As String, idsol As Integer) As JQGridJsonResponseDcto
        Dim constr As String = ConfigurationManager.ConnectionStrings("cf5").ConnectionString
        Dim dt As DataSet = New DataSet()

        Dim pagecount As Integer
        Dim recordcount As Integer
        Dim currentpage As Integer

        Using con As New NpgsqlConnection(constr)
            Using cmd As New NpgsqlCommand("sp_dcto_grid", con)
                Dim adapt As NpgsqlDataAdapter = New NpgsqlDataAdapter(cmd)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@PageSize", pPageSize)
                cmd.Parameters.AddWithValue("@CurrentPage", pPageNumber)
                cmd.Parameters.AddWithValue("@SortColumn", pSortColumn)
                cmd.Parameters.AddWithValue("@SortOrder", pSorterOrder)
                cmd.Parameters.AddWithValue("@Idsol", idsol)



                adapt.Fill(dt)
                Dim dctos = New List(Of clsDcto)

                Dim intRegsTb As Integer = Convert.ToInt32(dt.Tables(0).Rows(0)("out_recordcount"))
                If (intRegsTb > 0) Then
                    For Each row As DataRow In dt.Tables(1).Rows
                        Dim dcto As clsDcto = New clsDcto()
                        dcto.idsol = Convert.ToInt32(row.Item("idsol"))
                        dcto.idref = Convert.ToInt32(row.Item("midref"))
                        dcto.folio = row.Item("mfolio")
                        dcto.iddcto = row.Item("midDcto")
                        dcto.FecSolic = row.Item("mFechaEnvio")
                        dcto.FecRecib = row.Item("mFechaRecibe")
                        dcto.NomRecibe = row.Item("mUsuNombre")
                        dcto.NomArchivo = row.Item("mNomArchivo")
                        dcto.TipoDcto = row.Item("mTipoDcto")
                        dcto.DesDcto = row.Item("cDescrip")
                        dcto.UsuCre = row.Item("mUsuCre")
                        dcto.FecCre = row.Item("mFecCre")
                        dcto.UsuMod = row.Item("mUsuMod")
                        dcto.FecMod = row.Item("mFecMod")
                        dctos.Add(dcto)
                    Next row
                End If
                pagecount = Convert.ToInt32(dt.Tables(0).Rows(0)("out_pagecount"))
                recordcount = Convert.ToInt32(dt.Tables(0).Rows(0)("out_recordcount"))
                currentpage = Convert.ToInt32(dt.Tables(0).Rows(0)("out_currentpage"))
                Dim objeto As JQGridJsonResponseDcto = New JQGridJsonResponseDcto
                objeto.JQGridJsonResponseDcto(pagecount, currentpage, recordcount, dctos)
                Return objeto
            End Using
        End Using
    End Function
End Class