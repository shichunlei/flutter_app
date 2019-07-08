import 'package:flutter/material.dart';
import 'package:flutter_app/baixing_life/db/address_provider.dart';
import 'package:flutter_app/bean/address.dart';
import 'package:flutter_app/store/models/address_model.dart';
import 'package:flutter_app/ui/select_text_item.dart';
import 'package:flutter_jd_address_selector/flutter_jd_address_selector.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

import '../../../page_index.dart';

class CreateEditAddressPage extends StatefulWidget {
  final String title;
  final int id;
  final AddressProvider addressProvider;

  CreateEditAddressPage(
      {Key key, @required this.title, this.id, @required this.addressProvider})
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
  String _zipcode = '';

  String area = '请选择';

  bool _isDefault = false;

  String _tag = '';

  List<String> tags = ["家", "公司", "学校"];

  Address address;

  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _zipcodeController = TextEditingController();

  final FocusNode _nodeName = FocusNode();
  final FocusNode _nodePhone = FocusNode();
  final FocusNode _nodeAddress = FocusNode();
  final FocusNode _nodeZipcode = FocusNode();

  bool _isClick = false;

  @override
  void initState() {
    super.initState();

    _nameController.addListener(_verify);
    _phoneController.addListener(_verify);
    _addressController.addListener(_verify);
    _zipcodeController.addListener(_verify);

    if (widget.id != null) {
      getAddressData(widget.id);
    }
  }

  void _verify() {
    _name = _nameController.text;
    _address = _addressController.text;
    _zipcode = _zipcodeController.text;
    _phone = _phoneController.text;
    if (_phone.isEmpty || _phone.length < 11) {
      setState(() => _isClick = false);
      return;
    }
    if (_zipcode.isNotEmpty && _zipcode.length < 6) {
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
    if (area.isEmpty || area == '请选择') {
      setState(() => _isClick = false);
      return;
    }

    setState(() => _isClick = true);
  }

  @override
  void dispose() {
    _addressController?.dispose();
    _nameController?.dispose();
    _zipcodeController?.dispose();
    _phoneController?.dispose();
    super.dispose();
  }

  void getAddressData(int id) async {
    address = await widget.addressProvider.getAddress(id);

    _tag = address?.tag;
    _isDefault = address?.isDefault;

    _province = address?.province;
    _city = address?.city;
    _county = address?.county;
    area = '$_province $_city $_county';
    _address = _addressController.text = address?.address;
    _name = _nameController.text = address?.name;
    _phone = _phoneController.text = address?.phone;
    _zipcode = _zipcodeController.text = address?.zipcode;
    _verify();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(title: Text('${widget.title}'), elevation: 0),
        body: SafeArea(
          child: Column(children: <Widget>[
            Expanded(
                child: Utils.isIOS
                    ? FormKeyboardActions(child: _buildBody())
                    : SingleChildScrollView(child: _buildBody())),
            Padding(
                padding:
                    const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 8.0),
                child: Button(
                    onPressed: _isClick ? () => _submit() : null,
                    text: "${AppLocalizations.$t('submit')}",
                    borderRadius: 0))
          ]),
        ));
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
                  onTap: () => _choiceArea(),
                  textAlign: TextAlign.right),
              Gaps.line,
              TextFieldItem(
                  title: "详细地址",
                  hintText: "请输入详细地址",
                  maxLines: 3,
                  controller: _addressController,
                  focusNode: _nodeAddress,
                  nextFocusNode: _nodeZipcode),
              Gaps.line,
              TextFieldItem(
                  title: "邮政编码",
                  hintText: "请输入邮政编码",
                  keyboardType: TextInputType.number,
                  maxLength: 6,
                  controller: _zipcodeController,
                  focusNode: _nodeZipcode),
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
                    Text('标        签', style: TextStyles.textDark14),
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
              unselectedColor: Color(0xFF333333));
        });
  }

  void _submit() async {
    Address address = Address(
        id: widget.id,
        name: _nameController.text,
        phone: _phoneController.text,
        zipcode: _zipcodeController.text ?? '',
        address: _addressController.text,
        tag: _tag,
        isDefault: _isDefault,
        province: _province,
        city: _city,
        county: _county);

    int success = await widget.addressProvider.insertOrReplaceToDB(address);

    if (success > 0) {
      Toast.show('${widget.title}${AppLocalizations.$t('success')}！', context);

      Store.value<AddressModel>(context)
          .$changeAddresses(widget.addressProvider);
      Navigator.of(context).pop();
    } else {
      Toast.show('${widget.title}${AppLocalizations.$t('fail')}！', context);
    }
  }
}
