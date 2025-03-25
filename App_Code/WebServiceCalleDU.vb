Imports System.Data
Imports System.Web.Script.Services
Imports System.Web.Services
Imports Npgsql

' Para permitir que se llame a este servicio web desde un script, usando ASP.NET AJAX, quite la marca de comentario de la línea siguiente.
<System.Web.Script.Services.ScriptService()> _
<WebService(Namespace:="http://tempuri.org/")> _
<WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)> _
<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Public Class WebServiceCalleDU
    Inherits System.Web.Services.WebService


    <WebMethod(Description:="Recaba todas los documentos de las solicitudes")>
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json)>
    Public Function GetCalleDU_Grid(pPageSize As Integer, pCurrentPage As Integer, pSortColumn As String, pSortOrder As String, pFiltro As String) As JQGridJsonResponseCalleDU

        Return GetCallesDU(pPageSize, pCurrentPage, pSortColumn, pSortOrder, pfiltro)

    End Function

    Private Function GetCallesDU(pPageSize As Integer, pPageNumber As Integer, pSortColumn As String, pSorterOrder As String, pFiltro As String) As JQGridJsonResponseCalleDU
        Dim constr2 As String = ConfigurationManager.ConnectionStrings("cf5").ConnectionString
        Dim dt As DataSet = New DataSet()
        Dim dt2 As DataSet = New DataSet()
        Dim pagecount As Integer
        Dim recordcount As Integer
        Dim currentpage As Integer

        Dim fidx As Integer = 0
        Dim numerror As Integer = 0
        Dim messerror As String = Nothing


        Using con As New NpgsqlConnection(constr2)
            Using cmd As New NpgsqlCommand("public2.sp_calles_du_grid", con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@pagesize", pPageSize)
                cmd.Parameters.AddWithValue("@currentpage", pPageNumber)
                cmd.Parameters.AddWithValue("@sortcolumn", pSortColumn)
                cmd.Parameters.AddWithValue("@sortorder", pSorterOrder)
                cmd.Parameters.AddWithValue("@filtro", pFiltro)
                Dim adapt As NpgsqlDataAdapter = New NpgsqlDataAdapter(cmd)
                adapt.Fill(dt)
                Dim calles_du = New List(Of clsCalleDU)
                Dim intRegsTb As Integer = Convert.ToInt32(dt.Tables(0).Rows(0)("out_recordcount"))
                If (intRegsTb > 0) Then
                    For Each row As DataRow In dt.Tables(0).Rows
                        Dim calle_du As clsCalleDU = New clsCalleDU()
                        calle_du.id = ValidarDBNull(row.Item("out_id"), "entero")
                        calle_du.objectid = ValidarDBNull(row.Item("out_objectid"), "entero")
                        calle_du.clavecalle = ValidarDBNull(row.Item("out_clavecalle"), "entero")
                        calle_du.nomactual = ValidarDBNull(row.Item("out_nomactual"), "cadena")
                        calle_du.nomanterio = ValidarDBNull(row.Item("out_nomanterio"), "cadena")
                        calle_du.tipo = ValidarDBNull(row.Item("out_tipo"), "cadena")
                        calle_du.clasificac = ValidarDBNull(row.Item("out_clasificac"), "real")
                        calle_du.sector = ValidarDBNull(row.Item("out_sector"), "entero")
                        calle_du.subsector = ValidarDBNull(row.Item("out_subsector"), "entero")
                        calle_du.sectorsub = ValidarDBNull(row.Item("out_sectorsub"), "entero")
                        calle_du.colonia = ValidarDBNull(row.Item("out_colonia"), "cadena")
                        calle_du.colindacon = ValidarDBNull(row.Item("out_colindacon"), "cadena")
                        calle_du.sectorsubc = ValidarDBNull(row.Item("out_sectorsubc"), "entero")
                        calle_du.jerarquia = ValidarDBNull(row.Item("out_jerarquia"), "cadena")
                        calle_du.inicia_jer = ValidarDBNull(row.Item("out_inicia_jer"), "entero")
                        calle_du.termina_je = ValidarDBNull(row.Item("out_termina_je"), "cadena")
                        calle_du.corredor = ValidarDBNull(row.Item("out_corredor"), "cadena")
                        calle_du.actualizac = ValidarDBNull(row.Item("out_actualizac"), "fecha")
                        calle_du.observacio = ValidarDBNull(row.Item("out_observacio"), "cadena")
                        calle_du.shape_leng = ValidarDBNull(row.Item("out_shape_leng"), "real")
                        calles_du.Add(calle_du)
                    Next row
                End If
                pagecount = Convert.ToInt32(dt.Tables(0).Rows(0)("out_pagecount"))
                recordcount = Convert.ToInt32(dt.Tables(0).Rows(0)("out_recordcount"))
                currentpage = Convert.ToInt32(dt.Tables(0).Rows(0)("out_currentpage"))
                Dim objeto As JQGridJsonResponseCalleDU = New JQGridJsonResponseCalleDU
                objeto.JQGridJsonResponseCalleDU(pagecount, currentpage, recordcount, calles_du)
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
                            If tipodato = "hora" Then
                                ValidarDBNull = "00:00:00"
                            Else
                                If tipodato = "fechalarga" Then

                                    ValidarDBNull = "01/01/1900 00:00:00.000-00"
                                Else
                                    ValidarDBNull = ""
                                End If
                            End If
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