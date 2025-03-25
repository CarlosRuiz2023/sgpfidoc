Imports System.Data
Imports System.Data.SqlClient
Imports System.IO
Imports System.Web.Script.Services
Imports System.Web.Services
Imports Npgsql

' Para permitir que se llame a este servicio web desde un script, usando ASP.NET AJAX, quite la marca de comentario de la línea siguiente.
<System.Web.Script.Services.ScriptService()> _
<WebService(Namespace:="http://tempuri.org/")> _
<WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)> _
<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Public Class WebServiceRolesUsuario
    Inherits System.Web.Services.WebService

    <WebMethod(Description:="Extrae los roles de usuario para enlistarlos en un combo")> _
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json, XmlSerializeString:=True)>
    Public Function GetRolesUsuario(accion As Integer) As String
        Dim constr As String = ConfigurationManager.ConnectionStrings("cf5").ConnectionString
        Dim ds As DataSet = New DataSet()

        Using con As New NpgsqlConnection(constr)
            Using cmd As New NpgsqlCommand("sp_roles_usuario_q", con)
                Dim adapt As NpgsqlDataAdapter = New NpgsqlDataAdapter(cmd)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@accionx", accion)
                adapt.Fill(ds, "rolusu")
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



    <WebMethod(Description:="Extrae los roles de usuario para enlistarlos en un combo")> _
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json, XmlSerializeString:=True)>
    Public Function GetRol(idrol As Integer) As String
        Dim constr As String = ConfigurationManager.ConnectionStrings("cf5").ConnectionString
        Dim ds As DataSet = New DataSet()

        Using con As New NpgsqlConnection(constr)
            Using cmd As New NpgsqlCommand("sp_rol_q", con)
                Dim adapt As NpgsqlDataAdapter = New NpgsqlDataAdapter(cmd)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@idrolx", idrol)
                adapt.Fill(ds, "rol")
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


    <WebMethod(Description:="Recaba todas los documentos de las solicitudes")>
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json)>
    Public Function GetRoles_Grid(pPageSize As Integer, pCurrentPage As Integer, pSortColumn As String, pSortOrder As String, filtro As String) As JQGridJsonResponseRol
        Return GetRoles(pPageSize, pCurrentPage, pSortColumn, pSortOrder, filtro)

    End Function

    Private Function GetRoles(pPageSize As Integer, pPageNumber As Integer, pSortColumn As String, pSorterOrder As String, filtro As String) As JQGridJsonResponseRol
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
            Using cmd As New NpgsqlCommand("public2.sp_rol_grid", con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@PageSize", pPageSize)
                cmd.Parameters.AddWithValue("@CurrentPage", pPageNumber)
                cmd.Parameters.AddWithValue("@SortColumn", pSortColumn)
                cmd.Parameters.AddWithValue("@SortOrder", pSorterOrder)
                cmd.Parameters.AddWithValue("@filtro", filtro)
                Dim adapt As NpgsqlDataAdapter = New NpgsqlDataAdapter(cmd)
                adapt.Fill(dt)
                Dim roles = New List(Of clsRolUsuario)
                Dim intRegsTb As Integer = Convert.ToInt32(dt.Tables(0).Rows(0)("out_recordcount"))
                If (intRegsTb > 0) Then
                    For Each row As DataRow In dt.Tables(0).Rows
                        Dim rol As clsRolUsuario = New clsRolUsuario()
                        rol.crolid = ValidarDBNull(row.Item("out_rolidr"), "entero")
                        rol.croldescripcion = ValidarDBNull(row.Item("out_roldescripcionr"), "cadena")
                        rol.crolnombre = ValidarDBNull(row.Item("out_rolnombrer"), "cadena")
                        rol.crolestatus = ValidarDBNull(row.Item("out_rolestatusr"), "cadena")
                        rol.usrcre = ValidarDBNull(row.Item("out_usucrer"), "cadena")
                        rol.feccre = ValidarDBNull(row.Item("out_feccrer"), "fecha")
                        rol.usumod = ValidarDBNull(row.Item("out_usumodr"), "cadena")
                        rol.fecmod = ValidarDBNull(row.Item("out_fecmodr"), "fecha")
                        roles.Add(rol)
                    Next row
                End If
                pagecount = Convert.ToInt32(dt.Tables(0).Rows(0)("out_pagecount"))
                recordcount = Convert.ToInt32(dt.Tables(0).Rows(0)("out_recordcount"))
                currentpage = Convert.ToInt32(dt.Tables(0).Rows(0)("out_currentpage"))
                Dim objeto As JQGridJsonResponseRol = New JQGridJsonResponseRol
                objeto.JQGridJsonResponseRol(pagecount, currentpage, recordcount, roles)
                Return objeto
            End Using
        End Using
    End Function


    <WebMethod(Description:="Actualizar el registro del documento")> _
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json, XmlSerializeString:=True)>
    Public Function GuardarRol(objRol As clsRolUsuario) As String
        Dim constr As String = ConfigurationManager.ConnectionStrings("cf5").ConnectionString
        Dim idrolr As Integer = 0
        Dim numerror As Integer = 0
        Dim messerror As String = Nothing


        Using con As New NpgsqlConnection(constr)
            Using cmd As New NpgsqlCommand("public2.sp_rol", con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@rolid_in", objRol.crolid)
                cmd.Parameters.AddWithValue("@roldescripcion_in", objRol.croldescripcion)
                cmd.Parameters.AddWithValue("@rolestatus_in", objRol.crolestatus)
                cmd.Parameters.AddWithValue("@rolnombre_in", objRol.crolnombre)
                cmd.Parameters.AddWithValue("@rolusucre_in", objRol.usrcre)
                cmd.Parameters.AddWithValue("@rolfeccre_in", objRol.feccre)
                cmd.Parameters.AddWithValue("@rolusumod_in", objRol.usumod)
                cmd.Parameters.AddWithValue("@rolfecmod_in", objRol.fecmod)
                cmd.Parameters.AddWithValue("@accionx", objRol.accion)

                Dim parIdError As NpgsqlParameter = New NpgsqlParameter("@noerror", NpgsqlTypes.NpgsqlDbType.Integer) ' .Value = 0
                parIdError.Direction = ParameterDirection.Output

                Dim parDesError As NpgsqlParameter = New NpgsqlParameter("@descerror", NpgsqlTypes.NpgsqlDbType.Varchar, 1000) ' .Value = Space(1000)
                parDesError.Direction = ParameterDirection.Output

                Dim paridrol As NpgsqlParameter = New NpgsqlParameter("@idrolr", NpgsqlTypes.NpgsqlDbType.Integer) ' .Value = 0
                paridrol.Direction = ParameterDirection.Output

                cmd.Parameters.Add(parIdError)
                cmd.Parameters.Add(parDesError)
                cmd.Parameters.Add(paridrol)

                cmd.Connection = con
                con.Open()
                cmd.ExecuteNonQuery()

                numerror = cmd.Parameters("@noerror").Value()
                messerror = cmd.Parameters("@descerror").Value()
                idrolr = cmd.Parameters("@idrolr").Value()
                con.Close()
            End Using
        End Using
        Try
            Return "Accion ejecutada correctamente:" & idrolr.ToString
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




