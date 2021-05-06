import 'package:flutter/material.dart';
import 'package:should_have_bought_app/screens/main/example/login_background.dart';

class Example extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Stack(
        alignment: Alignment.center,
        children: <Widget>[
          CustomPaint(
            size: size,
            //TODO: provider사용해서 색상변경필요
            painter: LoginBackground(isJoin: true),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              _logoImage,
              Stack(
                children: <Widget>[
                  _inputForm(size),
                  _authButton(size),
//                  Container(width:200, height: 200, color:Colors.amber,),
//                  Container(width:100, height: 50, color:Colors.black,),
                ],
              ),
              Container(
                height: size.height * 0.1,
              ),
              GestureDetector(
                  onTap: (){
                    //JoinOrLogin joinOrLogin= Provider.of<JoinOrLogin>(context , listen: false);
                    //joinOrLogin.toggle();
                  },
                  child: Text("Don't Have an Account? Create One",
                    style: TextStyle(color: Colors.red),
                  )
              ),
              Container(
                height: size.height * 0.05,
              )
            ],
          ),
        ],
    );
  }

  Widget _inputForm(Size size) => Padding(
    padding: EdgeInsets.all(size.width * 0.05),
    child: Card(
      shape:
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 6,
      child: Padding(
        padding:
        const EdgeInsets.only(left: 12, right: 12, top: 16, bottom: 32),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                    icon: Icon(Icons.account_circle), labelText: 'Email'),
                validator: (String value) {
                  if (value.isEmpty) {
                    return "Please input correct Email.";
                  }
                  return null;
                },
              ),
              Container(
                height: 12,
              ),
              TextFormField(
                obscureText: true,
                controller: _passwordController,
                decoration: InputDecoration(
                    icon: Icon(Icons.vpn_key), labelText: 'Password'),
                validator: (String value) {
                  if (value.isEmpty) {
                    return "Please input correct Password.";
                  }
                  return null;
                },
              ),
              Container(
                height: 16,
              ),
              Opacity(
                  opacity:1,
                  child:Text("Forgot Password"),
                ),
            ],
          ),
        ),
      ),
    ),
  );


  Widget _authButton(Size size) => Positioned(
    left: size.width * 0.15,
    right: size.width * 0.15,
    bottom: 0,
    child: ButtonTheme(
        height: 50,
        child: RaisedButton(
            child: Text("Join", style: TextStyle(fontSize: 20, color: Colors.white)),
            color: Colors.red,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            onPressed: () {
            })
        )
  );

  void _register(BuildContext context) async {
    // final UserCredential result = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _emailController.text, password: _passwordController.text);
    // final User user = result.user;
    //
    // if(user == null){
    //   final snacBar = SnackBar(content: Text('Pleaset try again later.'),);
    //   Scaffold.of(context).showSnackBar(snacBar);
    // }
    //
    // Navigator.push(context, MaterialPageRoute(builder: (context)=>MainPage(email:user.email)));
  }

  void _login(BuildContext context) async {
    // final UserCredential result = await FirebaseAuth.instance.signInWithEmailAndPassword(email: _emailController.text, password: _passwordController.text);
    // final User user = result.user;
    //
    // if(user == null){
    //   final snacBar = SnackBar(content: Text('Pleaset try again later.'),);
    //   Scaffold.of(context).showSnackBar(snacBar);
    // }
    //
    // Navigator.push(context, MaterialPageRoute(builder: (context)=>MainPage(email:user.email)));
  }

  Widget get _logoImage => Expanded(
    child: Padding(
      padding:
      const EdgeInsets.only(top: 40, left: 100, right: 100),
      child: FittedBox(
        fit: BoxFit.contain,
        child: CircleAvatar(
          //backgroundImage: ExactAssetImage('assets/images/ani.gif'),
        ),
      ),
    ),
  );
}
