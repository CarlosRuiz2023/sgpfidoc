Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.Script.Services
Imports System.Web.Services


' Para permitir que se llame a este servicio web desde un script, usando ASP.NET AJAX, quite la marca de comentario de la línea siguiente.
<System.Web.Script.Services.ScriptService()> _
<WebService(Namespace:="http://tempuri.org/")> _
<WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)> _
<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Public Class WebServiceCobranza
    Inherits System.Web.Services.WebService


    <WebMethod(Description:="Recaba el padrón de cartera vencida")>
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json)>
    Public Function GetCobranza(pPageSize As Integer, pCurrentPage As Integer, pSortColumn As String, pSortOrder As String, pFiltro As String, paccion As Integer) As JQGridJsonResponseCobranza
        Return GetCobJSon(pPageSize, pCurrentPage, pSortColumn, pSortOrder, pFiltro, paccion)
    End Function

    Private Function GetCobJSon(pPageSize As Integer, pPageNumber As Integer, pSortColumn As String, pSorterOrder As String, pFiltro As String, paccion As Integer) As JQGridJsonResponseCobranza
        Dim constr As String = ConfigurationManager.ConnectionStrings("cf25").ConnectionString
        Dim dt As DataSet = New DataSet()
        Dim numerror As Integer
        Dim messerror As String

        Using con As New SqlConnection(constr)
            Using cmd As New SqlCommand("SP_CobGrid", con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@PageSize", pPageSize)
                cmd.Parameters.AddWithValue("@CurrentPage", pPageNumber)
                cmd.Parameters.AddWithValue("@SortColumn", pSortColumn)
                cmd.Parameters.AddWithValue("@SortOrder", pSorterOrder)
                cmd.Parameters.AddWithValue("@Filtro", pFiltro)
                cmd.Parameters.AddWithValue("@accion", paccion)
                Dim adapt As SqlDataAdapter = New SqlDataAdapter(cmd)


                Dim parIdError As SqlParameter = New SqlParameter("@NoError", SqlDbType.Int) ' .Value = 0
                parIdError.Direction = ParameterDirection.Output

                Dim parDesError As SqlParameter = New SqlParameter("@DescError", SqlDbType.VarChar, 1000) ' .Value = Space(1000)
                parDesError.Direction = ParameterDirection.Output

                cmd.Parameters.Add(parIdError)
                cmd.Parameters.Add(parDesError)

                adapt.Fill(dt)

                numerror = cmd.Parameters("@NoError").Value()
                messerror = cmd.Parameters("@DescError").Value()

                Dim cobranzas = New List(Of clsCobranza)
                If Convert.ToInt32(dt.Tables(0).Rows(0)("RecordCount")) > 0 Then
                    For Each row As DataRow In dt.Tables(1).Rows
                        Dim cobranza As clsCobranza = New clsCobranza()
                        cobranza.coop = ValidarDBNull(row.Item("coop"))
                        cobranza.nomficha = ValidarDBNull(row.Item("mNomFicha"))
                        cobranza.domnotif = ValidarDBNull(row.Item("mDomNotif"))
                        cobranza.fid = row.Item("fid")
                        cobranza.mtsfrente = ValidarDBNull(row.Item("mts_frente"))
                        cobranza.cid = ValidarDBNull(row.Item("cid"))
                        cobranza.cooperador = ValidarDBNull(row.Item("cooperador"))
                        cobranza.pid = row.Item("pid")
                        cobranza.oid = row.Item("oid")
                        cobranza.prid = row.Item("prid")
                        cobranza.calle = ValidarDBNull(row.Item("calle"))
                        cobranza.nooficial = ValidarDBNull(row.Item("nooficial"))
                        cobranza.colonia = ValidarDBNull(row.Item("colonia"))
                        cobranza.tramo = ValidarDBNull(row.Item("tramo"))
                        cobranza.ctapredial = ValidarDBNull(row.Item("ctapredial"))
                        cobranza.costom = ValidarDBNull(row.Item("costo_mto_lineal"))
                        cobranza.adeudotot = ValidarDBNull(row.Item("adeudo_total"))
                        cobranza.saldosin = ValidarDBNull(row.Item("saldosin"))
                        cobranza.saldocon = ValidarDBNull(row.Item("saldocon"))
                        cobranzas.Add(cobranza)
                    Next row
                End If
                Dim objeto As JQGridJsonResponseCobranza = New JQGridJsonResponseCobranza
                objeto.JQGridJsonResponseCobranza(Convert.ToInt32(dt.Tables(0).Rows(0)("PageCount")), Convert.ToInt32(dt.Tables(0).Rows(0)("CurrentPage")), Convert.ToInt32(dt.Tables(0).Rows(0)("RecordCount")), cobranzas)
                Return objeto

            End Using
        End Using
    End Function

    <WebMethod(Description:="Recaba el padrón de cartera vencida")>
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json)>
    Public Function GetCobranzaExportacion(pPageSize As Integer, pCurrentPage As Integer, pSortColumn As String, pSortOrder As String, pFiltro As String, paccion As Integer) As List(Of clsCobranza)
        Dim constr As String = ConfigurationManager.ConnectionStrings("cf25").ConnectionString
        Dim dt As DataSet = New DataSet()
        Dim numerror As Integer
        Dim messerror As String

        Using con As New SqlConnection(constr)
            Using cmd As New SqlCommand("SP_CobGrid", con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@PageSize", pPageSize)
                cmd.Parameters.AddWithValue("@CurrentPage", pCurrentPage)
                cmd.Parameters.AddWithValue("@SortColumn", pSortColumn)
                cmd.Parameters.AddWithValue("@SortOrder", pSortOrder)
                cmd.Parameters.AddWithValue("@Filtro", pFiltro)
                cmd.Parameters.AddWithValue("@accion", paccion)
                Dim adapt As SqlDataAdapter = New SqlDataAdapter(cmd)


                Dim parIdError As SqlParameter = New SqlParameter("@NoError", SqlDbType.Int) ' .Value = 0
                parIdError.Direction = ParameterDirection.Output

                Dim parDesError As SqlParameter = New SqlParameter("@DescError", SqlDbType.VarChar, 1000) ' .Value = Space(1000)
                parDesError.Direction = ParameterDirection.Output

                cmd.Parameters.Add(parIdError)
                cmd.Parameters.Add(parDesError)

                adapt.Fill(dt)

                numerror = cmd.Parameters("@NoError").Value()
                messerror = cmd.Parameters("@DescError").Value()

                Dim cobranzas = New List(Of clsCobranza)
                If Convert.ToInt32(dt.Tables(0).Rows(0)("RecordCount")) > 0 Then
                    For Each row As DataRow In dt.Tables(1).Rows
                        Dim cobranza As clsCobranza = New clsCobranza()
                        cobranza.coop = ValidarDBNull(row.Item("coop"))
                        cobranza.nomficha = ValidarDBNull(row.Item("mNomFicha"))
                        cobranza.domnotif = ValidarDBNull(row.Item("mDomNotif"))
                        cobranza.fid = row.Item("fid")
                        cobranza.mtsfrente = ValidarDBNull(row.Item("mts_frente"))
                        cobranza.cid = ValidarDBNull(row.Item("cid"))
                        cobranza.cooperador = ValidarDBNull(row.Item("cooperador"))
                        cobranza.pid = row.Item("pid")
                        cobranza.oid = row.Item("oid")
                        cobranza.prid = row.Item("prid")
                        cobranza.calle = ValidarDBNull(row.Item("calle"))
                        cobranza.nooficial = ValidarDBNull(row.Item("nooficial"))
                        cobranza.colonia = ValidarDBNull(row.Item("colonia"))
                        cobranza.tramo = ValidarDBNull(row.Item("tramo"))
                        cobranza.ctapredial = ValidarDBNull(row.Item("ctapredial"))
                        cobranza.costom = ValidarDBNull(row.Item("costo_mto_lineal"))
                        cobranza.adeudotot = ValidarDBNull(row.Item("adeudo_total"))
                        cobranza.saldosin = ValidarDBNull(row.Item("saldosin"))
                        cobranza.saldocon = ValidarDBNull(row.Item("saldocon"))
                        cobranzas.Add(cobranza)
                    Next row
                End If
                Return cobranzas

            End Using
        End Using
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