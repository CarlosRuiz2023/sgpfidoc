Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.Script.Services
Imports System.Web.Services
Imports Npgsql

<System.Web.Script.Services.ScriptService()> _
<WebService(Namespace:="http://tempuri.org/")> _
<WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)> _
<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Public Class WebServiceCV
    Inherits System.Web.Services.WebService


    <WebMethod(Description:="Inserta CV en SQLServer")> _
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json, XmlSerializeString:=True)>
    Public Function InsertarCV_SqlS(objfiletxt As clsfiletxt, idusu As String) As String
        Dim constr As String = ConfigurationManager.ConnectionStrings("cf25").ConnectionString

        Dim numerror As Integer = 0
        Dim messerror As String = Nothing

        Using con As New SqlConnection(constr)
            Using cmd As New SqlCommand("dbo.ActualizarCV", con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@contenidotxt_in", objfiletxt.contenido)
                cmd.Parameters.AddWithValue("@idusu_in", idusu)

                Dim parIdError As SqlParameter = New SqlParameter("@DescError", SqlDbType.VarChar, 1000)
                parIdError.Direction = ParameterDirection.Output
                Dim parDesError As SqlParameter = New SqlParameter("@NoError", SqlDbType.Int) ' .Value = Space(1000)
                parDesError.Direction = ParameterDirection.Output


                cmd.Parameters.Add(parIdError)
                cmd.Parameters.Add(parDesError)


                cmd.Connection = con
                con.Open()
                cmd.ExecuteNonQuery()

                numerror = ValidarDBNull(cmd.Parameters("@NoError").Value())
                messerror = ValidarDBNull(cmd.Parameters("@DescError").Value())

                con.Close()
            End Using
        End Using
        Try
            Return "Registro de CV guardado"
        Catch ex As Exception
            Return "Error " & ex.Message
        End Try
    End Function


    <WebMethod(Description:="INSERTA MOVIMIENTOS A DESDE EL EXTERIOR A LA TABLA DE MOVIMIENTOS")> _
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json, XmlSerializeString:=True)>
    Public Function InsertarMovsFinancCV(objfiletxt As clsfiletxt, idusu As Integer) As String
        Dim constr As String = ConfigurationManager.ConnectionStrings("cf5").ConnectionString

        Dim numerror As Integer = 0
        Dim messerror As String = Nothing

        Using con As New NpgsqlConnection(constr)
            Using cmd As New NpgsqlCommand("public3.sp_inserta_movs_cv", con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@contenidotxt", objfiletxt.contenido)
                cmd.Parameters.AddWithValue("@idusu", idusu)



                Dim parIdError As NpgsqlParameter = New NpgsqlParameter("@noerror", NpgsqlTypes.NpgsqlDbType.Integer, 36)
                parIdError.Direction = ParameterDirection.Output
                Dim parDesError As NpgsqlParameter = New NpgsqlParameter("@descerror", NpgsqlTypes.NpgsqlDbType.Varchar, 255) ' .Value = Space(1000)
                parDesError.Direction = ParameterDirection.Output


                cmd.Parameters.Add(parIdError)
                cmd.Parameters.Add(parDesError)


                cmd.Connection = con
                con.Open()
                cmd.ExecuteNonQuery()

                numerror = ValidarDBNull(cmd.Parameters("@noerror").Value())
                messerror = ValidarDBNull(cmd.Parameters("@descerror").Value())

                con.Close()
            End Using
        End Using
        Try
            Return "Registro de Documento guardado "
        Catch ex As Exception
            Return "Error " & ex.Message
        End Try
    End Function


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


End Class