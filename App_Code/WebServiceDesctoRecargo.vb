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
Public Class WebServiceDesctoRecargo
    Inherits System.Web.Services.WebService

    <WebMethod(Description:="Actualizar el registro del documento")> _
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json, XmlSerializeString:=True)>
    Public Function ActDescto(objDescto As clsDesctoRec) As String
        Dim constr As String = ConfigurationManager.ConnectionStrings("cf5").ConnectionString
        Dim mensaje As String = Nothing
        Dim numerror As Integer = 0
        Dim messerror As String = Nothing


        Using con As New NpgsqlConnection(constr)
            Using cmd As New NpgsqlCommand("sp_descto_rec", con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@fidx", objDescto.fid)
                cmd.Parameters.AddWithValue("@pidx", objDescto.pid)
                cmd.Parameters.AddWithValue("@oidx", objDescto.oid)
                cmd.Parameters.AddWithValue("@obrasifidocx", objDescto.obrasifidoc)
                cmd.Parameters.AddWithValue("@foliopagox", objDescto.folio_pago)
                cmd.Parameters.AddWithValue("@porcentajedesctox", objDescto.porcentaje_descto)
                cmd.Parameters.AddWithValue("@montosaldopagarx", objDescto.monto_saldo_pagar)
                cmd.Parameters.AddWithValue("@montodesctox", objDescto.monto_descto)
                cmd.Parameters.AddWithValue("@factoractpagox", objDescto.factor_act_pago)
                cmd.Parameters.AddWithValue("@fecaplicdesctox", objDescto.fec_aplic_descto)
                cmd.Parameters.AddWithValue("@fecofrecedesctox", objDescto.fec_ofrece_descto)
                cmd.Parameters.AddWithValue("@recargospagadosx", objDescto.recargos_pagados)
                cmd.Parameters.AddWithValue("@recargosinicialesx", objDescto.recargos_iniciales)
                cmd.Parameters.AddWithValue("@fecmovas400x", objDescto.fec_mov_as400)
                cmd.Parameters.AddWithValue("@feclimpagox ", objDescto.fec_lim_pago)
                cmd.Parameters.AddWithValue("@usuariox", objDescto.usuario)
                cmd.Parameters.AddWithValue("@estatus_descto", objDescto.estatus_descto)
                cmd.Parameters.AddWithValue("@accion", objDescto.accion)

                Dim parIdError As NpgsqlParameter = New NpgsqlParameter("@NoError", NpgsqlTypes.NpgsqlDbType.Integer) ' .Value = 0
                parIdError.Direction = ParameterDirection.Output

                Dim parDesError As NpgsqlParameter = New NpgsqlParameter("@DescError", NpgsqlTypes.NpgsqlDbType.Varchar, 1000) ' .Value = Space(1000)
                parDesError.Direction = ParameterDirection.Output

                Dim parmensaje As NpgsqlParameter = New NpgsqlParameter("@mensaje", NpgsqlTypes.NpgsqlDbType.Varchar, 1000) ' .Value = 0
                parmensaje.Direction = ParameterDirection.Output

                cmd.Parameters.Add(parIdError)
                cmd.Parameters.Add(parDesError)
                cmd.Parameters.Add(parmensaje)

                cmd.Connection = con
                con.Open()
                cmd.ExecuteNonQuery()

                numerror = cmd.Parameters("@NoError").Value()
                messerror = cmd.Parameters("@DescError").Value()
                mensaje = cmd.Parameters("@mensaje").Value()
                con.Close()
            End Using
        End Using
        Try
            Return "Accion ejecutada correctamente:" & mensaje.ToString
        Catch ex As SqlException
            Return ex.Message & "No.Error:" & numerror.ToString() & "Mensaje error:" & messerror
        End Try
    End Function

End Class