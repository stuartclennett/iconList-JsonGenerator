object Form15: TForm15
  Left = 0
  Top = 0
  Caption = 'HTML Img Tag Generator for Icons'
  ClientHeight = 501
  ClientWidth = 1026
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    1026
    501)
  PixelsPerInch = 96
  TextHeight = 13
  object edtFolder: TEdit
    Left = 8
    Top = 16
    Width = 273
    Height = 21
    TabOrder = 0
    Text = 'Z:\VM_Shared_Folder\icon'
  end
  object Button1: TButton
    Left = 359
    Top = 14
    Width = 75
    Height = 25
    Caption = 'Create'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Memo1: TMemo
    Left = 8
    Top = 45
    Width = 426
    Height = 448
    Anchors = [akLeft, akTop, akBottom]
    Lines.Strings = (
      'Memo1')
    TabOrder = 2
    WordWrap = False
  end
  object edtMask: TEdit
    Left = 287
    Top = 16
    Width = 66
    Height = 21
    TabOrder = 3
    Text = '.png'
  end
  object edtClassname: TEdit
    Left = 897
    Top = 17
    Width = 121
    Height = 22
    Anchors = [akTop, akRight]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    Text = 'mt-2 ml-2'
  end
  object Memo2: TMemo
    Left = 440
    Top = 45
    Width = 578
    Height = 448
    Anchors = [akLeft, akTop, akRight, akBottom]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = []
    Lines.Strings = (
      'Memo2')
    ParentFont = False
    TabOrder = 5
    WordWrap = False
  end
end
