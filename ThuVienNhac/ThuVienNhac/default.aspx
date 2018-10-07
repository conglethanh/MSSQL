<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="ThuVienNhac._default" %>

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
        <br />
        Thể loại:
        <asp:DropDownList ID="ddl_theloai" runat="server" DataSourceID="dataSourceTheLoai" DataTextField="ten_theloai" DataValueField="ma_theloai" Width="123px">
        </asp:DropDownList>
        <asp:Button ID="btnXemBaiHat" runat="server" OnClick="btnXemBaiHat_Click" Text="Xem" />
        <br />
        <div style="margin-left:auto;margin-right:auto">
                    <asp:GridView ID="grid_danhsachBaihat" runat="server" CellPadding="4"  ForeColor="#333333" GridLines="None" Height="219px" OnSelectedIndexChanged="grid_danhsachBaihat_SelectedIndexChanged" style="text-align: justify" Width="636px" OnRowCancelingEdit="grid_danhsachBaihat_RowCancelingEdit" OnRowCommand="grid_danhsachBaihat_RowCommand" OnRowDeleting="grid_danhsachBaihat_RowDeleting" OnRowEditing="grid_danhsachBaihat_RowEditing" OnRowUpdating="grid_danhsachBaihat_RowUpdating">
            <AlternatingRowStyle BackColor="White" />
            <Columns>
                <asp:CommandField ShowSelectButton="True" />
                <asp:CommandField ShowDeleteButton="True" />
            </Columns>
            <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White"  HorizontalAlign="Center"/>
            <PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
            <RowStyle BackColor="#FFFBD6" ForeColor="#333333" HorizontalAlign="Center"/>
            <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
            <SortedAscendingCellStyle BackColor="#FDF5AC" />
            <SortedAscendingHeaderStyle BackColor="#4D0000" />
            <SortedDescendingCellStyle BackColor="#FCF6C0" />
            <SortedDescendingHeaderStyle BackColor="#820000" />
        </asp:GridView>
                    <asp:TextBox ID="txtMaBH" runat="server" OnTextChanged="TextBox1_TextChanged" Visible="False"></asp:TextBox>
                    <asp:TextBox ID="txtTenBH" runat="server" OnTextChanged="TextBox1_TextChanged" Visible="False"></asp:TextBox>
                    <asp:TextBox ID="txtCaSi" runat="server" OnTextChanged="TextBox1_TextChanged" Visible="False"></asp:TextBox>
                    <br />
                    &nbsp;<asp:HyperLink ID="hl_insert" runat="server" Visible="False" NavigateUrl="~/insert.aspx">Insert</asp:HyperLink>
                    &nbsp;</div>

        <asp:Button ID="btnedit" runat="server" OnClick="btnedit_Click" Text="Edit" />

        <br />
    
    </div>
        <asp:SqlDataSource ID="dataSourceTheLoai" runat="server" ConnectionString="<%$ ConnectionStrings:QLNhacConnectionString %>" SelectCommand="SELECT * FROM [theloai]"></asp:SqlDataSource>
    </form>
</body>
</html>
