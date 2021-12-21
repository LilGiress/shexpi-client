import 'dart:math' as math;
import 'package:mycar/Language/LanguageData.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mycar/Language/appLocalizations.dart';

class ConstanceData {
  static const IOS_AppId = "id1474463719";
  static const IOS_APP_Link = "https://apps.apple.com/app//" + IOS_AppId;
  static const LOCATION_MODE = "Location_Mode";
  static const THEME_MODE = 'theme_Mode';
  static const User_Login_Time = 'User_Login_Time';
  static const LAST_PDF_Time = 'LAST_PDF_TIME';
  static const IsFirstTime = 'IsFirstTime';
  static const IsMapType = "IsMapType";
  static const PreviousSearch = 'Previous_Search';

  static const NoInternet =
      'No internet connection !!!\nPlease, try again later.';
  static const SuccsessfullRiderProfile = 'Your Profile create Succsessfully';
  static const BaseImageUrl = 'assets/images/';
  static final appIcon = BaseImageUrl + "app_icon.png";
  static final icon = BaseImageUrl + "icon.png";
  static final buildingImageBack = BaseImageUrl + "building_image_back.png";
  static final buildingImage = BaseImageUrl + "building_image.png";
  static final mapImage2 = BaseImageUrl + "map_image2.jpg";
  static final mapImage3 = BaseImageUrl + "map_image3.jpg";
  static final carImage = BaseImageUrl + "car_image.png";
  static final userImage = BaseImageUrl + "userImage.png";
  static final startPin = BaseImageUrl + "map_pin_start_image.png";
  static final endPin = BaseImageUrl + "map_pin_end_image.png";
  static final user1 = BaseImageUrl + "1.jpg";
  static final user2 = BaseImageUrl + "2.jpg";
  static final user3 = BaseImageUrl + "3.jpg";
  static final user4 = BaseImageUrl + "4.jpg";
  static final user5 = BaseImageUrl + "5.jpg";
  static final user6 = BaseImageUrl + "6.jpg";
  static final user7 = BaseImageUrl + "7.jpg";
  static final user8 = BaseImageUrl + "8.jpg";
  static final user9 = BaseImageUrl + "9.jpg";
  static final star = BaseImageUrl + "star.png";
  static final gift = BaseImageUrl + "gift.png";
  static final coin = BaseImageUrl + "coin.png";
  static final mapCar = BaseImageUrl + "top_car.png";
  static final startmapPin = BaseImageUrl + "start_pin.png";
  static final endmapPin = BaseImageUrl + "end_pin.png";
  static final back = BaseImageUrl + "deliverybac.png";
  static final logo = BaseImageUrl + "logo_shexpi.png";
  static final logo1 = BaseImageUrl + "1024.png";
  static final money = BaseImageUrl + "money.png";
  static String female = "femme";
  static String male = "Homme";

  static double metersToLongitudeDegrees(distance, latitude) {
    var earthEqRadius = 6378137.0;
    var e2 = 0.00669447819799;
    var epsilon = 1e-12;
    var radians = degreesToRadians(latitude);
    var number = math.cos(radians) * earthEqRadius * math.pi / 180;
    var denom = 1 / math.sqrt(1 - e2 * math.sin(radians) * math.sin(radians));
    var deltaDeg = number * denom;
    if (deltaDeg < epsilon) {
      return distance > 0 ? 360 : 0;
    }
    return math.min(360, distance / deltaDeg);
  }

  static double wrapLongitude(double longitude) {
    if (longitude <= 180 && longitude >= -180) {
      return longitude;
    }
    var adjusted = longitude + 180;
    if (adjusted > 0) {
      return (adjusted % 360) - 180;
    }
    return 180 - (-adjusted % 360);
  }

  static double degreesToRadians(double number) {
    return number * math.pi / 180;
  }

  static String getDriverToUserDistance(int distanceInMeter) {
    if (distanceInMeter < 600) {
      return '~$distanceInMeter ' + AppLocalizations.of('meter');
    } else {
      return '~ ${(distanceInMeter / 1000).toStringAsFixed(2)} ' +
          AppLocalizations.of('Km');
    }
  }

  static double getCarAngle(LatLng startPoint, LatLng lastPoint) {
    if (startPoint != null &&
        startPoint.latitude != null &&
        lastPoint != null &&
        lastPoint.latitude != null) {
      var spoint = math.Point(startPoint.latitude, startPoint.longitude);
      var epoint = math.Point(lastPoint.latitude, lastPoint.longitude);
      var newpoint = math.Point(epoint.x - spoint.x, epoint.y - spoint.y);
      double angle = -math.atan2(newpoint.x, newpoint.y);
      var bearingDegrees =
          (angle * (180.0 / math.pi)) - 90; // convert to degrees
      bearingDegrees =
          (bearingDegrees > 0.0 ? bearingDegrees : (360.0 + bearingDegrees));
      return bearingDegrees;
    } else {
      return 0.0;
    }
  }

