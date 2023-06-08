import 'package:behaviour/behaviour.dart';
import 'package:flutter_fox_logging/flutter_fox_logging.dart';
import 'package:get_it/get_it.dart';
import 'package:wedding_s_w/shared/logging/get_it_behaviour_monitor.dart';
import 'package:wedding_s_w/shared/logging/logging_track.dart';

void initializeLogging(GetIt getIt) {
  getIt.registerLazySingleton<LogSink>(() {
    final prettyFormatter = PrettyFormatter();
    return PrintSink(
      LevelDependentFormatter(
        defaultFormatter: SimpleFormatter(),
        severe: prettyFormatter,
        shout: prettyFormatter,
      ),
    );
  });

  getIt.registerFactoryParam<Logger, String, dynamic>(
    (loggerName, _) => _loggerFactory(getIt, loggerName),
  );
  getIt.registerFactory<BehaviourMonitor>(
    () => getIt.monitor<LoggingTrack>(),
  );
  getIt.registerFactoryParam<LoggingTrack, BehaviourMixin, dynamic>(
    (behaviour, _) => LoggingTrack(
      behaviour: behaviour,
      logger: getIt.logger(behaviour.runtimeType.toString()),
    ),
  );

  hierarchicalLoggingEnabled = true;
  recordStackTraceAtLevel = Level.SEVERE;
  Logger.root.level = Level.ALL;
}

Logger _loggerFactory(GetIt getIt, String loggerName) {
  final instanceName = '$loggerName-logger';
  if (getIt.isRegistered<Logger>(instanceName: instanceName)) {
    return getIt.get<Logger>(instanceName: instanceName);
  } else {
    final logger = Logger.detached(loggerName)..level = Level.ALL;
    getIt.registerSingleton(
      logger,
      instanceName: instanceName,
      dispose: (instance) => instance.clearListeners(),
    );
    getIt<LogSink>().listenTo(logger.onRecord);
    return logger;
  }
}

extension LoggingGetItExtensions on GetIt {
  Logger logger<T>([String? loggerName]) {
    return get<Logger>(param1: loggerName ?? T.runtimeType.toString());
  }

  GetItBehaviourMonitor<T> monitor<T extends BehaviourTrack>() {
    return GetItBehaviourMonitor(getIt: this);
  }
}
