Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.Script.Services
Imports System.Web.Services
Imports Npgsql


' Para permitir que se llame a este servicio web desde un script, usando ASP.NET AJAX, quite la marca de comentario de la línea siguiente.
<System.Web.Script.Services.ScriptService()> _
<WebService(Namespace:="http://tempuri.org/")> _
<WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)> _
<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Public Class WebServiceINPC
    Inherits System.Web.Services.WebService

    <WebMethod(Description:="Recaba todas los documentos de las solicitudes")>
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json)>
    Public Function Get_INPC(pPageSize As Integer, pCurrentPage As Integer, pSortColumn As String, pSortOrder As String) As JQGridJsonResponseINPC
        Return GetINPC_psql(pPageSize, pCurrentPage, pSortColumn, pSortOrder)

    End Function

    Private Function GetINPC_psql(pPageSize As Integer, pPageNumber As Integer, pSortColumn As String, pSorterOrder As String) As JQGridJsonResponseINPC
        Dim constr As String = ConfigurationManager.ConnectionStrings("cf5").ConnectionString
        Dim dt As DataSet = New DataSet()
        Dim pagecount As Integer
        Dim recordcount As Integer
        Dim currentpage As Integer




        Using con As New NpgsqlConnection(constr)
            Using cmd As New NpgsqlCommand("public3.sp_inpc_grid", con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@PageSize", pPageSize)
                cmd.Parameters.AddWithValue("@CurrentPage", pPageNumber)
                cmd.Parameters.AddWithValue("@SortColumn", pSortColumn)
                cmd.Parameters.AddWithValue("@SortOrder", pSorterOrder)
                Dim adapt As NpgsqlDataAdapter = New NpgsqlDataAdapter(cmd)
                adapt.Fill(dt)
                Dim inpc_s = New List(Of clsinpc)
                Dim intRegsTb As Integer = Convert.ToInt32(dt.Tables(0).Rows(0)("out_recordcount"))
                If (intRegsTb > 0) Then
                    For Each row As DataRow In dt.Tables(0).Rows
                        Dim inpc As clsinpc = New clsinpc()
                        inpc.mes = ValidarDBNull(row.Item("mes_r"), "entero")
                        inpc.year = ValidarDBNull(row.Item("year_r"), "entero")
                        inpc.yearmes = ValidarDBNull(row.Item("yearmes_r"), "cadena")
                        inpc.valor_inpc = ValidarDBNull(row.Item("valor_inpc_r"), "real")
                        inpc_s.Add(inpc)
                    Next row
                End If
                pagecount = Convert.ToInt32(dt.Tables(0).Rows(0)("out_pagecount"))
                recordcount = Convert.ToInt32(dt.Tables(0).Rows(0)("out_recordcount"))
                currentpage = Convert.ToInt32(dt.Tables(0).Rows(0)("out_currentpage"))

                Dim objeto As JQGridJsonResponseINPC = New JQGridJsonResponseINPC
                objeto.JQGridJsonResponseINPC(pagecount, currentpage, recordcount, inpc_s)
                Return objeto




            End Using
        End Using
    End Function

    <WebMethod(Description:="Actualizar el registro del documento")> _
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json, XmlSerializeString:=True)>
    Public Function ActINPC(objinpc As clsinpc) As String
        Dim constr As String = ConfigurationManager.ConnectionStrings("cf5").ConnectionString
        Dim idinpc As String = Nothing
        Dim numerror As Integer = 0
        Dim messerror As String = Nothing


        Using con As New NpgsqlConnection(constr)
            Using cmd As New NpgsqlCommand("public3.sp_inpc", con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@mes", objinpc.mes)
                cmd.Parameters.AddWithValue("@year", objinpc.year)
                cmd.Parameters.AddWithValue("@yearmes", objinpc.yearmes)
                cmd.Parameters.AddWithValue("@valor_inpc", objinpc.valor_inpc)
                cmd.Parameters.AddWithValue("@accion", objinpc.accion)

                Dim parIdError As NpgsqlParameter = New NpgsqlParameter("@NoError", NpgsqlTypes.NpgsqlDbType.Integer) ' .Value = 0
                parIdError.Direction = ParameterDirection.Output

                Dim parDesError As NpgsqlParameter = New NpgsqlParameter("@DescError", NpgsqlTypes.NpgsqlDbType.Varchar, 1000) ' .Value = Space(1000)
                parDesError.Direction = ParameterDirection.Output

                Dim paridinpc As NpgsqlParameter = New NpgsqlParameter("@idinpcx", NpgsqlTypes.NpgsqlDbType.Integer) ' .Value = 0
                paridinpc.Direction = ParameterDirection.Output

                cmd.Parameters.Add(parIdError)
                cmd.Parameters.Add(parDesError)
                cmd.Parameters.Add(paridinpc)

                cmd.Connection = con
                con.Open()
                cmd.ExecuteNonQuery()

                numerror = cmd.Parameters("@NoError").Value()
                messerror = cmd.Parameters("@DescError").Value()
                idinpc = cmd.Parameters("@idinpcx").Value()
                con.Close()
            End Using
        End Using
        Try
            Return "Accion ejecutada correctamente:" & idinpc.ToString
        Catch ex As SqlException
            Return ex.Message & "No.Error:" & numerror.ToString() & "Mensaje error:" & messerror
        End Try
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
                                ValidarDBNull = ""
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