  static List<LatLng> getRoutePolyLineList() {
    List<List<double>> list = [
      [51.50470714600269, -0.09019766002893448],
      [51.50475305838213, -0.09014502167701721],
      [51.504792292560616, -0.09009741246700287],
      [51.504850100304616, -0.0900142639875412],
      [51.50491229050325, -0.08991200476884842],
      [51.50498032397906, -0.08981041610240936],
      [51.50502185356621, -0.08972391486167908],
      [51.50508446091248, -0.08961360901594162],
      [51.505176702245876, -0.089523084461689],
      [51.505297533936364, -0.08935444056987762],
      [51.50543067798416, -0.08921228349208832],
      [51.50549328476869, -0.08912142366170883],
      [51.505715329471016, -0.0888582319021225],
      [51.50605590721251, -0.08857056498527527],
      [51.50633053790006, -0.08839655667543411],
      [51.506606210352565, -0.08824534714221954],
      [51.50905901655176, -0.0873575359582901],
      [51.50964788740835, -0.08714195340871811],
      [51.509713409775806, -0.08710239082574844],
      [51.50971466179467, -0.0870303064584732],
      [51.50961095278387, -0.08625581860542297],
      [51.509528945290285, -0.08577536791563034],
      [51.50941250691601, -0.08476786315441132],
      [51.50929043410734, -0.08369296789169312],
      [51.50915751001034, -0.08264288306236267],
      [51.50909303020664, -0.08213292807340622],
      [51.5090988730405, -0.08176378905773163],
      [51.50913539073521, -0.08141007274389267],
      [51.50923993551646, -0.08096247911453247],
      [51.50939581321789, -0.08056819438934326],
      [51.50956650599268, -0.08015748113393784],
      [51.509639957943456, -0.08035462349653244],
      [51.50973156404568, -0.08060239255428314],
    ];
    return list.map((f) => LatLng(f[0], f[1])).toList();
  }

  static List<LatLng> getCarFivePolyLineList() {
    List<List<double>> list = [
      [51.51236636049556, -0.09356249123811722],
      [51.51229896402191, -0.09328354150056839],
      [51.51224617352555, -0.09308874607086182],
      [51.51219672150309, -0.09290769696235657],
      [51.51213787978616, -0.09270954877138138],
      [51.5120786206753, -0.09230587631464005],
      [51.51201998746508, -0.09204033762216568],
      [51.5119676139644, -0.09175769984722137],
      [51.51189917360181, -0.09151093661785126],
      [51.511795260903526, -0.09107943624258041],
      [51.51173621000752, -0.09078439325094223],
      [51.5116719425143, -0.09052086621522903],
      [51.511634383547694, -0.09031165391206741],
      [51.511608509574906, -0.0900796428322792],
      [51.5115540489874, -0.08981075137853622],
      [51.51150042298131, -0.08956398814916611],
      [51.51143385987427, -0.08911103010177612],
      [51.51132806815291, -0.08871003985404968],
      [51.51130407196892, -0.0884394720196724],
      [51.511232917992515, -0.08817829191684723],
      [51.51119181139243, -0.0878792256116867],
      [51.511133803030745, -0.08759558200836182],
      [51.511079133212206, -0.08736658841371536],
      [51.511050546296254, -0.08718118071556091],
      [51.51102654996606, -0.087004154920578],
      [51.511065570079126, -0.08693307638168335],
      [51.511178874282194, -0.08704438805580139],
      [51.51137418252319, -0.08719760924577713],
      [51.511553631664654, -0.08734278380870819],
      [51.51172995019073, -0.08747320622205734],
      [51.51187559503847, -0.08762039244174957],
      [51.51207507347253, -0.08778568357229233],
      [51.512207571740454, -0.08786849677562714],
      [51.51232024712962, -0.08797209709882736],
      [51.51247674026339, -0.08808508515357971],
      [51.51258565916718, -0.08819237351417542],
      [51.512712313580344, -0.0882701575756073],
      [51.512852321591005, -0.08836805820465088],
      [51.512987738765744, -0.08846797049045563],
      [51.51308747565704, -0.08864566683769226],
      [51.513257737293245, -0.08882034569978714],
      [51.51338313791981, -0.08894171565771103],
      [51.5135173016023, -0.0890248641371727],
      [51.51367128680371, -0.08910834789276123],
      [51.51382819259818, -0.08918981999158859],
      [51.51403079223277, -0.08930247277021408],
      [51.51420730982045, -0.08944597095251083],
      [51.51433959323801, -0.08952341973781586],
      [51.51446353035005, -0.08961427956819534],
      [51.51457786933957, -0.08968602865934372],
      [51.5146821929847, -0.08972089737653732],
      [51.51479799195103, -0.0897359848022461],
      [51.514887083928336, -0.08967764675617218],
      [51.5149647002162, -0.08965183049440384],
      [51.51504648927962, -0.08959583938121796],
      [51.515125983101065, -0.08956935256719589],
      [51.51521716088293, -0.08954286575317383],
      [51.515274955400706, -0.0895187258720398],
      [51.51535778712687, -0.08949995040893555],
      [51.51545230274123, -0.08947212249040604],
      [51.51556267503165, -0.08943557739257812],
      [51.51565301736897, -0.08940674364566803],
      [51.51573000642494, -0.08931353688240051],
    ];
    return list.map((f) => LatLng(f[0], f[1])).toList();
  }

