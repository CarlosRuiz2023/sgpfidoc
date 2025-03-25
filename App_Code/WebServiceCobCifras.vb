Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.Script.Services
Imports System.Web.Services



' Para permitir que se llame a este servicio web desde un script, usando ASP.NET AJAX, quite la marca de comentario de la línea siguiente.
<System.Web.Script.Services.ScriptService()> _
<WebService(Namespace:="http://tempuri.org/")> _
<WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)> _
<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Public Class WebServiceCobCifras
    Inherits System.Web.Services.WebService



    <WebMethod(Description:="Recaba el padrón de cartera vencida")>
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json)>
    Public Function GetCobCifras(pPageSize As Integer, pCurrentPage As Integer, pSortColumn As String, pSortOrder As String) As JQGridJsonResponseCobranzaCifras
        Return GetCobCifrasJSon(pPageSize, pCurrentPage, pSortColumn, pSortOrder)

    End Function

    Private Function GetCobCifrasJSon(pPageSize As Integer, pPageNumber As Integer, pSortColumn As String, pSorterOrder As String) As JQGridJsonResponseCobranzaCifras
        Dim constr As String = ConfigurationManager.ConnectionStrings("cf25").ConnectionString
        Dim dt As DataSet = New DataSet()

        Using con As New SqlConnection(constr)
            Using cmd As New SqlCommand("SP_CobCifrasGrid", con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@PageSize", pPageSize)
                cmd.Parameters.AddWithValue("@CurrentPage", pPageNumber)
                cmd.Parameters.AddWithValue("@SortColumn", pSortColumn)
                cmd.Parameters.AddWithValue("@SortOrder", pSorterOrder)
                cmd.Parameters.AddWithValue("@NoError", 1)
                cmd.Parameters.AddWithValue("@DescError", "ERROR")
                Dim adapt As SqlDataAdapter = New SqlDataAdapter(cmd)

                adapt.Fill(dt)
                Dim cobcifras = New List(Of clsCobCifras)
                If Convert.ToInt32(dt.Tables(0).Rows(0)("RecordCount")) > 0 Then
                    For Each row As DataRow In dt.Tables(1).Rows
                        Dim cobcifra As clsCobCifras = New clsCobCifras()
                        cobcifra.numadeudos = ValidarDBNull(row.Item("numadeudos"))
                        cobcifra.totalsaldocon = ValidarDBNull(row.Item("totalsaldocon"))
                        cobcifra.totalsaldosin = row.Item("totalsaldosin")
                        cobcifra.noobras = ValidarDBNull(row.Item("numoid"))
                        cobcifra.nopredios = ValidarDBNull(row.Item("numpid"))
                        cobcifras.Add(cobcifra)
                    Next row
                End If
                Dim objeto As JQGridJsonResponseCobranzaCifras = New JQGridJsonResponseCobranzaCifras
                objeto.JQGridJsonResponseCobranzaCifras(Convert.ToInt32(dt.Tables(0).Rows(0)("PageCount")), Convert.ToInt32(dt.Tables(0).Rows(0)("CurrentPage")), Convert.ToInt32(dt.Tables(0).Rows(0)("RecordCount")), cobcifras)
                Return objeto

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