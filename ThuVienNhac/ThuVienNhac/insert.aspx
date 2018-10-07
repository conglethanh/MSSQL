<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="insert.aspx.cs" Inherits="ThuVienNhac.insert" %>

<%@ Register src="menuUC.ascx" tagname="menuUC" tagprefix="uc1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <uc1:menuUC ID="menuUC1" runat="server" />
        <asp:SqlDataSource ID="SqlDataInsert" runat="server" ConnectionString="<%$ ConnectionStrings:QLNhacConnectionString %>" DeleteCommand="DELETE FROM [baihat] WHERE [ma_baihat] = @ma_baihat" InsertCommand="INSERT INTO [baihat] ([ma_baihat], [ten_baihat], [casi], [ma_theloai]) VALUES (@ma_baihat, @ten_baihat, @casi, @ma_theloai)" SelectCommand="SELECT * FROM [baihat]" UpdateCommand="UPDATE [baihat] SET [ten_baihat] = @ten_baihat, [casi] = @casi, [ma_theloai] = @ma_theloai WHERE [ma_baihat] = @ma_baihat">
            <DeleteParameters>
                <asp:Parameter Name="ma_baihat" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="ma_baihat" Type="Int32" />
                <asp:Parameter Name="ten_baihat" Type="String" />
                <asp:Parameter Name="casi" Type="String" />
                <asp:Parameter Name="ma_theloai" Type="Int32" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="ten_baihat" Type="String" />
                <asp:Parameter Name="casi" Type="String" />
                <asp:Parameter Name="ma_theloai" Type="Int32" />
                <asp:Parameter Name="ma_baihat" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>
        <asp:FormView ID="FormInsert" runat="server" CellPadding="4" DataKeyNames="ma_baihat" DataSourceID="SqlDataInsert" DefaultMode="Insert" ForeColor="#333333" OnItemCommand="FormInsert_ItemCommand" OnItemInserted="FormInsert_ItemInserted" OnPageIndexChanging="FormInsert_PageIndexChanging">
            <EditItemTemplate>
                ma_baihat:
                <asp:Label ID="ma_baihatLabel1" runat="server" Text='<%# Eval("ma_baihat") %>' />
                <br />
                ten_baihat:
                <asp:TextBox ID="ten_baihatTextBox" runat="server" Text='<%# Bind("ten_baihat") %>' />
                <br />
                casi:
                <asp:TextBox ID="casiTextBox" runat="server" Text='<%# Bind("casi") %>' />
                <br />
                ma_theloai:
                <asp:TextBox ID="ma_theloaiTextBox" runat="server" Text='<%# Bind("ma_theloai") %>' />
                <br />
                <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update" Text="Update" />
                &nbsp;<asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
            </EditItemTemplate>
            <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
            <InsertItemTemplate>
                ma_baihat:
                <asp:TextBox ID="ma_baihatTextBox" runat="server" Text='<%# Bind("ma_baihat") %>' />
                <br />
                ten_baihat:
                <asp:TextBox ID="ten_baihatTextBox" runat="server" Text='<%# Bind("ten_baihat") %>' />
                <br />
                casi:
                <asp:TextBox ID="casiTextBox" runat="server" Text='<%# Bind("casi") %>' />
                <br />
                ma_theloai:
                <asp:TextBox ID="ma_theloaiTextBox" runat="server" Text='<%# Bind("ma_theloai") %>' />
                <br />
                <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert" Text="Insert" />
                &nbsp;<asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
            </InsertItemTemplate>
            <ItemTemplate>
                ma_baihat:
                <asp:Label ID="ma_baihatLabel" runat="server" Text='<%# Eval("ma_baihat") %>' />
                <br />
                ten_baihat:
                <asp:Label ID="ten_baihatLabel" runat="server" Text='<%# Bind("ten_baihat") %>' />
                <br />
                casi:
                <asp:Label ID="casiLabel" runat="server" Text='<%# Bind("casi") %>' />
                <br />
                ma_theloai:
                <asp:Label ID="ma_theloaiLabel" runat="server" Text='<%# Bind("ma_theloai") %>' />
                <br />
                <asp:LinkButton ID="EditButton" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit" />
                &nbsp;<asp:LinkButton ID="DeleteButton" runat="server" CausesValidation="False" CommandName="Delete" Text="Delete" />
                &nbsp;<asp:LinkButton ID="NewButton" runat="server" CausesValidation="False" CommandName="New" Text="New" />
            </ItemTemplate>
            <PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
            <RowStyle BackColor="#FFFBD6" ForeColor="#333333" />
        </asp:FormView>
    
    </div>
    </form>
</body>
</html>