  static List<LatLng> getCarFourPolyLineList() {
    List<List<double>> list = [
      [51.51087380781165, -0.09328722953796387],
      [51.510777822042726, -0.09271189570426941],
      [51.510706041248575, -0.09238902479410172],
      [51.51065846554365, -0.09203765541315079],
      [51.5105933618669, -0.09172651916742325],
      [51.510523041444856, -0.09141739457845688],
      [51.51047630021409, -0.09115755558013916],
      [51.51045877224016, -0.09085915982723236],
      [51.51037760093974, -0.0905081257224083],
      [51.51031416619813, -0.09008869528770447],
      [51.51018312309692, -0.08955225348472595],
      [51.510031212788135, -0.0890858843922615],
      [51.509897664845525, -0.08857861161231995],
      [51.50982859536536, -0.08821383118629456],
      [51.509791660887394, -0.08781686425209045],
      [51.50974888362972, -0.08738938719034195],
      [51.50967564052454, -0.08709166198968887],
      [51.509530823326116, -0.08706752210855484],
      [51.50934051529918, -0.08717011660337448],
      [51.50918860218081, -0.08719291538000107],
      [51.50902708960106, -0.08726969361305237],
      [51.508896251471306, -0.08730724453926086],
      [51.508744754220125, -0.08735150098800659],
      [51.50856237256347, -0.08741755038499832],
      [51.50832949057678, -0.08753422647714615],
      [51.50816484479804, -0.0875530019402504],
      [51.507935508304755, -0.08764352649450302],
      [51.507781921072414, -0.0876978412270546],
      [51.507606004625345, -0.08772868663072586],
      [51.507437808668335, -0.0878094881772995],
      [51.50726293429783, -0.08786715567111969],
      [51.50707658175382, -0.08797276765108109],
      [51.506988935276965, -0.08799120783805847],
      [51.50675354104756, -0.08804216980934143],
      [51.506535257723286, -0.08815012872219086],
      [51.50633366817951, -0.08819941431283951],
      [51.50624664633069, -0.08823662996292114],
      [51.506166510955964, -0.0882091373205185],
      [51.506105157214456, -0.08796505630016327],
      [51.50603190825159, -0.08765827864408493],
      [51.506001648674165, -0.0874098390340805],
      [51.505923182365976, -0.08694682270288467],
      [51.505869132357006, -0.08662931621074677],
      [51.50582614272881, -0.08635338395833969],
      [51.50575477150891, -0.08604023605585098],
      [51.50570176474109, -0.08580788969993591],
      [51.50564646233887, -0.08567210286855698],
    ];
    return list.map((f) => LatLng(f[0], f[1])).toList();
  }

