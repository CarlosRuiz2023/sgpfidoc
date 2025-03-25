Imports System.Data
Imports System.Web.Script.Services
Imports System.Web.Services
Imports Npgsql

' Para permitir que se llame a este servicio web desde un script, usando ASP.NET AJAX, quite la marca de comentario de la línea siguiente.
<System.Web.Script.Services.ScriptService()> _
<WebService(Namespace:="http://tempuri.org/")> _
<WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)> _
<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Public Class WebServicePobra
    Inherits System.Web.Services.WebService

    <WebMethod(Description:="Recaba todas los polígonos de obra")>
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json)>
    Public Function GetPobra_psql(pPageSize As Integer, pCurrentPage As Integer, pSortColumn As String, pSortOrder As String, pFiltro As String) As JQGridJsonResponsePobra
        Return GetPobraJSon_psql(pPageSize, pCurrentPage, pSortColumn, pSortOrder, pFiltro)

    End Function

    Private Function GetPobraJSon_psql(pPageSize As Integer, pPageNumber As Integer, pSortColumn As String, pSorterOrder As String, pFiltro As String) As JQGridJsonResponsePobra
        Dim constr As String = ConfigurationManager.ConnectionStrings("cf5").ConnectionString
        Dim dt As DataSet = New DataSet()
        Dim pagecount As Integer
        Dim recordcount As Integer
        Dim currentpage As Integer




        Using con As New NpgsqlConnection(constr)
            Using cmd As New NpgsqlCommand("public2.sp_pobra_grid", con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@PageSize", pPageSize)
                cmd.Parameters.AddWithValue("@CurrentPage", pPageNumber)
                cmd.Parameters.AddWithValue("@SortColumn", pSortColumn)
                cmd.Parameters.AddWithValue("@SortOrder", pSorterOrder)
                cmd.Parameters.AddWithValue("@Filtro", pFiltro)
                Dim adapt As NpgsqlDataAdapter = New NpgsqlDataAdapter(cmd)
                adapt.Fill(dt)
                Dim pobras = New List(Of clsPobra)
                Dim intRegsTb As Integer = Convert.ToInt32(dt.Tables(0).Rows(0)("out_recordcount"))
                If (intRegsTb > 0) Then
                    For Each row As DataRow In dt.Tables(0).Rows
                        Dim pobra As clsPobra = New clsPobra()
                        pobra.oid = ValidarDBNull(row.Item("out_oid"), "entero")
                        pobra.calle = ValidarDBNull(row.Item("out_calle"), "cadena")
                        pobra.colonia = ValidarDBNull(row.Item("out_colonia"), "entero")
                        pobra.tramo = ValidarDBNull(row.Item("out_tramo"), "cadena")
                        pobra.limite1 = ValidarDBNull(row.Item("out_limite1"), "entero")
                        pobra.limite2 = ValidarDBNull(row.Item("out_limite2"), "entero")
                        pobras.Add(pobra)
                    Next row
                End If
                pagecount = Convert.ToInt32(dt.Tables(0).Rows(0)("out_pagecount"))
                recordcount = Convert.ToInt32(dt.Tables(0).Rows(0)("out_recordcount"))
                currentpage = Convert.ToInt32(dt.Tables(0).Rows(0)("out_currentpage"))

                Dim objeto As JQGridJsonResponsePobra = New JQGridJsonResponsePobra
                objeto.JQGridJsonResponsePobra(pagecount, currentpage, recordcount, pobras)
                Return objeto
            End Using
        End Using
    End Function


    Private Function ValidarDBNull(objParametro As Object, tipodato As String) As Object
        If IsDBNull(objParametro.ToString) Then
            ValidarDBNull = ""
        Else
            If objParametro.ToString = "" Then
                If tipodato = "entero" Then
                    ValidarDBNull = 0
                Else
                    If tipodato = "fecha" Then
                        ValidarDBNull = "01/01/1900"
                    Else
                        If tipodato = "real" Then
                            ValidarDBNull = "0.0"
                        Else
                            ValidarDBNull = ""
                        End If
                    End If
                End If
            Else
                ValidarDBNull = objParametro.ToString
            End If
        End If
        Return ValidarDBNull
    End Function


End Class