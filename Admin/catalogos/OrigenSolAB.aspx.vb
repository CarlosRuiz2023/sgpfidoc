Imports System.Data
Imports System.Data.SqlClient

Partial Class Admin_catalogos_OrigenSolAB
    Inherits System.Web.UI.Page

    Public objUsuarioEN As New clsUsuarios
    Public objOrigen As New clsOrigen
    Public conexion As New clsConexion
    Public funcion As New funciones
    Dim strMensajeError As String

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            If Not IsNothing(Session("USUARIO")) Then

            Else
                Session.Abandon()
                Response.Redirect("~/Default.aspx")
            End If
            CargarDatos()

        End If
        txtOrigen.Attributes.Add("onChange", "return conMayusculas(this);")
    End Sub

    Private Sub CargarDatos()
        'grvRoles.DataSource = clsUsuarios.Consulta_Roles(objUsuarioEN)
        'grvRoles.DataBind()

        Dim vId As Integer = funcion.LeerRequest("id", Request)
        'Me.txtEmpleado.Text = vId

        If vId <> 0 Then
            objOrigen.IdOrigen = vId

            Dim dt As DataTable = New DataTable
            objOrigen.Accion = "Buscar"
            Dim ban As Boolean = clsOrigen.Consulta(objOrigen, dt)
            Me.txtOrigen.Text = dt.Rows(0).Item(1)
            'txtEmpleado.DataBind()
            If IsDBNull(dt.Rows(0).Item("cActivo")) Then
                Me.chkactivo.Checked = False
            ElseIf dt.Rows(0).Item("cActivo") = 1 Then
                Me.chkactivo.Checked = True
            ElseIf dt.Rows(0).Item("cActivo") = 0 Then
                Me.chkactivo.Checked = False
            End If

            Me.lblCapturo.Text = dt.Rows(0).Item("UsrCre")
            Me.lblFecCap.Text = dt.Rows(0).Item("FecCre")
            Me.lblModifico.Text = dt.Rows(0).Item("UsrMod")
            Me.lblFecMod.Text = dt.Rows(0).Item("FecMod")
        End If
    End Sub
    Protected Sub btnGuardar_Click(sender As Object, e As EventArgs) Handles btnGuardar.Click
        Dim ban As Integer = 0
        Dim vId As Integer = funcion.LeerRequest("id", Request)

        Dim dt As DataTable = New DataTable

        objOrigen.Accion = "Todos"
        Dim bande As Boolean = clsOrigen.Consulta(objOrigen, dt)

        Try
            Dim dtu As DataTable
            objOrigen.Accion = "Consulta"
            Dim u As Integer = Session("USUARIO")
            objUsuarioEN.IdUsuario = u
            dtu = clsUsuarios.Consulta_Usuarios(objUsuarioEN)

            objOrigen.Nombre = Me.txtOrigen.Text
            If chkactivo.Checked = True Then
                objOrigen.Activo = 1
            Else
                objOrigen.Activo = 0
            End If

            If vId <> 0 Then
                objOrigen.IdOrigen = vId
                objOrigen.UsuMod = dtu.Rows(0).Item(2)
                objOrigen.Accion = "Actualizar"
            Else
                objOrigen.IdOrigen = 0
                objOrigen.UsuCre = dtu.Rows(0).Item(2)
                objOrigen.Accion = "Insertar"
            End If

            ban = clsOrigen.Insertar(objOrigen)
            If ban >= 0 Then
                Dim script As String = "<script type='text/javascript'>" & _
                                        "window.opener.location.reload(true); window.close();" & _
                                    "</script>"

                ScriptManager.RegisterStartupScript(Me, GetType(Page), "alerta", script, False)
            Else
                MsgBox(strMensajeError)
                strMensajeError = ""
            End If

        Catch ex1 As SqlException
            lblError.Text = "Ha ocurrido un error.  Datos no guardados" & ex1.Message
        Catch ex2 As Exception
            lblError.Text = "Ha ocurrido un error.  Datos no guardados" & ex2.Message
        End Try
    End Sub
End Class