  static List<LatLng> getCarThreePolyLineList() {
    List<List<double>> list = [
      [51.50405810696251, -0.08155558258295059],
      [51.50408795043946, -0.08163772523403168],
      [51.50412614171364, -0.08170511573553085],
      [51.50415014167829, -0.08176948875188828],
      [51.50417643727724, -0.08183486759662628],
      [51.50420857632201, -0.0819210335612297],
      [51.5042415501236, -0.08200887590646744],
      [51.5042617935216, -0.08205145597457886],
      [51.5042880890561, -0.0821295753121376],
      [51.5043223149672, -0.08219629526138306],
      [51.50434819307801, -0.08227743208408356],
      [51.50436885381723, -0.08233744651079178],
      [51.504391601488955, -0.08240416646003723],
      [51.5044139317612, -0.08247055113315582],
      [51.504429583814634, -0.08255068212747574],
      [51.50446881827164, -0.08266568183898926],
      [51.504499287560705, -0.08277565240859985],
      [51.504525582958145, -0.082862488925457],
      [51.50455229572735, -0.08293624967336655],
      [51.50457629546755, -0.08301436901092529],
      [51.504605512525536, -0.08309651166200638],
      [51.50463493825784, -0.08317496627569199],
      [51.50465998141931, -0.08322793990373611],
      [51.50469358097265, -0.08329935371875763],
      [51.50471799802384, -0.08336205035448074],
      [51.504758693080056, -0.08342642337083817],
      [51.50477184070583, -0.08347168564796448],
      [51.50479667509974, -0.08354008197784424],
      [51.504825474632035, -0.08361317217350006],
      [51.504843213465314, -0.08365876972675323],
      [51.50486616959227, -0.0837140902876854],
      [51.50488516056128, -0.08376572281122208],
      [51.504918342565034, -0.08382473140954971],
      [51.50493670743725, -0.08386395871639252],
      [51.50495820267598, -0.08394274860620499],
      [51.50498449780863, -0.08399941027164459],
      [51.50501183638282, -0.08404869586229324],
      [51.50503520980728, -0.08410066366195679],
      [51.50505920929315, -0.08415699005126953],
      [51.50507882625484, -0.08422203361988068],
      [51.50510240833587, -0.08427131921052933],
      [51.505131625056514, -0.08432898670434952],
      [51.50514998984274, -0.08437324315309525],
      [51.5051702328372, -0.08441783487796783],
      [51.50518692808357, -0.08446041494607925],
      [51.50521134487039, -0.0845227763056755],
      [51.505232005218254, -0.08456669747829437],
      [51.50525516983956, -0.08462335914373398],
      [51.505279377899704, -0.08467767387628555],
      [51.505297951316436, -0.08472796529531479],
      [51.505329880880296, -0.08480709046125412],
      [51.505375583942595, -0.08489660918712616],
      [51.5054022962135, -0.08494891226291656],
      [51.505424834679864, -0.08500088006258011],
      [51.50545092085391, -0.08506055921316147],
      [51.50546448565849, -0.08509978652000427],
      [51.50549850199688, -0.0851832702755928],
      [51.50552312730573, -0.08523993194103241],
      [51.50554900473461, -0.08529558777809143],
      [51.50556695197503, -0.08534923195838928],
      [51.505578638546396, -0.08539516478776932],
      [51.50560743758446, -0.08548468351364136],
      [51.50562976726085, -0.08554235100746155],
      [51.50567233969771, -0.08564729243516922],
      [51.505701138676535, -0.08576028048992157],
      [51.50573452877414, -0.0858568400144577],
      [51.505756441012394, -0.0859074667096138],
      [51.50577856192796, -0.08598893880844116],
      [51.505825307978334, -0.08611969649791718],
      [51.505853063423054, -0.08631952106952667],
      [51.50588854028266, -0.08651532232761383],
      [51.505897931211464, -0.08665982633829117],
      [51.505930069042044, -0.0868532806634903],
      [51.505970136954936, -0.08704371750354767],
      [51.50601229170026, -0.08729349821805954],
      [51.506031282191564, -0.08740179240703583],
      [51.50605987225701, -0.08757513016462326],
      [51.50607155870195, -0.08766867220401764],
      [51.50609660107388, -0.08779004216194153],
      [51.506112252549315, -0.08790604770183563],
      [51.506114756784896, -0.08801065385341644],
      [51.506131660371445, -0.08812699466943741],
      [51.50617172810706, -0.08824199438095093],
      [51.506114756784896, -0.08835028856992722],
      [51.50605674195876, -0.08841533213853836],
      [51.50591400012959, -0.0885571539402008],
      [51.50584701148541, -0.08865907788276672],
      [51.505771049165396, -0.08875899016857147],
      [51.50567839165853, -0.08887767791748047],
      [51.50559595970916, -0.08898630738258362],
      [51.50551164940918, -0.08908689022064209],
      [51.50541419151658, -0.0892045721411705],
      [51.50534115013279, -0.08929308503866196],
      [51.50530066428678, -0.08934874087572098],
      [51.505214057845905, -0.08945737034082413],
      [51.505104286554165, -0.08961092680692673],
      [51.50502790561344, -0.08974738419055939],
      [51.50494129865413, -0.08987512439489365],
      [51.50485469153023, -0.08997570723295212],
      [51.504800640253826, -0.09005483239889145],
      [51.50473594559158, -0.09013999253511429],
      [51.504672294302, -0.09019497781991959],
      [51.50463368609942, -0.09025096893310547],
      [51.504571912907245, -0.09030159562826157],
      [51.5045182786826, -0.09037267416715622],
      [51.5044640183133, -0.09045280516147614],
      [51.50439535798413, -0.09051818400621414],
      [51.50431104546272, -0.09065162390470505],
      [51.504240715344096, -0.09076058864593506],
      [51.50417789814341, -0.09086787700653076],
      [51.50410819390571, -0.09095672518014908],
      [51.50402033302311, -0.0910559669137001],
      [51.50395355029116, -0.09112536907196045],
      [51.50387675002842, -0.09116929024457932],
      [51.503747566685824, -0.09126350283622742],
      [51.503676818302615, -0.09130977094173431],
    ];
    return list.map((f) => LatLng(f[0], f[1])).toList();
  }

