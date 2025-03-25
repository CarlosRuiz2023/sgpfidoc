Imports System.Data
Imports System.Data.SqlClient
Imports System.IO
Imports System.Web.Script.Services
Imports System.Web.Services

' Para permitir que se llame a este servicio web desde un script, usando ASP.NET AJAX, quite la marca de comentario de la línea siguiente.
<System.Web.Script.Services.ScriptService()> _
<WebService(Namespace:="http://tempuri.org/")> _
<WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)> _
<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Public Class WebServiceAnuencia
    Inherits System.Web.Services.WebService

    Public Conn As SqlConnection = New SqlConnection("Data Source=192.168.1.4;Initial Catalog=fidoc;user id=usrfidoc;password=pwdfidoc;")

    <WebMethod(Description:="Retorna los documentos asignados a la solicitud")> _
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json, XmlSerializeString:=True)>
    Public Function GetAnu(idsol As Integer, idanu As Integer) As String
        Dim query As String = "select b.*,c.mNomArchivo,c.midDcto,Convert(char, mAnuFechaE, 103) as mFechaEnvio,Convert(char, mAnuFechaR, 103) as mFechaRecibe from mAnuencia as b left join mDcto as c on b.manuid = c.midref  where msolid =" & idsol & " and manuid=" & idanu
        Dim custDA As SqlDataAdapter = New SqlDataAdapter(query, Conn)
        Dim custDS As DataSet = New DataSet()
        custDA.MissingSchemaAction = MissingSchemaAction.AddWithKey
        custDA.Fill(custDS, "Anuencia")
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

    <WebMethod(Description:="Recaba todas los documentos de las solicitudes")>
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json)>
    Public Function GetAnuencias(pPageSize As Integer, pCurrentPage As Integer, pSortColumn As String, pSortOrder As String, pFiltro As String, idsol As Integer) As JQGridJsonResponseAnuencia
        Return GetAnuJSon(pPageSize, pCurrentPage, pSortColumn, pSortOrder, pFiltro, idsol)

    End Function

    Private Function GetAnuJSon(pPageSize As Integer, pPageNumber As Integer, pSortColumn As String, pSorterOrder As String, pFiltro As String, idsol As Integer) As JQGridJsonResponseAnuencia
        Dim constr As String = ConfigurationManager.ConnectionStrings("cf25").ConnectionString
        Dim dt As DataSet = New DataSet()

        Using con As New SqlConnection(constr)
            Using cmd As New SqlCommand("SP_AnuGrid", con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@PageSize", pPageSize)
                cmd.Parameters.AddWithValue("@CurrentPage", pPageNumber)
                cmd.Parameters.AddWithValue("@SortColumn", pSortColumn)
                cmd.Parameters.AddWithValue("@SortOrder", pSorterOrder)
                cmd.Parameters.AddWithValue("@Filtro", pFiltro)
                cmd.Parameters.AddWithValue("@Idsol", idsol)
                cmd.Parameters.AddWithValue("@NoError", 1)
                cmd.Parameters.AddWithValue("@DescError", "ERROR")
                Dim adapt As SqlDataAdapter = New SqlDataAdapter(cmd)

                adapt.Fill(dt)
                Dim anuencias = New List(Of clsAnuencia)
                If Convert.ToInt32(dt.Tables(0).Rows(0)("RecordCount")) > 0 Then
                    For Each row As DataRow In dt.Tables(1).Rows
                        Dim anuencia As clsAnuencia = New clsAnuencia()
                        anuencia.IdSol = Convert.ToInt32(row.Item("idsol"))
                        anuencia.IdAnu = Convert.ToInt32(row.Item("mAnuId"))
                        anuencia.Folio = row.Item("mAnuNFolio")
                        anuencia.NomPromCalle = row.Item("mAnuRecibe")
                        anuencia.DomicProm = row.Item("mAnuDomicilio")
                        anuencia.TelProm = row.Item("mAnuTel")
                        anuencia.PromFidoc = ValidarDBNull(row.Item("mUsuNombre"))
                        anuencia.FecEntrega = row.Item("mFechaEnvio")
                        anuencia.FecRecibo = row.Item("mFechaRecibe")
                        anuencia.EstatusAnuencia = row.Item("cEstDesc")
                        anuencia.UsuCre = row.Item("UsrCre")
                        anuencia.FecCre = row.Item("FecCre")
                        anuencia.UsuMod = row.Item("UsrMod")
                        anuencia.FecMod = row.Item("FecMod")
                        anuencia.docdig = ValidarDBNull(row.Item("mNomArchivo"))
                        anuencias.Add(anuencia)
                    Next row

                End If
                Dim objeto As JQGridJsonResponseAnuencia = New JQGridJsonResponseAnuencia
                objeto.JQGridJsonResponseAnuencia(Convert.ToInt32(dt.Tables(0).Rows(0)("PageCount")), Convert.ToInt32(dt.Tables(0).Rows(0)("CurrentPage")), Convert.ToInt32(dt.Tables(0).Rows(0)("RecordCount")), anuencias)
                Return objeto

            End Using
        End Using
    End Function


    <WebMethod(Description:="Actualizar el registro de la Anuencia")> _
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json, XmlSerializeString:=True)>
    Public Function ActAnuencia(objAnu As clsAnuencia) As String
        Dim constr As String = ConfigurationManager.ConnectionStrings("cf25").ConnectionString
        Dim idAnu As Integer = 0
        Dim numerror As Integer = 0
        Dim AnuAceptaPresup As Integer = 0
        Dim messerror As String = Nothing

        Using con As New SqlConnection(constr)
            Using cmd As New SqlCommand("SP_Anuencia", con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@idsol", objAnu.IdSol)
                cmd.Parameters.AddWithValue("@idAnu", objAnu.IdAnu)
                cmd.Parameters.AddWithValue("@FolioAnu", objAnu.Folio)
                cmd.Parameters.AddWithValue("@NomPromCalle", objAnu.NomPromCalle)
                cmd.Parameters.AddWithValue("@DomicProm", objAnu.DomicProm)
                cmd.Parameters.AddWithValue("@TelProm", objAnu.TelProm)
                cmd.Parameters.AddWithValue("@PromFidoc", objAnu.PromFidoc)
                cmd.Parameters.AddWithValue("@FecEntrega", objAnu.FecEntrega)
                cmd.Parameters.AddWithValue("@FecRecibo", objAnu.FecRecibo)
                cmd.Parameters.AddWithValue("@EstatusAnu", objAnu.EstatusAnuencia)
                cmd.Parameters.AddWithValue("@docdig", objAnu.docdig)
                cmd.Parameters.AddWithValue("@usucre", objAnu.UsuCre)
                cmd.Parameters.AddWithValue("@feccre", objAnu.FecCre)
                cmd.Parameters.AddWithValue("@usumod", objAnu.UsuMod)
                cmd.Parameters.AddWithValue("@fecmod", objAnu.FecMod)
                cmd.Parameters.AddWithValue("@accion", objAnu.Accion)
                Dim parIdError As SqlParameter = New SqlParameter("@NoError", SqlDbType.Int) ' .Value = 0
                parIdError.Direction = ParameterDirection.Output

                Dim parDesError As SqlParameter = New SqlParameter("@DescError", SqlDbType.VarChar, 1000) ' .Value = Space(1000)
                parDesError.Direction = ParameterDirection.Output

                Dim paridfact As SqlParameter = New SqlParameter("@idanuR", SqlDbType.Int) ' .Value = 0
                paridfact.Direction = ParameterDirection.Output


                Dim parAnuAceptaPresup As SqlParameter = New SqlParameter("@AnuAceptaPresup", SqlDbType.Int) ' .Value = 0
                parAnuAceptaPresup.Direction = ParameterDirection.Output

                cmd.Parameters.Add(parIdError)
                cmd.Parameters.Add(parDesError)
                cmd.Parameters.Add(paridfact)
                cmd.Parameters.Add(parAnuAceptaPresup)

                cmd.Connection = con
                con.Open()
                cmd.ExecuteNonQuery()

                idAnu = ValidarDBNull(cmd.Parameters("@idanuR").Value())
                numerror = cmd.Parameters("@NoError").Value()
                messerror = cmd.Parameters("@DescError").Value()
                AnuAceptaPresup = ValidarDBNull(cmd.Parameters("@AnuAceptaPresup").Value())
                con.Close()
            End Using
        End Using
        Try
            Return "Accion ejecutada correctamente:" & idAnu.ToString & ":" & AnuAceptaPresup.ToString
        Catch ex As SqlException
            Return ex.Message & "No.Error:" & numerror.ToString() & "Mensaje error:" & messerror
        End Try
    End Function

    <WebMethod(Description:="Retorna valores del catálogo del estatus de anuencias")> _
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json, XmlSerializeString:=True)>
    Public Function GetEstAnu(accion As Integer) As String
        Dim query As String = Nothing

        If accion = 0 Then
            query = "select cEstId,cEstDesc from cEstAnuencia where cestid = 1"
        End If

        If accion = 1 Then
            query = "select cEstId,cEstDesc from cEstAnuencia where cestid <>  1"
        End If

        Dim custDA As SqlDataAdapter = New SqlDataAdapter(query, Conn)
        Dim custDS As DataSet = New DataSet()
        custDA.MissingSchemaAction = MissingSchemaAction.AddWithKey
        custDA.Fill(custDS, "EstatusAnu")
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

    <WebMethod(Description:="Retorna el estatus de una anuencia teniendo su idanu")> _
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json, XmlSerializeString:=True)>
    Public Function GetEstatusAnuencia(idanu As String) As String
        Dim query As String = Nothing
        query = "select mAnuId,cEstId,cEstDesc from mAnuencia as a inner join cEstAnuencia as b on a.mAnuestatus = b.cEstId where a.mAnuId =" + idanu
        Dim custDA As SqlDataAdapter = New SqlDataAdapter(query, Conn)
        Dim custDS As DataSet = New DataSet()
        custDA.MissingSchemaAction = MissingSchemaAction.AddWithKey
        custDA.Fill(custDS, "EstatusAnu")
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

    Private Function ValidarDBNull(objParametro As Object) As Object
        If IsDBNull(objParametro.ToString) Then
            ValidarDBNull = ""
        Else
            If objParametro.ToString = "" Then
                ValidarDBNull = 0
            Else
                ValidarDBNull = objParametro.ToString
            End If
        End If
    End Function
End Class