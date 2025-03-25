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
Public Class WebServiceLevant
    Inherits System.Web.Services.WebService

    Public Conn As SqlConnection = New SqlConnection("Data Source=192.168.1.4;Initial Catalog=fidoc;user id=usrfidoc;password=pwdfidoc;")


    <WebMethod(Description:="Retorna los levantamientos relacionados a la solicitud en funcion a una solasolicitud de calle")> _
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json, XmlSerializeString:=True)>
    Public Function GetLev(idsol As Integer, idlev As Integer) As String
        Dim query As String = "select midLevanta,mSolId,mFechaSolicitud,mFechaEntrega,mEjecutor,mObservaciones,mImagen,mImagenEnProceso,mImagenTerminada,mMapa,mActivo,UsrCre,FecCre,UsrMod,FecMod,mactivo from mLevanta where msolid =" & idsol
        Dim custDA As SqlDataAdapter = New SqlDataAdapter(query, Conn)
        Dim custDS As DataSet = New DataSet()
        custDA.MissingSchemaAction = MissingSchemaAction.AddWithKey
        custDA.Fill(custDS, "levanta")
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

    <WebMethod(Description:="Recaba todas los levantamientos de las solicitudes")>
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json)>
    Public Function GetLevs(pPageSize As Integer, pCurrentPage As Integer, pSortColumn As String, pSortOrder As String, idsol As Integer) As JQGridJsonResponseLev
        Return GetLevJSon(pPageSize, pCurrentPage, pSortColumn, pSortOrder, idsol)
    End Function

    Private Function GetLevJSon(pPageSize As Integer, pPageNumber As Integer, pSortColumn As String, pSorterOrder As String, idsol As Integer) As JQGridJsonResponseLev
        Dim constr As String = ConfigurationManager.ConnectionStrings("cf25").ConnectionString
        Dim dt As DataSet = New DataSet()

        Using con As New SqlConnection(constr)
            Using cmd As New SqlCommand("SP_LevGrid", con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@PageSize", pPageSize)
                cmd.Parameters.AddWithValue("@CurrentPage", pPageNumber)
                cmd.Parameters.AddWithValue("@SortColumn", pSortColumn)
                cmd.Parameters.AddWithValue("@SortOrder", pSorterOrder)
                cmd.Parameters.AddWithValue("@Idsol", idsol)
                cmd.Parameters.AddWithValue("@NoError", 1)
                cmd.Parameters.AddWithValue("@DescError", "ERROR")
                Dim adapt As SqlDataAdapter = New SqlDataAdapter(cmd)


                adapt.Fill(dt)
                Dim levs = New List(Of clsLevanta)
                If Convert.ToInt32(dt.Tables(0).Rows(0)("RecordCount")) > 0 Then
                    For Each row As DataRow In dt.Tables(1).Rows
                        Dim levanta As clsLevanta = New clsLevanta()
                        levanta.IdSol = Convert.ToInt32(row.Item("idsol"))
                        levanta.idLev = Convert.ToInt32(row.Item("midLevanta"))
                        levanta.FechaSol = row.Item("mFechaSolicitud")
                        levanta.FechaEntrega = row.Item("mFechaEntrega")
                        levanta.Ejecutor = row.Item("mEjecutor")
                        levanta.Observa = row.Item("mObservaciones")
                        levanta.Imagen = ValidarDBNull(row.Item("mImagen"))
                        levanta.Mapa = ValidarDBNull(row.Item("mMapa"))
                        levanta.UsrCre = row.Item("UsrCre")
                        levanta.FecCre = row.Item("FecCre")
                        levanta.UsrMod = row.Item("UsrMod")
                        levanta.FecMod = row.Item("FecMod")
                        levs.Add(levanta)
                    Next row

                End If
                Dim objeto As JQGridJsonResponseLev = New JQGridJsonResponseLev
                objeto.JQGridJsonResponseLev(Convert.ToInt32(dt.Tables(0).Rows(0)("PageCount")), Convert.ToInt32(dt.Tables(0).Rows(0)("CurrentPage")), Convert.ToInt32(dt.Tables(0).Rows(0)("RecordCount")), levs)
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