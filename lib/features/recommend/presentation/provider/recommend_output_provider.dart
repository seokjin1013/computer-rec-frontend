import 'package:flutter/material.dart';

import '../../domain/entities/computer_item.dart';
import '../../domain/entities/no_item.dart';
import '../../domain/entities/program_fit.dart';
import '../../domain/entities/recommend_input.dart';
import '../../domain/entities/recommend_output.dart';
import '../../domain/usecases/get_bottleneck_cpu_vga.dart';
import '../../domain/usecases/get_computer_item.dart';
import '../../domain/usecases/get_computer_program_fit.dart';
import '../../domain/usecases/get_recommend_output.dart';

class RecommendOutputProvider with ChangeNotifier {
  final GetComputerProgramFit getComputerProgramFit;
  final GetBottleneckCPUVGA getBottleneckCPUVGA;
  final GetRecommendOutput getRecommendOutput;
  final GetComputerCPU getComputerCPU;
  final GetComputerVGA getComputerVGA;
  final GetComputerRAM getComputerRAM;
  final GetComputerMainBoard getComputerMainBoard;
  final GetComputerSSD getComputerSSD;
  final GetComputerHDD getComputerHDD;
  final GetComputerCooler getComputerCooler;
  final GetComputerPower getComputerPower;
  final GetComputerCase getComputerCase;
  final GetComputerMonitor getComputerMonitor;
  final GetComputerKeyboard getComputerKeyboard;
  final GetComputerMouse getComputerMouse;

  RecommendOutputProvider(
      this.getComputerProgramFit,
      this.getBottleneckCPUVGA,
      this.getRecommendOutput,
      this.getComputerCPU,
      this.getComputerVGA,
      this.getComputerRAM,
      this.getComputerMainBoard,
      this.getComputerSSD,
      this.getComputerHDD,
      this.getComputerCooler,
      this.getComputerPower,
      this.getComputerCase,
      this.getComputerMonitor,
      this.getComputerKeyboard,
      this.getComputerMouse);

  late Future<List<RecommendOutput>> results;
  List<Future<ComputerCPU>> cpu = [];
  List<Future<ComputerVGA>> vga = [];
  List<Future<ComputerRAM>> ram = [];
  List<Future<ComputerMainBoard>> mainboard = [];
  List<Future<ComputerSSD>> ssd = [];
  List<Future<ComputerHDD>> hdd = [];
  List<Future<ComputerCooler>> cooler = [];
  List<Future<ComputerPower>> power = [];
  List<Future<ComputerCase>> ccase = [];
  List<Future<ComputerMonitor>> monitor = [];
  List<Future<ComputerKeyboard>> keyboard = [];
  List<Future<ComputerMouse>> mouse = [];
  List<Future<double>> bottleneck = [];
  List<Future<List<ProgramFit>>> programFit = [];
  List<Future<int>> totalPrice = [];

  void setRecommendOutputList(RecommendInput recommendInput) async {
    results = getRecommendOutput(recommendInput);
    results.then((value) {
      List<RecommendOutput> r = value;
      for (int i = 0; i < r.length; ++i) {
        cpu.add(r[i].numCpu > 0
            ? getComputerCPU(r[i].cpuId)
            : Future.value(NoCPU()));
        vga.add(r[i].numVga > 0
            ? getComputerVGA(r[i].vgaId)
            : Future.value(NoVGA()));
        ram.add(r[i].numRam > 0
            ? getComputerRAM(r[i].ramId)
            : Future.value(NoRAM()));
        mainboard.add(r[i].numMainboard > 0
            ? getComputerMainBoard(r[i].mainboardId)
            : Future.value(NoMainBoard()));
        ssd.add(r[i].numSsd > 0
            ? getComputerSSD(r[i].ssdId)
            : Future.value(NoSSD()));
        hdd.add(r[i].numHdd > 0
            ? getComputerHDD(r[i].hddId)
            : Future.value(NoHDD()));
        cooler.add(r[i].numCooler > 0
            ? getComputerCooler(r[i].coolerId)
            : Future.value(NoCooler()));
        power.add(r[i].numPower > 0
            ? getComputerPower(r[i].powerId)
            : Future.value(NoPower()));
        ccase.add(r[i].numCase > 0
            ? getComputerCase(r[i].caseId)
            : Future.value(NoCase()));
        monitor.add(r[i].numMonitor > 0
            ? getComputerMonitor(r[i].monitorId)
            : Future.value(NoMonitor()));
        keyboard.add(r[i].numKeyboard > 0
            ? getComputerKeyboard(r[i].keyboardId)
            : Future.value(NoKeyboard()));
        mouse.add(r[i].numMouse > 0
            ? getComputerMouse(r[i].mouseId)
            : Future.value(NoMouse()));
        bottleneck.add(Future.wait([cpu.last, vga.last]).then((value) {
          return getBottleneckCPUVGA(value[0].id, value[1].id);
        }));
        programFit.add(vga.last.then((value) {
          return getComputerProgramFit(value.id, recommendInput.purpose);
        }));
        totalPrice.add(Future.wait([
          cpu.last,
          vga.last,
          ram.last,
          mainboard.last,
          ssd.last,
          hdd.last,
          cooler.last,
          power.last,
          ccase.last,
          monitor.last,
          keyboard.last,
          mouse.last
        ]).then(((value) {
          int total = 0;
          for (ComputerItem e in value) {
            total += e.cheapPrice;
          }
          return total;
        })));
      }
    });
  }

