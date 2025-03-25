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
Public Class WebServicePAE
    Inherits System.Web.Services.WebService


    <WebMethod(Description:="Actualizar el registro del documento")> _
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json, XmlSerializeString:=True)>
    Public Function RegistraPAE(objGestionPAE As clsDocPAE, accion As Integer, idusu As Integer) As String
        Dim constr As String = ConfigurationManager.ConnectionStrings("cf5").ConnectionString
        Dim iddoc As Integer = 0
        Dim numerror As Integer = 0
        Dim messerror As String = Nothing


        Using con As New NpgsqlConnection(constr)
            Using cmd As New NpgsqlCommand("public3.sp_pae", con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@iddet_in", objGestionPAE.iddoc)
                cmd.Parameters.AddWithValue("@fec_imp_doc_in", objGestionPAE.fec_imp_doc)
                cmd.Parameters.AddWithValue("@fec_ent_doc_in", objGestionPAE.fec_ent_doc)
                cmd.Parameters.AddWithValue("@fec_notific_doc_in", objGestionPAE.fec_notific_doc)
                cmd.Parameters.AddWithValue("@idministro_in", objGestionPAE.idministro)
                cmd.Parameters.AddWithValue("@estatus_doc_in", objGestionPAE.estatus_doc)
                cmd.Parameters.AddWithValue("@img_doc_firma_in", objGestionPAE.img_doc_firma)
                cmd.Parameters.AddWithValue("@obra_coop_s_in", objGestionPAE.obra_coop_s)
                cmd.Parameters.AddWithValue("@fid_in", objGestionPAE.fid)
                cmd.Parameters.AddWithValue("@tipo_doc_in", objGestionPAE.tipo_doc)
                cmd.Parameters.AddWithValue("@idusu_in", idusu)
                cmd.Parameters.AddWithValue("@accion", accion)


                Dim parIdError As NpgsqlParameter = New NpgsqlParameter("@noerror", NpgsqlTypes.NpgsqlDbType.Integer) ' .Value = 0
                parIdError.Direction = ParameterDirection.Output

                Dim parDesError As NpgsqlParameter = New NpgsqlParameter("@descerror", NpgsqlTypes.NpgsqlDbType.Varchar, 1000) ' .Value = Space(1000)
                parDesError.Direction = ParameterDirection.Output

                Dim pariddoc As NpgsqlParameter = New NpgsqlParameter("@iddoc_out", NpgsqlTypes.NpgsqlDbType.Integer) ' .Value = 0
                pariddoc.Direction = ParameterDirection.Output

                cmd.Parameters.Add(parIdError)
                cmd.Parameters.Add(parDesError)
                cmd.Parameters.Add(pariddoc)

                cmd.Connection = con
                con.Open()
                cmd.ExecuteNonQuery()

                numerror = cmd.Parameters("@noerror").Value()
                messerror = cmd.Parameters("@descerror").Value()
                iddoc = cmd.Parameters("@iddoc_out").Value()
                con.Close()
            End Using
        End Using
        Try
            Return "Accion ejecutada correctamente:" & iddoc.ToString
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