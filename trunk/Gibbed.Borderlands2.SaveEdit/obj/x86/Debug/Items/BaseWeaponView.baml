   M S B A M L   `   `   `  ����W  SGibbed.Borderlands2.SaveEdit, Version=1.0.0.0, Culture=neutral, PublicKeyToken=nulla5clr-namespace:Gibbed.Borderlands2.SaveEdit.Validators'Gibbed.Borderlands2.SaveEdit.Validators  5      K*clr-namespace:Gibbed.Borderlands2.SaveEditGibbed.Borderlands2.SaveEdit  5      1    +Gibbed.Borderlands2.SaveEdit.BaseWeaponView   5      W SPresentationCore, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35R NWindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35\ XPresentationFramework, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35D 9http://schemas.microsoft.com/winfx/2006/xaml/presentation    5      R NSystem.Xaml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     5      Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     5      @d2http://schemas.microsoft.com/expression/blend/2008     5      a ]WPFToolkit.Extended, Version=1.7.4644.13122, Culture=neutral, PublicKeyToken=3e4669d2f30244f44xctk)http://schemas.xceed.com/wpf/xaml/toolkit  5      =v5clr-namespace:Gibbed.Borderlands2.SaveEdit.Validators  5      3se*clr-namespace:Gibbed.Borderlands2.SaveEdit  5        � 	Resources  5!      ?  9Gibbed.Borderlands2.SaveEdit.ContainsToVisiblityConverter !  ContainsToVisiblityConverter1F  @Gibbed.Borderlands2.SaveEdit.Validators.WeaponTypeValidationRule  TypeValidatorC  =Gibbed.Borderlands2.SaveEdit.Validators.BalanceValidationRule  BalanceValidatorH  BGibbed.Borderlands2.SaveEdit.Validators.ManufacturerValidationRule  ManufacturerValidatorF  @Gibbed.Borderlands2.SaveEdit.Validators.WeaponPartValidationRule  PartValidator��%�   &	        &	      &	 &     &	 9     &	 L       5"      6&     5#      6!     5$      6     5%      6#     5&      6!   5'      .��5(      �  � RowDefinitions 5)      �� 5*      $��29 �6   �� 5+      $
��Auto �6   �� 5,      $
��Auto �6   �� 5-      $
��Auto �6   �� 5.      $
��Auto �6   �� 5/      $
��Auto �6   �� 50      $
��Auto �6   �� 51      $
��Auto �6   �� 52      $
��Auto �6   �� 53      $
��Auto �6   �� 54      $
��Auto �6   �� 55      $
��Auto �6   �� 56      $
��Auto �6   �� 57      $
��Auto �6   �� 58      $
��Auto �6   �� 59      $
��Auto �6   �� 5:      $
��Auto �6   �� 5;      $��* �6    � ColumnDefinitions 5=      �� 5>      $��0.50* �6   �� 5?      $��* �6   .+�5A   
   0   *Gibbed.Borderlands2.SaveEdit.PropertyProxy  	   In 6   �� *AssetLibrarySetId+ �� Mode$ OneWay=� �� UpdateSourceTrigger$ PropertyChanged=�
   Out 5B      ��  �� Source# [  �� Path$ AssetLibrarySetId�  5C   
    6   �� *AssetLibrarySetId+$ OneWay=�$ PropertyChanged=� 5D      �� # [ $ AssetLibrarySetId�  5E   
    6   �� *AssetLibrarySetId+$ OneWay=�$ PropertyChanged=� 5F      �� # [ $ AssetLibrarySetId�  5G   
    6   �� *AssetLibrarySetId+$ OneWay=�$ PropertyChanged=� 5H      �� # [ $ AssetLibrarySetId��� 5I   
   $��0��6   $��0��6   $��Right=�5J      $��Set ID:��5K      �� 5L   
   $��0��6   $��1��6   $
��Left=�5M      ��5N      �� $ AssetLibrarySetId��� 5O   
   $��1��6   $��0��6   $��Right=�5P      $��Type:��5Q      ]� 5R   
   $��1��6   $��1��6!   ��. .+�5T      �� $��Right=�6   $��16��5U      $��2,0,0,0q�5V      $(��"..\Resources\fugue\exclamation.png��5W      	 � ToolTip$9	 3Unsupported value, weapon will probably be deleted.��5X      y�5Y   
   `� 5Z      
 `� 	Converter#
 [  6   .1�5[      ��  �� ElementName$ TypeDefinitionComboBox��6   $ ItemsSource�5\      $ OneWay=�5]      �� 5^      $ TypeDefinitionComboBox��6   $
 Text�5_      $ OneWay=�5`      5a      5c   	   -  'Gibbed.Borderlands2.SaveEdit.MyComboBox  5d      -   5          Name$ TypeDefinitionComboBox��5d       �� 