  int _viewIndex = 0;
  int get viewIndex => _viewIndex;
  set viewIndex(int value) {
    _viewIndex = value;
    notifyListeners();
  }

  void setPartsCPUNum(int cnt) {
    results.then((value) {
      value[viewIndex].numCpu = cnt;
      if (cnt == 0) {
        value[viewIndex].cpuId = 0;
        cpu[viewIndex] = Future.value(NoCPU());
      }
    });
    totalPrice[viewIndex] = Future.wait([
      cpu[viewIndex],
      vga[viewIndex],
      ram[viewIndex],
      mainboard[viewIndex],
      ssd[viewIndex],
      hdd[viewIndex],
      cooler[viewIndex],
      power[viewIndex],
      ccase[viewIndex],
      monitor[viewIndex],
      keyboard[viewIndex],
      mouse[viewIndex],
    ]).then(((value) {
      int total = 0;
      for (ComputerItem e in value) {
        total += e.cheapPrice;
      }
      return total;
    }));
    notifyListeners();
  }

  void setPartsVGANum(int cnt) {
    results.then((value) {
      value[viewIndex].numVga = cnt;
      if (cnt == 0) {
        value[viewIndex].vgaId = 0;
        vga[viewIndex] = Future.value(NoVGA());
      }
    });
    notifyListeners();
  }

  void setPartsRAMNum(int cnt) {
    results.then((value) {
      value[viewIndex].numRam = cnt;
      if (cnt == 0) {
        value[viewIndex].ramId = 0;
        ram[viewIndex] = Future.value(NoRAM());
      }
    });
    notifyListeners();
  }

  void setPartsMainboardNum(int cnt) {
    results.then((value) {
      value[viewIndex].numMainboard = cnt;
      if (cnt == 0) {
        value[viewIndex].mainboardId = 0;
        mainboard[viewIndex] = Future.value(NoMainBoard());
      }
    });
    notifyListeners();
  }

  void setPartsSSDNum(int cnt) {
    results.then((value) {
      value[viewIndex].numSsd = cnt;
      if (cnt == 0) {
        value[viewIndex].ssdId = 0;
        ssd[viewIndex] = Future.value(NoSSD());
      }
    });
    notifyListeners();
  }

  void setPartsHDDNum(int cnt) {
    results.then((value) {
      value[viewIndex].numHdd = cnt;
      if (cnt == 0) {
        value[viewIndex].hddId = 0;
        hdd[viewIndex] = Future.value(NoHDD());
      }
    });
    notifyListeners();
  }

  void setPartsCoolerNum(int cnt) {
    results.then((value) {
      value[viewIndex].numCooler = cnt;
      if (cnt == 0) {
        value[viewIndex].coolerId = 0;
        cooler[viewIndex] = Future.value(NoCooler());
      }
    });
    notifyListeners();
  }

  void setPartsPowerNum(int cnt) {
    results.then((value) {
      value[viewIndex].numPower = cnt;
      if (cnt == 0) {
        value[viewIndex].powerId = 0;
        power[viewIndex] = Future.value(NoPower());
      }
    });
    notifyListeners();
  }

  void setPartsCaseNum(int cnt) {
    results.then((value) {
      value[viewIndex].numCase = cnt;
      if (cnt == 0) {
        value[viewIndex].caseId = 0;
        ccase[viewIndex] = Future.value(NoCase());
      }
    });
    notifyListeners();
  }

  void setPartsMonitorNum(int cnt) {
    results.then((value) {
      value[viewIndex].numMonitor = cnt;
      if (cnt == 0) {
        value[viewIndex].monitorId = 0;
        monitor[viewIndex] = Future.value(NoMonitor());
      }
    });
    notifyListeners();
  }

  void setPartsKeyboardNum(int cnt) {
    results.then((value) {
      value[viewIndex].numKeyboard = cnt;
      if (cnt == 0) {
        value[viewIndex].keyboardId = 0;
        keyboard[viewIndex] = Future.value(NoKeyboard());
      }
    });
    notifyListeners();
  }

  void setPartsMouseNum(int cnt) {
    results.then((value) {
      value[viewIndex].numMouse = cnt;
      if (cnt == 0) {
        value[viewIndex].mouseId = 0;
        mouse[viewIndex] = Future.value(NoMouse());
      }
    });
    notifyListeners();
  }
}
