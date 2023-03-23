<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CSS-EXERCISE.aspx.cs" Inherits="WebApplication2.CSS_EXERCISE" %>

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
    function ConvertToRS() {
        var num1 = document.getElementById("num1").value;
        var num2 = document.getElementById("num2").value;
        var result = parseInt(num1) + parseInt(num2);
        //if (!isNaN(result)) {
            document.getElementById("result").value = result;
        //}
    }

    function ConvertToSelectedMedium() {
        var num1 = document.getElementById("num1").value;
        var num2 = document.getElementById("num2").value;
        var result = parseInt(num1) + parseInt(num2);
        //if (!isNaN(result)) {
            document.getElementById("result").value = result;
        //}
    }

    function Reset() {
        var num1 = document.getElementById("num1").value;
        var num2 = document.getElementById("num2").value;
        var result = parseInt(num1) + parseInt(num2);
        //if (!isNaN(result)) {
            document.getElementById("result").value = result;
        //}
    }

</script>


<!-- CSS code goes here -->
<style>  
    /* This is class selector */
    body{
        font-family: Arial, Helvetica, sans-serif;
        background-color: #f1f1f1;
        border-color: #04AA6D;
        font-size: 50px;
        color: white;
    }

    #submit{
        /* This is id selector */
        background-color: #4CAF50;
        /* make border blue bold; */
        border: 5000px solid blue;
        color: white;
        padding: 16px 20px;
        border-color: yellow;
        margin: 10px 0;
        border: red;
        /* Make border dark blue; */
        cursor: pointer;
        width: 30%;
    }

    .buttonCSS{
        height: 50px;
        background-color: #4CAF50;
        /* make border blue bold; */
        border: 5000px solid blue;
        border-color: blue;
        color: white;
        border-color: #04AA6D;
        padding: 16px 20px;
        margin: 8px 0;
        border: none;
        cursor: pointer;
        width: 25%;
    }
    .border-3px {
        border-color: black;
        font-size: 20px;
        color: #4CAF50;
    border-width: 3px;
    }

    h1{
        font-size: 55px;
        font-style: Times New Roman;
        color: blue;
    }

    h2{
        font-size: 18px;
        color: purple;
    }
    text{
        font-size: 15px;
        color: purple;
    }
</style>

<body>
    <form id="form1" runat="server">
        <div>

            <h1>Currency Converting Web Site</h1>
            <br/>
        </div>
        <div>

            <text>Select Currency Medium</text>
            <!-- drop down -->
            <asp:DropDownList ID="DropDownList1" runat="server" CssClass="buttonCSS">
                <asp:ListItem>Select</asp:ListItem>
                <asp:ListItem>EURO</asp:ListItem>
                <asp:ListItem>YEN</asp:ListItem>
                <asp:ListItem>POUND</asp:ListItem>
                </asp:DropDownList>

            <br/>

            <text>
                Please Enter amount in Rupees to convert to your Selected Medium:
            </text>

            <!-- calling the function ConvertToSelectedMedium() when button is clicked -->
            <asp:Button ID="Button1" runat="server" Text="Convert selected medium to rupees" CssClass="buttonCSS" OnClientClick = "javascript:ConvertToSelectedMedium();" />
            <br/>

            <asp:Button ID="Button2" runat="server" Text="Convert rupees to selected medium" CssClass="buttonCSS" />

            <br/>
            <br/>

            <text>Amount from Rupees to your chosen medium</text>
            <asp:Button ID="Button9" runat="server" Text="Button 1" CssClass="buttonCSS" />

            <br/>
            
            <text>Please enter amount in your chosen medium to convert to Rupees.</text>
            <asp:Button ID="submit" runat="server" Text="Button 3" CssClass="buttonCSS" />

            <br/>

            <text>Amount from your chosen medium to Rupees: </text>
            <!-- Calling the function ConvertToRS() when button is clicked -->
            <asp:Button ID="Button3" runat="server" Text="Button 2" CssClass="buttonCSS" OnClientClick = "javascript:ConvertToRS();" />

            <br/>

            <text>Your Previous Chosen medium was : </text>
            <asp:Button ID="submit5" runat="server" Text="Rupees" CssClass="buttonCSS" />
            
            <br/>

            <text>Programmed by : </text>
            <asp:Button ID="submit10" runat="server" Text="Muhammad Mahad, 21L-6195" CssClass="buttonCSS" />
            
            <br/>
            <br/>
            <!-- Reset button with red border -->
            <asp:Button ID="Button4" runat="server" Text="Reset" CssClass="buttonCSS" OnClientClick = "javascript:Reset();" />
        </div>

        
    </form>
</body>     



</html>