IsEditable . ��5f      �� $ 
TypeAssets� �� Text 5g   
   �� 5h      $ TypeDefinition�6    �� ValidationRules 5i      �� 5j       �� ResourceKey$ TypeValidator��6   5l      5n   	   5o      �� 5p      $��2��6   $��0��5q      $��Right=�5r      $��Balance:��5s      ]� 5t      $��2��6   $��1��5u      ��. .+�5w      �� $��Right=�6   $��16��5x      $��2,0,0,0q�5y      $(��"..\Resources\fugue\exclamation.png��5z      $9	 3Unsupported value, weapon will probably be deleted.��5{      y�5|   
   `� 5}      #
 [  6   .1�5~      �� $ BalanceDefinitionComboBox��6   $ ItemsSource�5      $ OneWay=�5�      �� 5�      $ BalanceDefinitionComboBox��6   $
 Text�5�      $ OneWay=�5�      5�      5�   	     5�      -   5        $ BalanceDefinitionComboBox��5�       . ��5�      �� $ BalanceAssets� 5�   
   �� 5�      $ BalanceDefinition�6    5�      �� 5�      $ BalanceValidator��6   5�      5�   	   5�      �� 5�      $��3��6   $��0��5�      $��Right=�5�      $��Manufacturer:��5�      ]� 5�      $��3��6   $��1��5�      ��. .+�5�      �� $��Right=�6   $��16��5�      $��2,0,0,0q�5�      $(��"..\Resources\fugue\exclamation.png��5�      $9	 3Unsupported value, weapon will probably be deleted.��5�      y�5�   
   `� 5�      #
 [  6   .1�5�      �� $$ ManufacturerDefinitionComboBox��6   $ ItemsSource�5�      $ OneWay=�5�      �� 5�      $$ ManufacturerDefinitionComboBox��6   $
 Text�5�      $ OneWay=�5�      5�      5�   	     5�      -   5        $$ ManufacturerDefinitionComboBox��5�       .  5�   
   �� 5�      $ ManufacturerDefinition�6    5�      �� 5�      $ ManufacturerValidator��6   5�      5�   	   5�      �� 5�      $��4��6   $��0��5�      $��Right=�5�      $��Manufacturer Grade:��5�      %  Xceed.Wpf.Toolkit.IntegerUpDown  5�      $��4��6   $��1��5�      �	  �Xceed.Wpf.Toolkit.NumericUpDown`1[[System.Nullable`1[[System.Int32, mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089]], mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089]] 	  Minimum$ 0X�5�       	  Maximum$	 127X�5�      �
  �Xceed.Wpf.Toolkit.Primitives.UpDownBase`1[[System.Nullable`1[[System.Int32, mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089]], mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089]] 
  Value 5�      �� $ ManufacturerGradeIndex�5�      �� 5�      $��5��6   $��0��5�      $��Right=�5�      $��Body:��5�      ]� 5�      $��5��6   $��1��5�      ��. .+�5�      �� $��Right=�6   $��16��5�      $��2,0,0,0q�5�      $(��"..\Resources\fugue\exclamation.png��5�      $9	 3Unsupported value, weapon will probably be deleted.��5�      y�5�   
   `� 5�      #
 [  6   .1�5�      �� $  BodyPartDefinitionComboBox��6   $ ItemsSource�5�      $ OneWay=�5�      �� 5�      $  BodyPartDefinitionComboBox��6   $
 Text�5�      $ OneWay=�5�      5�      5�   	     5�      -   5        $  BodyPartDefinitionComboBox��5�       . ��5�      �� $ BodyPartAssets� 5�   
   �� 5�      $ BodyPartDefinition�6    5�      �� 5�      $ PartValidator��6   5�      5�   	   5�      �� 5�      $��6��6   $��0��5�      $��Right=�5�      $��Grip:��5�      ]� 5�      $��6��6   $��1��5�      ��. .+�5�      �� $��Right=�6   $��16��5�      $��2,0,0,0q�5�      $(��"..\Resources\fugue\exclamation.png��5�      $9	 3Unsupported value, weapon will probably be deleted.��5�      y�5�   
   `� 5�      #
 [  6   .1�5�      �� $  GripPartDefinitionComboBox��6   $ ItemsSource�5�      $ OneWay=�5�      �� 5�      $  GripPartDefinitionComboBox��6   $
 Text�5�      $ OneWay=�5�      5�      5�   	     5�      -   5        $  GripPartDefinitionComboBox��5�       . ��5�      �� $ GripPartAssets� 5�   
   �� 5�      $ GripPartDefinition�6    5�      �� 5�      $ PartValidator��6   5     5  	   5     �� 5     $��7��6   $��0��5     $��Right=�5     $��Barrel:��5     ]� 5	     $��7��6   $��1��5
     ��. .+�5     �� $��Right=�6   $��16��5     $��2,0,0,0q�5     $(��"..\Resources\fugue\exclamation.png��5     $9	 3Unsupported value, weapon will probably be deleted.��5     y�5  
   `� 5     #
 [  6   .1�5     �� $" BarrelPartDefinitionComboBox��6   $ ItemsSource�5     $ OneWay=�5     �� 5     $" BarrelPartDefinitionComboBox��6   $
 Text�5     $ OneWay=�5     5     5  	     5     -   5        $" BarrelPartDefinitionComboBox��5      . ��5     �� $ BarrelPartAssets� 5  
   �� 5      $ BarrelPartDefinition�6    5!     �� 5"     $ PartValidator��6   5$     5&  	   5'     �� 5(     $��8��6   $��0��5)     $��Right=�5*     $��Sight:��5+     ]� 5,     $��8��6   $��1��5-     ��. .+�5/     �� $��Right=�6   $��16��50     $��2,0,0,0q�51     $(��"..\Resources\fugue\exclamation.png��52     $9	 3Unsupported value, weapon will probably be deleted.��53     y�54  
   `� 55     #
 [  6   .1�56     �� $! SightPartDefinitionComboBox��6   $ ItemsSource�57     $ OneWay=�58     �� 59     $! SightPartDefinitionComboBox��6   $
 Text�5:     $ OneWay=�5;     5<     5>  	     5?     -   5        $! SightPartDefinitionComboBox��5?      . ��5A     �� $ SightPartAssets� 5B  
   �� 5C     $ SightPartDefinition�6    5D     �� 5E     $ PartValidator��6   5G     5I  	   5J     �� 5K     $��9��6   $��0��5L     $��Right=�5M     $��Stock:��5N     ]� 5O     $��9��6   $��1��5P     ��. .+�5R     �� $��Right=�6   $��16��5S     $��2,0,0,0q�5T     $(��"..\Resources\fugue\exclamation.png��5U     $9	 3Unsupported value, weapon will probably be deleted.��5V     y�5W  
   `� 5X     #
 [  6   .1�5Y     �� $! StockPartDefinitionComboBox��6   $ ItemsSource�5Z     $ OneWay=�5[     �� 5\     $! StockPartDefinitionComboBox��6   $
 Text�5]     $ OneWay=�5^     5_     5a  	     5b     -   5        $! StockPartDefinitionComboBox��5b      . ��5d     �� $ StockPartAssets� 5e  
   �� 5f     $ StockPartDefinition�6    5g     �� 5h     $ PartValidator��6   5j     5l  	   5m     �� 5n     $��10��6   $��0��5o     $��Right=�5p     $��
Elemental:��5q     ]� 5r     $��10��6   $��1��5s     ��. .+�5u     �� $��Right=�6   $��16��5v     $��2,0,0,0q�5w     $(��"..\Resources\fugue\exclamation.png��5x     $9	 3Unsupported value, weapon will probably be deleted.��5y     y�5z  
   `� 5{     #
 [  6   .1�5|     �� $% ElementalPartDefinitionComboBox��6   $ ItemsSource�5}     $ OneWay=�5~     �� 5     $% ElementalPartDefinitionComboBox��6   $
 Text�5�     $ OneWay=�5�     5�     5�  	     5�     -	   5        $% ElementalPartDefinitionComboBox��5�      . ��5�     �� $ ElementalPartAssets� 5�  
   �� 5�     $ ElementalPartDefinition�6    5�     �� 5�     $ PartValidator��6   5�     5�  	   5�     �� 5�     $��11��6   $��0��5�     $��Right=�5�     $��Accessory #1:��5�     ]� 5�     $��11��6   $��1��5�     ��. .+�5�     �� $��Right=�6   $��16��5�     $��2,0,0,0q�5�     $(��"..\Resources\fugue\exclamation.png��5�     $9	 3Unsupported value, weapon will probably be deleted.��5�     y�5�  
   `� 5�     #
 [  6   .1�5�     �� $&  Accessory1PartDefinitionComboBox��6   $ ItemsSource�5�     $ OneWay=�5�     �� 5�     $&  Accessory1PartDefinitionComboBox��6   $
 Text�5�     $ OneWay=�5�     5�     5�  	     5�     -
   5        $&  Accessory1PartDefinitionComboBox��5�      . ��5�     �� $ Accessory1PartAssets� 5�  
   �� 5�     $ Accessory1PartDefinition�6    5�     �� 5�     $ PartValidator��6   5�     5�  	   5�     �� 5�     $��12��6   $��0��5�     $��Right=�5�     $��Accessory #2:��5�     ]� 5�     $��12��6   $��1��5�     ��. .+�5�     �� $��Right=�6   $��16��5�     $��2,0,0,0q�5�     $(��"..\Resources\fugue\exclamation.png��5�     $9	 3Unsupported value, weapon will probably be deleted.��5�     y�5�  
   `� 5�     #
 [  6   .1�5�     �� $&  Accessory2PartDefinitionComboBox��6   $ ItemsSource�5�     $ OneWay=�5�     �� 5�     $&  Accessory2PartDefinitionComboBox��6   $
 Text�5�     $ OneWay=�5�     5�     5�  	     5�     -   5        $&  Accessory2PartDefinitionComboBox��5�      . ��5�     �� $ Accessory2PartAssets� 5�  
   �� 5�     $ Accessory2PartDefinition�6    5�     �� 5�     $ PartValidator��6   5�     5�  	   5�     �� 5�     $��13��6   $��0��5�     $��Right=�5�     $��	Material:��5�     ]� 5�     $��13��6   $��1��5�     ��. .+�5�     �� $��Right=�6   $��16��5�     $��2,0,0,0q�5�     $(��"..\Resources\fugue\exclamation.png��5�     $9	 3Unsupported value, weapon will probably be deleted.��5�     y�5�  
   `� 5�     #
 [  6   .1�5�     �� $$ MaterialPartDefinitionComboBox��6   $ ItemsSource�5�     $ OneWay=�5�     �� 5�     $$ MaterialPartDefinitionComboBox��6   $
 Text�5�     $ OneWay=�5�     5�     5�  	     5�     -   5        $$ MaterialPartDefinitionComboBox��5�      . ��5�     �� $ MaterialPartAssets� 5�  
   �� 5�     $ MaterialPartDefinition�6    5�     �� 5�     $ PartValidator��6   5�     5�  	   5�     �� 5�     $��14��6   $��0��5�     $��Right=�5�     $��Prefix:��5�     ]� 5�     $��14��6   $��1��5�     ��. .+�5     �� $��Right=�6   $��16��5     $��2,0,0,0q�5     $(��"..\Resources\fugue\exclamation.png��5     $9	 3Unsupported value, weapon will probably be deleted.��5     y�5  
   `� 5     #
 [  6   .1�5     �� $" PrefixPartDefinitionComboBox��6   $ ItemsSource�5	     $ OneWay=�5
     �� 5     $" PrefixPartDefinitionComboBox��6   $
 Text�5     $ OneWay=�5     5     5  	     5     -   5        $" PrefixPartDefinitionComboBox��5      .  5  
   �� 5     $ PrefixPartDefinition�6    5     �� 5     $ PartValidator��6   5     5  	   5     �� 5     $��15��6   $��0��5     $��Right=�5     $��Title:��5     ]� 5      $��15��6   $��1��5!     ��. .+�5#     �� $��Right=�6   $��16��5$     $��2,0,0,0q�5%     $(��"..\Resources\fugue\exclamation.png��5&     $9	 3Unsupported value, weapon will probably be deleted.��5'     y�5(  
   `� 5)     #
 [  6   .1�5*     �� $! TitlePartDefinitionComboBox��6   $ ItemsSource�5+     $ OneWay=�5,     �� 5-     $! TitlePartDefinitionComboBox��6   $
 Text�5.     $ OneWay=�5/     50     52  	     53     -   5        $! TitlePartDefinitionComboBox��53      .  55  
   �� 56     $ TitlePartDefinition�6    57     �� 58     $ PartValidator��6   5:     5<  	   5=     �� 5>     $��16��6   $��0��5?     $��Right=�5@     $��Game Stage:��5A       5B     $��16��6   $��1��5C     $ 0X�5E     $	 127X�5F      5D     �� $ 	GameStage�5F     5G     5H     