  static List<LatLng> getCarTwoPolyLineList() {
    List<List<double>> list = [
      [51.50145434488205, -0.09303979575634003],
      [51.501525305423016, -0.09297776967287064],
      [51.501590630764554, -0.09291306138038635],
      [51.50166451298684, -0.09282588958740234],
      [51.5017459085168, -0.09274877607822418],
      [51.50184107849055, -0.09266629815101624],
      [51.50194939670565, -0.09259052574634552],
      [51.502058340777936, -0.09252849966287613],
      [51.50215163175926, -0.09246345609426498],
      [51.50223636568419, -0.0924275815486908],
      [51.5023100381559, -0.09237628430128098],
      [51.502382249584805, -0.09234108030796051],
      [51.50246510475389, -0.09229682385921478],
      [51.502538359450476, -0.092247873544693],
      [51.502632692960354, -0.09219959378242493],
      [51.50271471286665, -0.09213723242282867],
      [51.502787758460464, -0.09209901094436646],
      [51.50287019548997, -0.09204067289829254],
      [51.502926753467015, -0.09200111031532288],
      [51.502994998607825, -0.09194847196340561],
      [51.50307117425593, -0.09189147502183914],
      [51.50314046268007, -0.09183648973703384],
      [51.503242725523194, -0.09175971150398254],
      [51.50332182254444, -0.09169533848762512],
      [51.50341260655533, -0.09161856025457382],
      [51.50348690322043, -0.09156022220849991],
      [51.503575599923266, -0.0914730504155159],
      [51.503639252744776, -0.09141102433204651],
      [51.50369455758307, -0.09136810898780823],
      [51.50378701042702, -0.09130775928497314],
      [51.5038370976682, -0.09127222001552582],
      [51.503901584910146, -0.09121555835008621],
      [51.50397128946387, -0.0911659374833107],
      [51.504035567820104, -0.091102235019207],
      [51.5040933765241, -0.09104020893573761],
      [51.50414826342066, -0.09094968438148499],
      [51.50421316761225, -0.09085748344659805],
      [51.50428120213187, -0.09072404354810715],
      [51.5043650973199, -0.09064391255378723],
      [51.5044289577326, -0.09055573493242264],
      [51.50448780940624, -0.09047292172908783],
      [51.50458965183925, -0.09034886956214905],
      [51.50466665959339, -0.09027879685163498],
      [51.50471382416987, -0.09020436555147171],
      [51.50479563163809, -0.0901198759675026],
      [51.50486262182795, -0.0900404155254364],
      [51.50492564677647, -0.08993815630674362],
      [51.504983871734225, -0.08982717990875244],
      [51.50505837452864, -0.08973799645900726],
      [51.5051213992064, -0.08964076638221741],
      [51.50517440664937, -0.08953850716352463],
      [51.505252665556746, -0.08944429457187653],
      [51.50532424625301, -0.08936014026403427],
      [51.505382888080725, -0.08929912000894547],
      [51.50545425988309, -0.08920222520828247],
      [51.50555004817901, -0.08911136537790298],
      [51.505614950374, -0.08903257548809052],
      [51.50565668807112, -0.08898597210645676],
      [51.505713242589756, -0.08891288191080093],
      [51.50577042310178, -0.0888555496931076],
      [51.50584742886044, -0.08879050612449646],
      [51.50593111247772, -0.0887308269739151],
      [51.505992257766735, -0.08867718279361725],
      [51.50608303645743, -0.08859705179929733],
      [51.50618466663915, -0.08853770792484283],
      [51.50623871627383, -0.08849512785673141],
      [51.50629443532819, -0.0884280726313591],
      [51.50634577192469, -0.08840829133987427],
      [51.50642465487493, -0.08833017200231552],
      [51.506499990051736, -0.0882946327328682],
      [51.50656822984123, -0.08827351033687592],
      [51.506776078845576, -0.08820947259664536],
      [51.50689628024671, -0.0881689041852951],
      [51.50703317590063, -0.08811559528112411],
      [51.50713751682408, -0.0880790501832962],
      [51.50729173227137, -0.0880240648984909],
      [51.50747537109472, -0.0879717618227005],
      [51.507588684226675, -0.08792147040367126],
      [51.507712848384756, -0.08788257837295532],
      [51.50782553489075, -0.08784502744674683],
      [51.507953037249436, -0.08781351149082184],
      [51.508124152783836, -0.08774343878030777],
      [51.508208666926535, -0.08771795779466629],
      [51.50832573440595, -0.087653249502182],
      [51.50839292808182, -0.08764553815126419],
      [51.5084761896731, -0.0876183807849884],
      [51.508554651584774, -0.08759021759033203],
      [51.50863353071086, -0.08755266666412354],
      [51.508719087280525, -0.0875154510140419],
      [51.50882300699542, -0.08746683597564697],
      [51.50901561258714, -0.08737999945878983],
      [51.50914290294306, -0.08733808994293213],
      [51.50930149370861, -0.08728310465812683],
      [51.50947656892578, -0.08724488317966461],
      [51.50963390650879, -0.08717983961105347],
      [51.509777262692964, -0.0871141254901886],
      [51.509887648734065, -0.0870765745639801],
      [51.510043941555985, -0.08702460676431656],
      [51.5101883397881, -0.08695855736732483],
      [51.51033002489182, -0.08689083158969879],
      [51.51047838687718, -0.08683215826749802],
      [51.51053222275241, -0.0868113711476326],
      [51.510658674209125, -0.08677314966917038],
      [51.51077803070767, -0.08671481162309647],
      [51.51088716233736, -0.08666921406984329],
      [51.510933277153946, -0.08666016161441803],
      [51.51092200928453, -0.08654683828353882],
      [51.5109044814821, -0.08640870451927185],
      [51.510940789065366, -0.0862346962094307],
      [51.510963533456206, -0.08611634373664856],
      [51.511009230867735, -0.08599497377872467],
      [51.511051172287296, -0.08589472621679306],
      [51.511085393118435, -0.0858350470662117],
      [51.51114527951107, -0.0857337936758995],
      [51.511167189147216, -0.08567109704017639],
      [51.51119577599, -0.08562181144952774],
      [51.5112721465915, -0.08557621389627457],
      [51.51132326891713, -0.08552491664886475],
      [51.511390249510015, -0.08548468351364136],
      [51.511462029226124, -0.08542835712432861],
      [51.511515029292724, -0.08539348840713501],
      [51.51159077337539, -0.08534923195838928],
      [51.51164585990188, -0.08528988808393478],
      [51.51172556831849, -0.08525166660547256],
      [51.51178795779333, -0.08521109819412231],
      [51.51185264244293, -0.0851641595363617],
      [51.5119041814367, -0.08513197302818298],
      [51.511968448602325, -0.0850890576839447],
      [51.51201393634654, -0.0850515067577362],
      [51.512076325426484, -0.08500691503286362],
      [51.51214873003755, -0.08495226502418518],
      [51.51221216222469, -0.08491672575473785],
      [51.51228018480095, -0.08486945182085037],
      [51.51231920384026, -0.08484028279781342],
      [51.51238493102343, -0.08479032665491104],
      [51.51244502436503, -0.08475244045257568],
      [51.512514298535486, -0.08470315486192703],
      [51.512565628123966, -0.0846528634428978],
      [51.512603186322785, -0.08462537080049515],
      [51.51266766115855, -0.08457541465759277],
      [51.51270772314648, -0.08454490453004837],
      [51.51276176504309, -0.0845080241560936],
      [51.51281309435271, -0.08446477353572845],
      [51.512869848644, -0.08443694561719894],
      [51.51293599234278, -0.08439268916845322],
      [51.512981061811246, -0.0843517854809761],
      [51.51303614665657, -0.08431926369667053],
      [51.51303698127491, -0.08430149406194687],
      [51.51315090653706, -0.08424684405326843],
      [51.51322393540138, -0.08418850600719452],
      [51.51330405836357, -0.08415229618549347],
      [51.513357264940275, -0.08412614464759827],
      [51.51343091943213, -0.08408591151237488],
      [51.513488090258726, -0.08406311273574829],
      [51.513583027056804, -0.08403293788433075],
      [51.51363957173703, -0.08401047438383102],
      [51.51372678811726, -0.08397627621889114],
      [51.5137883402468, -0.08395582437515259],
      [51.51387180062857, -0.08392497897148132],
      [51.513919372977774, -0.08391391485929489],
      [51.51397988159577, -0.0838937982916832],
      [51.51402411543117, -0.08386999368667603],
      [51.51408942285491, -0.083836130797863],
      [51.51415452153554, -0.08380662649869919],
      [51.5142185768773, -0.08376907557249069],
      [51.51426134993807, -0.08374493569135666],
      [51.514325196480904, -0.0837114080786705],
      [51.51438111429458, -0.0836896151304245],
      [51.51442054883087, -0.08365072309970856],
      [51.514505885885114, -0.08353304117918015],
      [51.51452466418855, -0.08350420743227005],
    ];
    return list.map((f) => LatLng(f[0], f[1])).toList();
  }

