import 'package:flutter/material.dart';
import 'package:flutter_jd_address_selector/flutter_jd_address_selector.dart';

import '../../../generated/i18n.dart';
import '../../../store/index.dart';

import '../../../page_index.dart';
import '../../index.dart';

class CreateEditAddressPage extends StatefulWidget {
  final String title;
  final int id;

  CreateEditAddressPage({Key key, @required this.title, this.id: -1})
      : super(key: key);

  @override
  createState() => _CreateEditAddressPageState();
}

class _CreateEditAddressPageState extends State<CreateEditAddressPage> {
  String _province = '';
  String _city = '';
  String _county = '';
  String _address = '';
  String _name = '';
  String _phone = '';
  String _zipCode = '';

  String area = '请选择';

  bool _isDefault = false;

  String _tag = '';

  List<String> tags = ["家", "公司", "学校", '蜂巢柜'];

  var _nameController = TextEditingController();
  var _phoneController = TextEditingController();
  var _addressController = TextEditingController();
  var _zipCodeController = TextEditingController();

  final _nodeName = FocusNode();
  final _nodePhone = FocusNode();
  final _nodeAddress = FocusNode();
  final _nodeZipCode = FocusNode();

  bool _isClick = false;

  LoaderState _status = LoaderState.NoAction;

  AddressProvider addressProvider;

  @override
  void initState() {
    super.initState();

    addressProvider = AddressProvider();

    _nameController.addListener(_verify);
    _phoneController.addListener(_verify);
    _addressController.addListener(_verify);
    _zipCodeController.addListener(_verify);

    if (widget.id != -1) {
      _status = LoaderState.Loading;
      getAddressData(widget.id);
    }
  }

  void _verify() {
    _name = _nameController.text;
    _address = _addressController.text;
    _zipCode = _zipCodeController.text;
    _phone = _phoneController.text;
    if (_phone.isEmpty || _phone.length < 11) {
      setState(() => _isClick = false);
      return;
    }
    if (_zipCode.isNotEmpty && _zipCode.length < 6) {
      setState(() => _isClick = false);
      return;
    }
    if (_address.isEmpty) {
      setState(() => _isClick = false);
      return;
    }
    if (_name.isEmpty) {
      setState(() => _isClick = false);
      return;
    }
    if (_province.isEmpty ||
        _city.isEmpty ||
        _county.isEmpty ||
        area == '请选择') {
      setState(() => _isClick = false);
      return;
    }

    setState(() => _isClick = true);
  }

  @override
  void dispose() {
    _addressController?.dispose();
    _nameController?.dispose();
    _zipCodeController?.dispose();
    _phoneController?.dispose();
    super.dispose();
  }

  getAddressData(int id) async {
    await addressProvider.getAddress(id).then((address) {
      _tag = address?.tag ?? '';
      _isDefault = address?.isDefault ?? false;

      _province = address?.province ?? '';
      _city = address?.city ?? '';
      _county = address?.county ?? '';
      area = "$_province" + " $_city" + " $_county";
      _addressController.text = address?.address;
      _nameController.text = address?.name;
      _phoneController.text = address?.phone;
      _zipCodeController.text = address?.zipCode;

      _verify();

      setState(() {
        _status = LoaderState.Succeed;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(title: Text('${widget.title}'), elevation: 0),
        body: LoaderContainer(
            loaderState: _status,
            contentView: SafeArea(
              child: Column(children: <Widget>[
                Expanded(child: SingleChildScrollView(child: _buildBody())),
                Padding(
                    padding: const EdgeInsets.only(
                        left: 16.0, right: 16.0, bottom: 8.0),
                    child: Button(
                      onPressed: _isClick ? () => _submit() : null,
                      borderRadius: 0,
                      child: Text('${S.of(context).submit}',
                          style: TextStyle(fontSize: 18)),
                    ))
              ]),
            )));
  }

  Widget _buildBody() {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFieldItem(
                  title: "联  系  人",
                  hintText: "请输入收货人姓名",
                  controller: _nameController,
                  focusNode: _nodeName,
                  maxLength: 4,
                  nextFocusNode: _nodePhone),
              Gaps.line,
              TextFieldItem(
                  title: "联系方式",
                  hintText: "请输入联系人电话",
                  keyboardType: TextInputType.phone,
                  maxLength: 11,
                  controller: _phoneController,
                  focusNode: _nodePhone),
              Gaps.line,
              SelectTextItem(
                  title: '所在地区',
                  content: '$area',
                  margin: EdgeInsets.only(left: 16.0, right: 8),
                  onTap: () => _choiceArea(),
                  textAlign: TextAlign.right),
              Gaps.line,
              TextFieldItem(
                  title: "详细地址",
                  hintText: "请输入详细地址",
                  maxLines: 3,
                  controller: _addressController,
                  focusNode: _nodeAddress,
                  nextFocusNode: _nodeZipCode),
              Gaps.line,
              TextFieldItem(
                  title: "邮政编码",
                  hintText: "请输入邮政编码",
                  keyboardType: TextInputType.number,
                  maxLength: 6,
                  controller: _zipCodeController,
                  focusNode: _nodeZipCode),
              Gaps.line,
              InkWell(
                  child: Container(
                    height: 50,
                    margin: const EdgeInsets.only(left: 16.0, right: 16),
                    width: double.infinity,
                    child: Row(children: <Widget>[
                      Text('默认地址', style: TextStyles.textDark14),
                      Switch(
                          value: _isDefault,
                          onChanged: (value) =>
                              setState(() => _isDefault = value))
                    ], mainAxisAlignment: MainAxisAlignment.spaceBetween),
                  ),
                  onTap: () => setState(() => _isDefault = !_isDefault)),
              Gaps.line,
              Container(
                  height: 50,
                  margin: const EdgeInsets.only(left: 16.0, right: 16),
                  width: double.infinity,
                  child: Row(children: <Widget>[
                    Text('标 \t       签', style: TextStyles.textDark14),
                    Gaps.hGap16,
                    Wrap(
                        spacing: 10,
                        children: tags.map((tag) {
                          return ChoiceChip(
                              selected: _tag == tag,
                              backgroundColor: Colors.grey,
                              label: Text(tag, style: TextStyles.textWhite14),
                              selectedColor: Colors.red,
                              onSelected: (bool isCheck) =>
                                  setState(() => _tag = isCheck ? tag : ""));
                        }).toList())
                  ])),
              Gaps.line
            ]));
  }

  void _choiceArea() async {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return JDAddressDialog(
              onSelected: (province, city, county) {
                setState(() {
                  _province = province;
                  _city = city;
                  _county = county;
                  area = '$province $city $county';
                  _verify();
                });
              },
              title: '选择地区',
              unselectedColor: grey3Color);
        });
  }

  void _submit() async {
    Address address = Address(
        id: widget.id,
        name: _nameController.text,
        phone: _phoneController.text,
        zipCode: _zipCodeController.text ?? '',
        address: _addressController.text,
        tag: _tag,
        isDefault: _isDefault,
        province: _province,
        city: _city,
        county: _county);

    await Store.value<AddressModel>(context, listen: false)
        .insertOrReplaceAddress(context, address, widget.title);
  }
}
