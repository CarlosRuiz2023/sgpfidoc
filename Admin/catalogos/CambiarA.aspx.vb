Imports System.Data.SqlClient
Imports System.Data

Partial Class Admin_catalogos_CambiarA
    Inherits System.Web.UI.Page

    Public funcion As New funciones
    Dim strMensajeError As Object

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            If Not IsNothing(Session("USUARIO")) Then

            Else
                Session.Abandon()
                Response.Redirect("~/login.aspx")
            End If
        End If
        btnGuardar.Attributes.Add("onmouseover", "this.style.cursor='pointer'")
    End Sub

    Protected Sub btnGuardar_Click(sender As Object, e As EventArgs) Handles btnGuardar.Click
        Dim dt As DataTable
        'Dim cadena As String
        Dim objUsuarioEn As New clsUsuarios

        Dim actual As Integer = Me.txtActual.Text
        objUsuarioEn.IdUsuario = Session("IDUSUARIO")

        lblError.Text = ""
        Try
            dt = clsUsuarios.Consulta_Usuarios(objUsuarioEn)
            Dim actual2 As String = dt.Rows(0).Item(11)

            If actual2 = funcion.Encriptar(actual) Then
                objUsuarioEn.Pass = funcion.Encriptar(Me.txtPass.Text)
                objUsuarioEn.Accion = "ActPass"
                Dim ban As Integer = clsUsuarios.Insertar(objUsuarioEn)
                If ban >= 0 Then
                    'Limpiar()
                    lblComentario.Text = "Contraseña actualizada"
                Else
                    MsgBox(strMensajeError)
                    strMensajeError = ""
                End If
            Else
                lblError.Text = "Contraseña actual no es correcta"
                txtActual.Focus()
            End If

        Catch ex1 As SqlException
            lblError.Text = "Ha ocurrido un error.  Datos no guardados  " & ex1.Message
        Catch ex2 As Exception
            lblError.Text = "Ha ocurrido un error.  Datos no guardados  " & ex2.Message
        End Try
    End Sub
End Class
