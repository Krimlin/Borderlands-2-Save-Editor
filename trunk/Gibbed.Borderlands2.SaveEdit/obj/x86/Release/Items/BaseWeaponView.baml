   M S B A M L   `   `   `  ���� W  SGibbed.Borderlands2.SaveEdit, Version=1.0.0.0, Culture=neutral, PublicKeyToken=nulla5clr-namespace:Gibbed.Borderlands2.SaveEdit.Validators'Gibbed.Borderlands2.SaveEdit.Validators  K*clr-namespace:Gibbed.Borderlands2.SaveEditGibbed.Borderlands2.SaveEdit  1    +Gibbed.Borderlands2.SaveEdit.BaseWeaponView   W SPresentationCore, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35R NWindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35\ XPresentationFramework, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35D 9http://schemas.microsoft.com/winfx/2006/xaml/presentation    R NSystem.Xaml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     @d2http://schemas.microsoft.com/expression/blend/2008     a ]WPFToolkit.Extended, Version=1.7.4644.13122, Culture=neutral, PublicKeyToken=3e4669d2f30244f44xctk)http://schemas.xceed.com/wpf/xaml/toolkit  =v5clr-namespace:Gibbed.Borderlands2.SaveEdit.Validators  3se*clr-namespace:Gibbed.Borderlands2.SaveEdit    � 	Resources  ?  9Gibbed.Borderlands2.SaveEdit.ContainsToVisiblityConverter !  ContainsToVisiblityConverter1F  @Gibbed.Borderlands2.SaveEdit.Validators.WeaponTypeValidationRule  TypeValidatorC  =Gibbed.Borderlands2.SaveEdit.Validators.BalanceValidationRule  BalanceValidatorH  BGibbed.Borderlands2.SaveEdit.Validators.ManufacturerValidationRule  ManufacturerValidatorF  @Gibbed.Borderlands2.SaveEdit.Validators.WeaponPartValidationRule  PartValidator��%K   &	        &	      &	 
     &	      &	                .���  � RowDefinitions �� $��29 ��� $
��Auto ��� $
��Auto ��� $
��Auto ��� $
��Auto ��� $
��Auto ��� $
��Auto ��� $
��Auto ��� $
��Auto ��� $
��Auto ��� $
��Auto ��� $
��Auto ��� $
��Auto ��� $
��Auto ��� $
��Auto ��� $
��Auto ��� $
��Auto ��� $��* � � ColumnDefinitions �� $��0.50* ��� $��* �.+�0   *Gibbed.Borderlands2.SaveEdit.PropertyProxy  	   In �� *AssetLibrarySetId+ �� Mode$ OneWay=� �� UpdateSourceTrigger$ PropertyChanged=�
   Out ��  �� Source# [  �� Path$ AssetLibrarySetId�   �� *AssetLibrarySetId+$ OneWay=�$ PropertyChanged=� �� # [ $ AssetLibrarySetId�   �� *AssetLibrarySetId+$ OneWay=�$ PropertyChanged=� �� # [ $ AssetLibrarySetId�   �� *AssetLibrarySetId+$ OneWay=�$ PropertyChanged=� �� # [ $ AssetLibrarySetId��� $��0��$��0��$��Right=�$��Set ID:���� $��0��$��1��$
��Left=����� $ AssetLibrarySetId��� $��1��$��0��$��Right=�$��Type:��]� $��1��$��1����. .+��� $��Right=�$��16��$��2,0,0,0q�$(��"..\Resources\fugue\exclamation.png��	 � ToolTip$9	 3Unsupported value, weapon will probably be deleted.��y�`� 
 `� 	Converter#
 [  .1���  �� ElementName$ TypeComboBox��$ ItemsSource�$ OneWay=��� $ TypeComboBox��$
 Text�$ OneWay=�-  'Gibbed.Borderlands2.SaveEdit.MyComboBox  -     Name$ TypeComboBox�� �� 
IsEditable . ���� $ 
TypeAssets� �� Text �� $
 Type�$ PropertyChanged=� �� ValidationRules ��  �� ResourceKey$ TypeValidator���� $��2��$��0��$��Right=�$��Balance:��]� $��2��$��1����. .+��� $��Right=�$��16��$��2,0,0,0q�$(��"..\Resources\fugue\exclamation.png��$9	 3Unsupported value, weapon will probably be deleted.��y�`� #
 [  .1��� $ BalanceComboBox��$ ItemsSource�$ OneWay=��� $ BalanceComboBox��$
 Text�$ OneWay=�  -   $ BalanceComboBox�� . ���� $ BalanceAssets� �� $ Balance�$ PropertyChanged=� �� $ BalanceValidator���� $��3��$��0��$��Right=�$��Manufacturer:��]� $��3��$��1����. .+�  -   $ ManufacturerComboBox�� . ���� $ ManufacturerAssets� �� $ Manufacturer�$ PropertyChanged=� �� $ ManufacturerValidator���� $��4��$��0��$��Right=�$��Manufacturer Grade:��%  Xceed.Wpf.Toolkit.IntegerUpDown  $��4��$��1���	  �Xceed.Wpf.Toolkit.NumericUpDown`1[[System.Nullable`1[[System.Int32, mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089]], mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089]] 	  Minimum$ 0X� 	  Maximum$	 127X��
  �Xceed.Wpf.Toolkit.Primitives.UpDownBase`1[[System.Nullable`1[[System.Int32, mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089]], mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089]] 
  Value �� $ ManufacturerGradeIndex�$ PropertyChanged=��� $��5��$��0��$��Right=�$��Body:��]� $��5��$��1����. .+��� $��Right=�$��16��$��2,0,0,0q�$(��"..\Resources\fugue\exclamation.png��$9	 3Unsupported value, weapon will probably be deleted.��y�`� #
 [  .1��� $ BodyPartComboBox��$ ItemsSource�$ OneWay=��� $ BodyPartComboBox��$
 Text�$ OneWay=�  -   $ BodyPartComboBox�� . ���� $ BodyPartAssets� �� $ BodyPart�$ PropertyChanged=� �� $ PartValidator���� $��6��$��0��$��Right=�$��Grip:��]� $��6��$��1����. .+��� $��Right=�$��16��$��2,0,0,0q�$(��"..\Resources\fugue\exclamation.png��$9	 3Unsupported value, weapon will probably be deleted.��y�`� #
 [  .1��� $ GripPartComboBox��$ ItemsSource�$ OneWay=��� $ GripPartComboBox��$
 Text�$ OneWay=�  -   $ GripPartComboBox�� . ���� $ GripPartAssets� �� $ GripPart�$ PropertyChanged=� �� $ PartValidator���� $��7��$��0��$��Right=�$��Barrel:��]� $��7��$��1����. .+��� $��Right=�$��16��$��2,0,0,0q�$(��"..\Resources\fugue\exclamation.png��$9	 3Unsupported value, weapon will probably be deleted.��y�`� #
 [  .1��� $ BarrelPartComboBox��$ ItemsSource�$ OneWay=��� $ BarrelPartComboBox��$
 Text�$ OneWay=�  -   $ BarrelPartComboBox�� . ���� $ BarrelPartAssets� �� $ 
BarrelPart�$ PropertyChanged=� �� $ PartValidator���� $��8��$��0��$��Right=�$��Sight:��]� $��8��$��1����. .+��� $��Right=�$��16��$��2,0,0,0q�$(��"..\Resources\fugue\exclamation.png��$9	 3Unsupported value, weapon will probably be deleted.��y�`� #
 [  .1��� $ SightPartComboBox��$ ItemsSource�$ OneWay=��� $ SightPartComboBox��$
 Text�$ OneWay=�  -   $ SightPartComboBox�� . ���� $ SightPartAssets� �� $ 	SightPart�$ PropertyChanged=� �� $ PartValidator���� $��9��$��0��$��Right=�$��Stock:��]� $��9��$��1����. .+��� $��Right=�$��16��$��2,0,0,0q�$(��"..\Resources\fugue\exclamation.png��$9	 3Unsupported value, weapon will probably be deleted.��y�`� #
 [  .1��� $ StockPartComboBox��$ ItemsSource�$ OneWay=��� $ StockPartComboBox��$
 Text�$ OneWay=�  -   $ StockPartComboBox�� . ���� $ StockPartAssets� �� $ 	StockPart�$ PropertyChanged=� �� $ PartValidator���� $��10��$��0��$��Right=�$��
Elemental:��]� $��10��$��1����. .+��� $��Right=�$��16��$��2,0,0,0q�$(��"..\Resources\fugue\exclamation.png��$9	 3Unsupported value, weapon will probably be deleted.��y�`� #
 [  .1��� $ ElementalPartComboBox��$ ItemsSource�$ OneWay=��� $ ElementalPartComboBox��$
 Text�$ OneWay=�  -	   $ ElementalPartComboBox�� . ���� $ ElementalPartAssets� �� $ ElementalPart�$ PropertyChanged=� �� $ PartValidator���� $��11��$��0��$��Right=�$��Accessory #1:��]� $��11��$��1����. .+��� $��Right=�$��16��$��2,0,0,0q�$(��"..\Resources\fugue\exclamation.png��$9	 3Unsupported value, weapon will probably be deleted.��y�`� #
 [  .1��� $ Accessory1PartComboBox��$ ItemsSource�$ OneWay=��� $ Accessory1PartComboBox��$
 Text�$ OneWay=�  -
   $ Accessory1PartComboBox�� . ���� $ Accessory1PartAssets� �� $ Accessory1Part�$ PropertyChanged=� �� $ PartValidator���� $��12��$��0��$��Right=�$��Accessory #2:��]� $��12��$��1����. .+��� $��Right=�$��16��$��2,0,0,0q�$(��"..\Resources\fugue\exclamation.png��$9	 3Unsupported value, weapon will probably be deleted.��y�`� #
 [  .1��� $ Accessory2PartComboBox��$ ItemsSource�$ OneWay=��� $ Accessory2PartComboBox��$
 Text�$ OneWay=�  -   $ Accessory2PartComboBox�� . ���� $ Accessory2PartAssets� �� $ Accessory2Part�$ PropertyChanged=� �� $ PartValidator���� $��13��$��0��$��Right=�$��	Material:��]� $��13��$��1����. .+��� $��Right=�$��16��$��2,0,0,0q�$(��"..\Resources\fugue\exclamation.png��$9	 3Unsupported value, weapon will probably be deleted.��y�`� #
 [  .1��� $ MaterialPartComboBox��$ ItemsSource�$ OneWay=��� $ MaterialPartComboBox��$
 Text�$ OneWay=�  -   $ MaterialPartComboBox�� . ���� $ MaterialPartAssets� �� $ MaterialPart�$ PropertyChanged=� �� $ PartValidator���� $��14��$��0��$��Right=�$��Prefix:��]� $��14��$��1����. .+�  -   $ PrefixPartComboBox�� .  �� $ 
PrefixPart�$ PropertyChanged=� �� $ PartValidator���� $��15��$��0��$��Right=�$��Title:��]� $��15��$��1����. .+�  -   $ TitlePartComboBox�� .  �� $ 	TitlePart�$ PropertyChanged=� �� $ PartValidator���� $��16��$��0��$��Right=�$��Game Stage:��  $��16��$��1��$ 0X�$	 127X� �� $ 	GameStage�$ PropertyChanged=