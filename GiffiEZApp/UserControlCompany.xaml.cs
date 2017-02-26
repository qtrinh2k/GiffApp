using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;


namespace GiffiEZApp
{
    /// <summary>
    /// Interaction logic for UserControlCompany.xaml
    /// </summary>
    public partial class UserControlCompany : UserControl
    {
        public static readonly DependencyProperty CompanyInfoProperty;

        static UserControlCompany()
        {
            UserControlCompany.CompanyInfoProperty = DependencyProperty.Register("CompanyAddressProperty", typeof(Grid), typeof(UserControlCompany));
        }

        public Grid CompanyAddressProperty
        {
            get;
            set;
        }
        public UserControlCompany()
        {
            InitializeComponent();
        }
    }
}
