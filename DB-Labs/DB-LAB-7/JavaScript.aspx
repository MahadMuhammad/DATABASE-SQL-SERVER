<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="JavaScript.aspx.cs" Inherits="WebApplication2.JavaScript" %>

<!DOCTYPE html>

<!-- Use the Web form you create and how create Java Script function to convert currency to/from Rs to selected medium

•	Create a JS function that will be called when ‘Convert to RS from selected Medium’ is pressed, it should get the value from 1st text box and convert it to selected medium, and display in 2nd text box.
•	Create a JS function the will be called when Selected medium to Rs is clicked, it should take value from 3rd text box convert it into Rs from selected currency and display in 4th text box.
•	Create a JS function that will be called when Reset button is pressed, it should clear all the text boxes, display the selected currency in 5th text box and you name and roll number in 6th text box. -->


<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<script type="text/javascript">
    function AddTwoNumbers() {
        var num1 = document.getElementById("num1").value;
        var num2 = document.getElementById("num2").value;
        var result = parseInt(num1) + parseInt(num2);
        //if (!isNaN(result)) {
            document.getElementById("result").value = result;
        //}
    }
</script>
<body>
    <form id="form1" runat="server">
    <div>
        <h1>JavaScript</h1>
        <asp:Label ID="Label1" runat="server" Text="Enter First Number"></asp:Label>
        <asp:TextBox ID="num1" runat="server"></asp:TextBox>
        <asp:Label ID="Label2" runat="server" Text="Enter Second Number"></asp:Label>
        <asp:TextBox ID="num2" runat="server"></asp:TextBox>
        <asp:Button ID="Button1" runat="server" Text="Add" OnClientClick="javascript:AddTwoNumbers();" />
        <asp:Label ID="Label3" runat="server" Text="Result"></asp:Label>
        <asp:TextBox ID="result" runat="server"></asp:TextBox>
    </div>


        
    </form>
</body>
</html>
