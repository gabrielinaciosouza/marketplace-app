import 'package:http/http.dart';
import 'package:marketplace_app/data/data.dart';
import 'package:marketplace_app/infra/infra.dart';

HttpClient get makeHttpClient => HttpAdapter(Client());
