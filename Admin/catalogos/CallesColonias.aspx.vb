Imports System.Data

Partial Class Admin_catalogos_CallesColonias
    Inherits System.Web.UI.Page
    
    Public objCalles As New clsCalles
    Public funcion As New funciones
    
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim permisos As DataTable
        Dim AccCons As Integer
        Dim AccAlta As Integer
        
        If Not IsPostBack Then
            If IsNothing(Session("USUARIO")) Then
                Session.Abandon()
                Response.Redirect("~/Default.aspx")
                Exit Sub
            End If
            
            permisos = Lee_Permisos()
            
            AccCons = permisos.Rows(0).Item(2) 'Consultar
            AccAlta = permisos.Rows(0).Item(3) 'Agregar
            'Permiso consultar
            If AccCons = "0" Then
                'MsgBox("NO TIENE PERMISOS PARA ESTA OPCION", MsgBoxStyle.Information)
                Response.Write("<script>alert('NO TIENE PERMISOS PARA ESTA OPCION'); window.location.href='../../inicio.aspx';</script>")
                'Response.Redirect("../../forms/login.aspx")
                Exit Sub
            End If
            
            txtCalle.Attributes.Add("onChange", "return conMayusculas(this);")
            txtColonia.Attributes.Add("onChange", "return conMayusculas(this);")
            txtCalleA.Attributes.Add("onChange", "return conMayusculas(this);")
            'CargarDatos()
        End If
        'CargarDatos()
    End Sub
    
    Private Function Lee_Permisos()
        Dim dt As DataTable
        'Dim cadena As String
        Dim objUsuarioEn As New clsUsuarios
        
        'donde el primer parametro es el usuario y el segundo es la opcion del catalogo de "Usuarios"
        
        dt = objUsuarioEn.GetPermisos(Session("IDUSUARIO"), 6)
        
        'cadena = dt.Rows(0).Item(2)
        
        objUsuarioEn = Nothing
        Return dt
    End Function
    
    Private Sub CargarDatos()
        
    End Sub
    Protected Sub grvCalles_PageIndexChanging(sender As Object, e As System.Web.UI.WebControls.GridViewPageEventArgs) Handles grvCalles.PageIndexChanging
        objCalles.NACCNO = Me.txtCalle.Text
        objCalles.NOMFNO = Me.txtColonia.Text
        objCalles.NANCNO = Me.txtCalleA.Text
        
        grvCalles.DataSource = clsCalles.Consulta(objCalles)
        grvCalles.PageIndex = e.NewPageIndex
        grvCalles.DataBind()
    End Sub
    
    Protected Sub btnBuscar2_Click(sender As Object, e As System.Web.UI.ImageClickEventArgs) Handles btnBuscar2.Click
        objCalles.NACCNO = Me.txtCalle.Text
        objCalles.NOMFNO = Me.txtColonia.Text
        objCalles.NANCNO = Me.txtCalleA.Text
        
        grvCalles.DataSource = clsCalles.Consulta(objCalles)
        grvCalles.DataBind()
    End Sub
    
    Private Sub grvCalles_RowDataBound(sender As Object, e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles grvCalles.RowDataBound
        
        If (e.Row.RowType = DataControlRowType.DataRow) Then
            Dim lnk As LinkButton
            Dim calle As LinkButton
            Dim colonia As Label
            Dim SECFNO As Label
            Dim SSCFNO As Label
            Dim CLACNO As Label
            
            lnk = CType(e.Row.Cells(0).FindControl("calle"), LinkButton)
            calle = CType(e.Row.Cells(0).FindControl("calle"), LinkButton)
            colonia = CType(e.Row.Cells(0).FindControl("colonia"), Label)
            SECFNO = CType(e.Row.Cells(0).FindControl("SECFNO"), Label)
            SSCFNO = CType(e.Row.Cells(0).FindControl("SSCFNO"), Label)
            CLACNO = CType(e.Row.Cells(0).FindControl("CLACNO"), Label)
            
            'calle = CType(e.Row.Cells(0).FindControl("called"), Label)
            'colonia = CType(e.Row.Cells(0).FindControl("coloniad"), Label)
            Dim CALLED As String = calle.Text.Trim
            Dim COLD As String = colonia.Text.Trim
            Dim SECFNO1 As Integer = SECFNO.Text.Trim
            Dim SSCFNO1 As Integer = SSCFNO.Text.Trim
            Dim CLACNO1 As Integer = CLACNO.Text.Trim
            
            'Dim vId As Integer = funcion.LeerRequest("id", Request)
            lnk.Attributes.Add("onmouseover", "this.style.cursor='pointer'")
            lnk.Attributes.Add("onclick", "devolverValor('" & SECFNO1 & "','" & SSCFNO1 & "','" & CLACNO1 & "','" & CALLED & "','" & COLD & "')")
            'lnk.Attributes.Add("onclick", "devolverValor('" & coloniad & "','txtColonia')")
        End If
    End Sub
    
End Class