  static List<LatLng> getCarOnePolyLineList() {
    List<List<double>> list = [
      [51.50970923637943, -0.08697733283042908],
      [51.50963286315794, -0.08636679500341415],
      [51.50951684239067, -0.08559532463550568],
      [51.5094433902414, -0.08506692945957184],
      [51.50940311671156, -0.08471857756376266],
      [51.509349279502075, -0.08428003638982773],
      [51.50929648558762, -0.08380260318517685],
      [51.50926309810023, -0.08349113166332245],
      [51.50923137996455, -0.08330270648002625],
      [51.5091908975751, -0.08297145366668701],
      [51.50915688399326, -0.0826800987124443],
      [51.50913142595836, -0.08242662996053696],
      [51.50910784596249, -0.08215740323066711],
      [51.50909678631423, -0.08180100470781326],
      [51.50913309533812, -0.08148215711116791],
      [51.50917128238377, -0.08121225982904434],
      [51.509227206523995, -0.08100874722003937],
      [51.509276453098124, -0.08082233369350433],
      [51.50938684035261, -0.08057959377765656],
      [51.50946822208921, -0.08045084774494171],
      [51.5095122516348, -0.08033920079469681],
      [51.50957130541354, -0.08016284555196762],
      [51.50961533485952, -0.07997710257768631],
      [51.50964496602671, -0.07979873567819595],
      [51.50964496602671, -0.0795828178524971],
      [51.509649765439306, -0.07943864911794662],
      [51.50969922022652, -0.07940076291561127],
      [51.5097793493881, -0.07936220616102219],
      [51.50985134031149, -0.07929716259241104],
      [51.509919992419434, -0.07926363497972488],
      [51.51002182271121, -0.07922608405351639],
      [51.51029163015023, -0.07921166718006134],
      [51.51037843560681, -0.07922172546386719],
      [51.51046357156702, -0.07921870797872543],
      [51.51055893200022, -0.07922206073999405],
      [51.51067995808315, -0.07922910153865814],
      [51.51076488481494, -0.07923245429992676],
      [51.510844803437585, -0.07924150675535202],
      [51.51096374212029, -0.07925357669591904],
      [51.511050546296254, -0.07925793528556824],
      [51.51107454261377, -0.07926497608423233],
      [51.511050546296254, -0.0793655589222908],
      [51.511038026473365, -0.07950536906719208],
      [51.5110156994474, -0.07966294884681702],
      [51.51100985685937, -0.079716257750988],
      [51.511006309573396, -0.07983427494764328],
      [51.51099170309887, -0.0799579918384552],
      [51.51098606917175, -0.08008237928152084],
      [51.51098606917175, -0.08015882223844528],
      [51.51091825332743, -0.08019637316465378],
      [51.510793889239864, -0.08023492991924286],
      [51.51067536744452, -0.08027985692024231],
      [51.51054182139016, -0.08033182471990585],
      [51.510489028857556, -0.0803506001830101],
      [51.51040410161157, -0.08037641644477844],
      [51.51035297825447, -0.08038479834794998],
      [51.51030102017156, -0.08041530847549438],
      [51.51022089192751, -0.08044246584177017],
      [51.51014681490986, -0.08047264069318771],
      [51.510077537139274, -0.08048973977565765],
      [51.510011806627034, -0.08050516247749329],
      [51.50995817880553, -0.08051622658967972],
      [51.50989077876912, -0.08053064346313477],
      [51.50983005605032, -0.08055277168750763],
      [51.50979040887067, -0.0805748999118805],
      [51.50977225462426, -0.08061680942773819],
      [51.50975430904025, -0.08067481219768524],
      [51.509767455224576, -0.08072644472122192],
      [51.50979040887067, -0.08078277111053467],
      [51.509815449198676, -0.08084110915660858],
      [51.50983485544342, -0.08090715855360031],
      [51.509829847381056, -0.08097488433122635],
      [51.50984361955123, -0.08102752268314362],
      [51.5098653211443, -0.08106976747512817],
      [51.50989620416276, -0.0811663269996643],
      [51.509933138555965, -0.08126255124807358],
      [51.50997549830341, -0.08136782795190811],
      [51.510014101979856, -0.08147712796926498],
      [51.51005061894097, -0.08156932890415192],
      [51.510071068426406, -0.08163336664438248],
      [51.5101013253013, -0.08170947432518005],
      [51.51012553078673, -0.08176781237125397],
      [51.51014952759151, -0.08183218538761139],
      [51.51017206370965, -0.08189253509044647],
      [51.510200651176895, -0.08199512958526611],
      [51.51023528998175, -0.0820641964673996],
      [51.510271598098306, -0.08216746151447296],
      [51.510304776179524, -0.08225999772548676],
      [51.510332528895574, -0.08231967687606812],
      [51.51035339558823, -0.08238840848207474],
      [51.51038427827583, -0.08245747536420822],
      [51.51042705493692, -0.08258957415819168],
      [51.51046837089338, -0.08270289748907089],
      [51.51050780881689, -0.08280348032712936],
      [51.5105537153515, -0.08291982114315033],
      [51.51058251124504, -0.0830318033695221],
      [51.510591483874826, -0.0831260159611702],
      [51.51061026379192, -0.08324000984430313],
      [51.51062779170752, -0.08337680250406265],
      [51.51062779170752, -0.08349951356649399],
      [51.51064302429539, -0.08362758904695511],
      [51.510650118923614, -0.0837881863117218],
      [51.51066096952937, -0.08390653878450394],
      [51.51066931614739, -0.0840185210108757],
      [51.51068058407932, -0.08410971611738205],
      [51.51068893069376, -0.08423779159784317],
      [51.51070812790117, -0.08431121706962585],
      [51.51071397052792, -0.08442219346761703],
      [51.51073212439908, -0.0845455750823021],
      [51.510735671706385, -0.08465252816677094],
      [51.51073942767852, -0.08472729474306107],
      [51.51073942767852, -0.08482787758111954],
      [51.510744226975824, -0.08489828556776047],
      [51.510744226975824, -0.0849485769867897],
      [51.51074172299469, -0.08499417454004288],
      [51.51074047100407, -0.08509006351232529],
      [51.51073692369713, -0.0852121040225029],
      [51.510735671706385, -0.08532576262950897],
      [51.510759459524756, -0.08545082062482834],
      [51.510771562094234, -0.085512176156044],
      [51.51078950727757, -0.08559532463550568],
      [51.51081099975527, -0.08569523692131042],
      [51.510827275605436, -0.0857783854007721],
      [51.51083666551636, -0.08584175258874893],
      [51.51085022871759, -0.08589942008256912],
      [51.51086587856013, -0.08595742285251617],
      [51.51086984318607, -0.08603520691394806],
      [51.510883615041855, -0.08611634373664856],
      [51.510890709632626, -0.08618071675300598],
      [51.51090865476902, -0.08626185357570648],
      [51.51091261939121, -0.08629906922578812],
      [51.51091261939121, -0.08636847138404846],
      [51.51091074141232, -0.08641339838504791],
      [51.51091074141232, -0.08649185299873352],
      [51.51089112696145, -0.08656829595565796],
      [51.5108212243285, -0.08658640086650848],
      [51.51076425881995, -0.08661054074764252],
      [51.510707293240145, -0.08662227541208267],
      [51.51066639483125, -0.08664071559906006],
      [51.51063071302613, -0.08665882050991058],
      [51.510596909185004, -0.08667055517435074],
      [51.51054432538226, -0.08669033646583557],
      [51.51049987950168, -0.08670307695865631],
      [51.51045731157539, -0.08672453463077545],
      [51.510390120944116, -0.08674833923578262],
      [51.510341501574594, -0.08677616715431213],
      [51.51027305876905, -0.08680298924446106],
      [51.51022172659745, -0.08682243525981903],
      [51.5101883397881, -0.08683919906616211],
      [51.51013930286752, -0.08685629814863205],
      [51.51009840394872, -0.08687205612659454],
      [51.510057504993206, -0.08689116686582565],
      [51.510021405374424, -0.08690357208251953],
      [51.50999511314849, -0.08692637085914612],
      [51.50995650945599, -0.08694581687450409],
      [51.50992061842603, -0.0869622454047203],
      [51.509876797944145, -0.08697632700204849],
      [51.5098448715665, -0.0869910791516304],
      [51.50979541693737, -0.08700549602508545],
      [51.50976119513725, -0.08701689541339874],
      [51.50973469409148, -0.08702527731657028],
      [51.50971904386034, -0.08701790124177933],
      [51.50971194908712, -0.08699443191289902],
    ];
    return list.map((f) => LatLng(f[0], f[1])).toList();
  }
}

// Locale locale;
var locale = "fr";
var constance;

AllTextData allTextData;
