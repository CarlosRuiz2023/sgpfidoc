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
Public Class WebServiceConvenio
    Inherits System.Web.Services.WebService


    Private Function ValidarDBNull(objParametro As Object) As Object
        Dim tipo_objeto = objParametro.GetType
        If IsDBNull(objParametro.ToString) Then
            ValidarDBNull = ""
        Else
            If objParametro.ToString = "" Then
                If tipo_objeto.Name = "Date" Then
                    ValidarDBNull = "01/01/1900"
                End If
                If tipo_objeto.Name = "Integer" Or tipo_objeto.Name = "Double" Then
                    ValidarDBNull = 0
                End If
                If tipo_objeto.Name = "String" Then
                    ValidarDBNull = ""
                End If
            Else
                ValidarDBNull = objParametro.ToString
            End If
        End If

    End Function


    <WebMethod(Description:="Actualizar el registro del documento")> _
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json, XmlSerializeString:=True)>
    Public Function ActConvenio(objConv As clsConvenio) As String
        Dim constr As String = ConfigurationManager.ConnectionStrings("cf5").ConnectionString
        Dim idconv As Integer = 0
        Dim numerror As Integer = 0
        Dim messerror As String = Nothing


        Using con As New NpgsqlConnection(constr)
            Using cmd As New NpgsqlCommand("sp_convenio", con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@idconvr", objConv.idConv)
                cmd.Parameters.AddWithValue("@fidr", objConv.fid)
                cmd.Parameters.AddWithValue("@fecconvr", objConv.fecconv)
                cmd.Parameters.AddWithValue("@factoractconvr", objConv.factoractconv)
                cmd.Parameters.AddWithValue("@recargosconvr", objConv.recargosconv)
                cmd.Parameters.AddWithValue("@desctorecargosconvr", objConv.desctorecargosconv)
                cmd.Parameters.AddWithValue("@saldoact2r", objConv.saldoact2)
                cmd.Parameters.AddWithValue("@recargoporconvenior", objConv.recargoporconvenio)
                cmd.Parameters.AddWithValue("@fechavencconvr", objConv.fechavencconv)
                cmd.Parameters.AddWithValue("@numpagosr", objConv.numpagos)
                cmd.Parameters.AddWithValue("@saldoconvr", objConv.saldoconv)
                cmd.Parameters.AddWithValue("@pagosconvr", objConv.pagosconv)
                cmd.Parameters.AddWithValue("@estatusconvr", objConv.estatusconv)
                cmd.Parameters.AddWithValue("@archivoconvr", objConv.archivoconv)
                cmd.Parameters.AddWithValue("@usucrer", objConv.usucre)
                cmd.Parameters.AddWithValue("@accion", objConv.accion)
                Dim parIdError As NpgsqlParameter = New NpgsqlParameter("@NoError", NpgsqlTypes.NpgsqlDbType.Integer) ' .Value = 0
                parIdError.Direction = ParameterDirection.Output

                Dim parDesError As NpgsqlParameter = New NpgsqlParameter("@DescError", NpgsqlTypes.NpgsqlDbType.Varchar, 1000) ' .Value = Space(1000)
                parDesError.Direction = ParameterDirection.Output

                Dim pariddcto As NpgsqlParameter = New NpgsqlParameter("@idconvy", NpgsqlTypes.NpgsqlDbType.Integer) ' .Value = 0
                pariddcto.Direction = ParameterDirection.Output

                cmd.Parameters.Add(parIdError)
                cmd.Parameters.Add(parDesError)
                cmd.Parameters.Add(pariddcto)

                cmd.Connection = con
                con.Open()
                cmd.ExecuteNonQuery()

                numerror = cmd.Parameters("@noerror").Value()
                messerror = cmd.Parameters("@descerror").Value()
                idconv = cmd.Parameters("@idconvy").Value()

                con.Close()
            End Using
        End Using
        Try
            If numerror > 0 Then
                Return messerror & ":0"
            Else
                Return "Accion ejecutada correctamente:" & idconv.ToString
            End If
        Catch ex As SqlException
            Return ex.Message & "No.Error:" & numerror.ToString() & "Mensaje error:" & messerror
        End Try
    End Function

End Class



