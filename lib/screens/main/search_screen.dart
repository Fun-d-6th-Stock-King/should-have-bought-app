import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:should_have_bought_app/providers/calculator/calculator_provider.dart';
import 'package:should_have_bought_app/screens/stock/stock_detail_screen.dart';
import 'package:should_have_bought_app/widgets/calculator/search_item.dart';

class SearchScreen extends StatefulWidget {
  final String type;
  SearchScreen({this.type = 'buy_or_not'});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<String> _recentSearchTerms;
  final TextEditingController _searchTermController = TextEditingController();
  Future futureGetCompanyList;

  @override
  void initState() {
    super.initState();
    futureGetCompanyList =
        Provider.of<CalculatorProvider>(context, listen: false).getCompanies();
  }

  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildNoSearchAppBar(context),
      body: FutureBuilder(
          future: futureGetCompanyList,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 30, horizontal: 30),
                  child: CircularProgressIndicator(
                      backgroundColor: Colors.transparent),
                ),
              );
            } if (snapshot.connectionState == ConnectionState.done) {
              return CompanyList(context);
            }
            return Container(
              width: 0,
              height: 0,
            );
        }
      ),
    );
  }
  Widget _buildNoSearchAppBar(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(60.0),
      child: Container(
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Image(image: AssetImage('assets/icons/ico_back.png')),
          ),
          titleSpacing: 0,
          title: _buildTextComposer(),
        ),
      ),
    );
  }

  Widget _buildTextComposer() {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.white,
        ),
        margin: EdgeInsets.only(right: 16),
        padding: EdgeInsets.only(left: 12, right: 4),
        child: Row(
          children: [
            Flexible(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Consumer<CalculatorProvider>(
                    builder: (context, calculatorProvider, child) {
                    return TextField(
                      onChanged: (value) {
                        calculatorProvider.filterSearchResults(value);
                      },
                      controller: _searchTermController,
                      autofocus: true,
                      onSubmitted: null, //_handleSubmitted,
                      style: TextStyle(fontSize: 18),
                      decoration: InputDecoration.collapsed(hintText: "어떤 종목이 궁금하세요?"),

                    );
                  }
                ),
              ),
            ),
            Container(
              child: IconButton(
                icon:
                Image.asset('assets/icons/ico_search.png'),
                onPressed: () {
                  _searchTermController.text = '';
                  Provider.of<CalculatorProvider>(context,listen:false).clearQuery();
                  //_setIsSearchResult(false);
                },
              ),//_handleSubmitted(_searchTermController.text),
            ),
          ],
        ));
  }
  Widget CompanyList(BuildContext context) {
    return Consumer<CalculatorProvider>(
        builder: (context, calculatorProvider, child) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: calculatorProvider.searchCompanyList.length,
                itemBuilder: (context, index) {
                  return SearchItem(
                      company: calculatorProvider.searchCompanyList[index],
                      query: calculatorProvider.query,
                      onTap: () {
                        Provider.of<CalculatorProvider>(context,listen:false).clearQuery();
                        Navigator.push(context, MaterialPageRoute(builder: (context) =>
                            StockDetailScreen(calculatorProvider.searchCompanyList[index], widget.type == 'drip' ? 1: 0)
                        ));
                      }
                  );
                }),
          );
        }
    );
  }
}
