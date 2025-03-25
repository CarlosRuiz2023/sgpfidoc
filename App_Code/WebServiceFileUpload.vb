Imports System.IO
Imports System.Web.Services
Imports Newtonsoft.Json.Linq




' Para permitir que se llame a este servicio web desde un script, usando ASP.NET AJAX, quite la marca de comentario de la línea siguiente.
<System.Web.Script.Services.ScriptService()> _
<WebService(Namespace:="http://tempuri.org/")> _
<WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)> _
<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Public Class WebServiceFileUpload
    Inherits System.Web.Services.WebService

    <WebMethod()> _
    Public Function GuardarArchivo() As Boolean
        If (HttpContext.Current.Request.Files.AllKeys.Any()) Then
            Dim request = HttpContext.Current.Request.Files("UploadedImage")
            Dim parametros = HttpContext.Current.Request.Params("objParametros")
            Dim json As JObject = JObject.Parse(parametros)
            Dim ruta As String
            Dim ruta2 As String
            If request IsNot Nothing Then
                Dim nombre As String = String.Format("{0}", json.Item("nomarchivo"))
                ruta2 = HttpContext.Current.Server.MapPath("..\Admin\temp")
                ruta = "C:\Users\utileria6\Desktop\Compartida\CodigoFuente\pruebas\sgpfidoc_v1\sgpfidoc_v1\Admin\temp\" + nombre
                Dim filePath = Path.Combine(Server.MapPath("~/Admin/temp"), nombre)
                request.SaveAs(ruta)
                Return True
            Else
                Return False
            End If
        Else
            Return False
        End If
    End Function
End Class