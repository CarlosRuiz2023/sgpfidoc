Imports System.Data
Imports System.Data.SqlClient
Partial Class Admin_catalogos_ModulosAB
    Inherits System.Web.UI.Page
    
    Public objUsuarioEN As New clsUsuarios
    Public conexion As New clsConexion
    Public funcion As New funciones
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            If Not IsNothing(Session("USUARIO")) Then
                
            Else
                Session.Abandon()
                Response.Redirect("~/Default.aspx")
            End If
            CargarDatos()
        End If
        
    End Sub
    Private Sub CargarDatos()
        'grvRoles.DataSource = clsUsuarios.Consulta_Roles(objUsuarioEN)
        'grvRoles.DataBind()
        
        Dim vId As Integer = funcion.LeerRequest("id", Request)
        'Me.txtEmpleado.Text = vId
        
        If vId <> 0 Then
            objUsuarioEN.IdMod = vId
            
            Dim dt As DataTable
            dt = clsUsuarios.Consulta_Modulo(objUsuarioEN)
            
            Me.txtModulo.Text = dt.Rows(0).Item(1)
            Me.txtDescripcion.Text = dt.Rows(0).Item(2)
            
            'txtEmpleado.DataBind()
            
            Me.lblCapturo.Text = dt.Rows(0).Item("UsrCre")
            Me.lblFecCap.Text = dt.Rows(0).Item("FecCre")
            Me.lblModifico.Text = dt.Rows(0).Item("UsrMod")
            Me.lblFecMod.Text = dt.Rows(0).Item("FecMod")
        End If
    End Sub
    Protected Sub btnGuardar_Click(sender As Object, e As EventArgs) Handles btnGuardar.Click
        Dim myTrans As SqlTransaction
        
        Dim Comando As SqlClient.SqlCommand
        
        Dim ban As Integer = 0
        Dim vId As Integer = funcion.LeerRequest("id", Request)
        
        Dim dt As DataTable
        dt = clsUsuarios.Consulta_Roles(objUsuarioEN)
        
        conexion.Conectar()
        
        Dim i As Integer = dt.Rows.Count - 1
        
        Try
        objUsuarioEN.ModTxt = txtModulo.Text
        objUsuarioEN.ModDesc = txtDescripcion.Text
        
        Dim dtu As DataTable
        objUsuarioEN.Accion = "Consulta"
        Dim u As Integer = Session("USUARIO")
        objUsuarioEN.IdUsuario = u
        dtu = clsUsuarios.Consulta_Usuarios(objUsuarioEN)
        
        If vId <> 0 Then
            objUsuarioEN.IdMod = vId
            objUsuarioEN.UsuMod = dtu.Rows(0).Item(2)
            objUsuarioEN.Accion = "Actualizar"
        Else
            objUsuarioEN.IdMod = 0
            objUsuarioEN.UsuCre = dtu.Rows(0).Item(2)
            objUsuarioEN.Accion = "Insertar"
        End If
        
        If objUsuarioEN.Accion = "Insertar" Then
            myTrans = conexion.oConexion.BeginTransaction()
            Comando = New SqlClient.SqlCommand("INSERT INTO cModulos (cModNombre, cModDesc,UsrCre,FecCre) Values('" & objUsuarioEN.ModTxt & "','" & objUsuarioEN.ModDesc & "','" & objUsuarioEN.UsuMod & "',GETDATE()) ", conexion.oConexion)
            Comando.Transaction = myTrans
            Comando.ExecuteNonQuery()
            
            Comando = New SqlClient.SqlCommand("Select SCOPE_IDENTITY()", conexion.oConexion)
            Comando.Transaction = myTrans
            Comando.ExecuteNonQuery()
            
            Dim id As Integer = Convert.ToInt32(Comando.ExecuteScalar())
            
            'Comando = New SqlClient.SqlCommand("SELECT MAX(cModId) FROM cModulos", conexion.oConexion)
            'Comando.Transaction = myTrans
            'Comando.ExecuteNonQuery()
            
            For x = 0 To i
                Dim d As Integer = dt.Rows(x).Item(0)
                Comando = New SqlClient.SqlCommand("INSERT INTO mPermisos (mRolId,mModId,mAccCons,mAccAlta,mAccBaja,mAccMod,mAccAdmon) Values(" & d & "," & id & ",0,0,0,0,0)", conexion.oConexion)
                Comando.Transaction = myTrans
                Comando.ExecuteNonQuery()
            Next
            myTrans.Commit()
            
        Else
            ban = clsUsuarios.InsertarModulo(objUsuarioEN)
        End If
        
        'ban = clsUsuarios.InsertarModulo(objUsuarioEN)
        'If ban >= 0 Then
        Dim script As String = "<script type='text/javascript'>" & _
            "window.opener.location.reload(true); window.close();" & _
            "</script>"
        ScriptManager.RegisterStartupScript(Me, GetType(Page), "alerta", script, False)
        'Else
        '    MsgBox(strMensajeError)
        '    strMensajeError = ""
        'End If
        
        Catch ex1 As SqlException
        lblError.Text = "Ha ocurrido un error.  Datos no guardados" & ex1.Message
        Catch ex2 As Exception
        lblError.Text = "Ha ocurrido un error.  Datos no guardados" & ex2.Message
        End Try
        
    End Sub
End Class