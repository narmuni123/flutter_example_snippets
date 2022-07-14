import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ScrollList extends StatefulWidget {
  const ScrollList({Key? key}) : super(key: key);

  @override
  _ScrollListState createState() => _ScrollListState();
}

class _ScrollListState extends State<ScrollList> {

  final ScrollController _scrollController = ScrollController();

  List itemList = [];

  int page = 1;

  bool hasMore = true;

  bool isLoading = false;

  
  @override
  void initState() {
    super.initState();
    getData();
    _scrollController.addListener(() {
      if(_scrollController.position.maxScrollExtent == _scrollController.offset){
        getData();
      }
    });
  }

  Future<dynamic> getData() async{
    if(isLoading) return ;
    isLoading = true;
    const limit = 25;
    final url = Uri.parse("https://jsonplaceholder.typicode.com/posts?_limit=$limit&page=$page");
    final response = await http.get(url);

    if(response.statusCode == 200){
      final List newItems = json.decode(response.body);
      setState(() {
        page++;
        isLoading = false;
        if(newItems.length < limit){
          hasMore = false;
        }
        itemList.addAll(newItems.map<String>((e) {
          final number = e['id'];
          return 'Items $number';
        }).toList());
      });
    }
  }

  Future refresh() async{
    setState(() {
      isLoading = false;
      hasMore = true;
      page = 0;
      itemList.clear();
    });
    getData();
  }
  
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Scroll List Infinitely"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: refresh,
          child: ListView.builder(
            controller: _scrollController,
            itemCount: itemList.length,
            itemBuilder: (_, int index){
              if(index < itemList.length){
                return ListTile(title: Text(itemList[index]),);
              }else{
                return Center(
                  child: hasMore ?
                  const CircularProgressIndicator()
                      : const Text("No more data"),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
