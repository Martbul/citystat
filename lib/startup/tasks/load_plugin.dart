import 'package:citystat/plugins/ai_chat/chat.dart';
import 'package:citystat/plugins/database/calendar/calendar.dart';
import 'package:citystat/plugins/database/board/board.dart';
import 'package:citystat/plugins/database/grid/grid.dart';
import 'package:citystat/plugins/database_document/database_document_plugin.dart';
import 'package:citystat/startup/plugin/plugin.dart';
import 'package:citystat/startup/startup.dart';
import 'package:citystat/plugins/blank/blank.dart';
import 'package:citystat/plugins/document/document.dart';
import 'package:citystat/plugins/trash/trash.dart';

class PluginLoadTask extends LaunchTask {
  const PluginLoadTask();

  @override
  LaunchTaskType get type => LaunchTaskType.dataProcessing;

  @override
  Future<void> initialize(LaunchContext context) async {
    await super.initialize(context);

    registerPlugin(builder: BlankPluginBuilder(), config: BlankPluginConfig());
    registerPlugin(builder: TrashPluginBuilder(), config: TrashPluginConfig());
    registerPlugin(builder: DocumentPluginBuilder());
    registerPlugin(builder: GridPluginBuilder(), config: GridPluginConfig());
    registerPlugin(builder: BoardPluginBuilder(), config: BoardPluginConfig());
    registerPlugin(
      builder: CalendarPluginBuilder(),
      config: CalendarPluginConfig(),
    );
    registerPlugin(
      builder: DatabaseDocumentPluginBuilder(),
      config: DatabaseDocumentPluginConfig(),
    );
    registerPlugin(
      builder: DatabaseDocumentPluginBuilder(),
      config: DatabaseDocumentPluginConfig(),
    );
    registerPlugin(
      builder: AIChatPluginBuilder(),
      config: AIChatPluginConfig(),
    );
  }
}
