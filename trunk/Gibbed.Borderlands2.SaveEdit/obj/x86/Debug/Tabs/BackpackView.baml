   M S B A M L   `   `   `  ����W  SGibbed.Borderlands2.SaveEdit, Version=1.0.0.0, Culture=neutral, PublicKeyToken=nullK*clr-namespace:Gibbed.Borderlands2.SaveEditGibbed.Borderlands2.SaveEdit  5      /    )Gibbed.Borderlands2.SaveEdit.BackpackView   5      W SPresentationCore, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35R NWindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35\ XPresentationFramework, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35D 9http://schemas.microsoft.com/winfx/2006/xaml/presentation    5      R NSystem.Xaml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     5      Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     5      @d2http://schemas.microsoft.com/expression/blend/2008     5      9se*clr-namespace:Gibbed.Borderlands2.SaveEdit     5      U QCaliburn.Micro, Version=1.3.1.0, Culture=neutral, PublicKeyToken=8e5891231f2ed21f(calhttp://www.caliburnproject.org  5      a ]WPFToolkit.Extended, Version=1.7.4644.13122, Culture=neutral, PublicKeyToken=3e4669d2f30244f44xctk)http://schemas.xceed.com/wpf/xaml/toolkit  5        � 	Resources  5#         SlotCollectionViewSource �� Source �� Path �� GroupDescriptions2  ,System.Windows.Data.PropertyGroupDescription   PropertyName��%w   &	        �� 5$       5%      �� $ Slots� 5&        5'   
   $ DisplayGroup��6#   6A   5)      5*      .��5+      ]� .+�5,      c� -   5        $��	ButtonBar��5,      $	��Top=�5-      .@�5.      �� -   5         ��Name$ 	NewWeapon��5.      .��5/   
   ��  �� Orientation$ 
Horizontal=�6   .+�50      �� $��24��6   $#��..\Resources\assaultrifle.png��51      �� 52      $��
New Weapon��6   53      54   	   �� 55      -   5        $ NewItem��55      .��56   
   �� $ 
Horizontal=�6   .+�57      �� $��24��6   $��..\Resources\shield.png��58      �� 59      $��New Item��6   5:      5;   	   �� 5<      .��6   
Paste Code6   5=      � 5>       � ColumnDefinitions 5?      �� 5@   
   $��0.35* �6   �� 5A   
   $
��Auto �6   �� 5B   
   $��* �6   .+�5D      �� $��0��6   $��Disabled=�5F      ��5E      ��  �� Source# [  	 �� SelectedValue	 5G      �� $ SelectedSlot�
 �� 
GroupStyle
 5H   
   (  "System.Windows.Controls.GroupStyle  5I         HeaderTemplate 5J      �� 5K      .R�5L      �� $��15(�6   $
��Bold"�5M      ��5N      �� $
 Name�5O      5Q      ��5S   
   �� 5T      .R�5U      �� ��6   �� $ DisplayName�5V       � ContextMenu 5X   
   �� 5Y      .@�5Z      m�  m� Icon 5[      �� 5\      $#��..\Resources\assaultrifle.png��6   5^      m� 5_       5`      �� 5a      $#��..\Resources\assaultrifle.png��6   5c      m� 5d       5e      �� 5f      $#��..\Resources\assaultrifle.png��6   5h      5i      5k   	   �� 5l      $��1��6   $��4��5m       �� ResizeBehavior$ PreviousAndNext=�5n      �� 5o      $��2��6   $��Disabled=�5p      $
��Auto=�5q      .��5r   
   �� -   5         ��Name$ SelectedSlot��5r      61   5s   	   5t      5u      5v      