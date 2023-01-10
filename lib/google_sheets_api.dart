import 'package:gsheets/gsheets.dart';

class GoogleSheetsApi {
  // create credentials
  static const _credentials = r'''
  {
   
    "type": "service_account",
  "project_id": "hacktuattendance",
  "private_key_id": "7438fc5515469b99d1e723d3db6375e537f19b55",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCl0l8PUInWIlTe\ntg4hGDKWqkOYcP6CH3es3B84qVE0oyzeILsx+fyZuo1nRnRvq865quQStcckcwuF\n7YUGCcb4GA2Zkuv3MV3Il3ZzdJfFg8BHUEzdlXioBh1L6z2YYJRpyqWC2ZemNKHd\nm9SfSPVjf5tsYFTJ/RNOUn9xBb7cJaC3RlaaMWpgCE0fdGYJVaWVDX7oi32Y7JU1\n/+YsnZDwKZ5tIKa3kPJ/d94cpuy+ZwGDhjiMYJPA/uSFLtqiHnnKdmoEobMUGKz0\nakwo/utLMWbhQYk4hh9UTxC5rfU6S/WEpzD2tbtSpbmr0AAep38uy6VQusNXok0Q\ndVtlOEcvAgMBAAECggEAS4qrA68NHCBHya3mge0kHr8yTCAt0dnEC1u8XXPFKtWr\newYuQXZBPUdfY80U/kqmwq63eE6XimNevISYNUf+/Mb4ax4joVk8AEYAEFjtS23a\nCqLqYYfWj7U5Y3yncuOMuSU4gYPfMjiIBQ0Yr/fs0ocvpw+7kMlaIjQzGqojaOZ+\n5mxHrijoFjbmiypQB2LtzfRJkKX8NzXfKTwkZHSfLwCJ6iXrjG1F4jc59y1nEhsp\ngfnlMS2ia6TE7cfg3c4/BTAFyFmqw/bFE11jedXbJzdjVSMmAyoLIwHj07aljMsC\n4HkMu/POxzyYCJftKmbkpsQZaY4DHMdqsChV85/kAQKBgQDiKgC/vGt20Poc/Ceo\nz68mhyxCF/zleJ76F1EoIlfR12cf8gWZ5P0yH6DanDp5cuCVFsdFPRVcgLZozQAy\n2L1plCPz+NlNnwyg6h30Y7cKFwRmWPakWp1GIhzExeAHVJbLfY7y8Uqh71tX2CQS\nE09SEsae+mupZ/YsB5dlokIB3wKBgQC7sn39ztB2LEk1VV4RCOwCEJsRa3NR6HK6\n9L39sShbMKItcjCKVT7PVSnpCY1kNUfm0w/VCFdlIX2SVZGVFG5Cznng2MCMtuLP\n3QD3Q0ezIehQ0cWVykpoCcAYLtgjpaJfKOD6V7qUFHHmT0gkWjHoZXq73LF/F14j\n2cjHsyKEsQKBgAPyp8CxEU8pprQK0sZnma8afPNKZ+e5i0ziS1BgCRhooiw0lVRy\nYtkVJEGsqHimQLVZiHD0+AJ9XLHHolFA502IgHgpx+FK/XVxoMQ7WV6buD/xHZ0Q\n1935incE3TxDhb5Xmr8y5xKckwOdikOmgqP0H/N2e5qhbfKmz0W+51gRAoGBALev\nTi18n/WGEX7oNE5ndM/wgFDj3s9htCXSLbyACwZy6cOf5HD8S6OLrKAqgPx4SA1U\nsEHDEAQgakszAm3quJ0Yg53PgWAz+nOBzNguN5TOshOltr+IYJjAMgV4kn0QM378\n+m8EO8t+1piVLfylaAIOjbYbnHjL3Y0oLJ2CaV2BAoGAZaCwQ10EpUOEiuEU/GQp\ni04QNCVYmY7Bhbs9990/GhWmyXUknGWASSmPqKvzXBBy/DDhYZHW3nfCn0GPVmz1\n4FvZ2EnVyWSKpzivxCIQ54M67JsfDpux+Rvp7ht/DR2AnYBxAgSYApgXm6rRJbIM\nqaGcFVrvFGaFLSA9mjp1pcM=\n-----END PRIVATE KEY-----\n",
  "client_email": "ccshacktu@hacktuattendance.iam.gserviceaccount.com",
  "client_id": "115312678290992435055",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/ccshacktu%40hacktuattendance.iam.gserviceaccount.com"
  
  }
  ''';

  // set up & connect to the spreadsheet
  static final _spreadsheetId = '1VBhi1fvsPBUZt5O3GmGu2rmD2kNJaeCUZh-hMMoS7ew';
  static final _gsheets = GSheets(_credentials);
  static Worksheet? _worksheet;

  // some variables to keep track of..
  static int numberOfTransactions = 0;
  static List<List<dynamic>> currentTransactions = [];
  static bool loading = true;

  // initialise the spreadsheet!
  Future init() async {
    final ss = await _gsheets.spreadsheet(_spreadsheetId);
    _worksheet = ss.worksheetByTitle('Worksheet1');
  }

  // count the number of notes

  // load existing notes from the spreadsheet

  // insert a new transaction
  static Future insert(String name, String amount, bool _isIncome) async {
    if (_worksheet == null) return;
    numberOfTransactions++;
    currentTransactions.add([
      name,
      amount,
      _isIncome == true ? 'income' : 'expense',
    ]);
    await _worksheet!.values.appendRow([
      name,
      amount,
      _isIncome == true ? 'income' : 'expense',
    ]);
  }

  // CALCULATE THE TOTAL INCOME!

}
