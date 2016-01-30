# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

project1 = Project.create(name: 'Webshop',
                          description: 'Dies ist ein Webshop',
                          startdate: Date.new(2016, 1, 7))
project2 = Project.create(name: 'Brücke',
                          description: 'Dies ist eine Brücke',
                          startdate: Date.new(2016, 1, 7))

node100 = Node.create(name: 'Brücke',
                    description: 'Dies ist eine Brücke',
                    level: 0,
                    duration: 200,
                    startdate: Date.new(2016,1,7),
                    enddate: Date.new(2016,7,25),
                    milestone: true,
                    project: project2)
node1 = Node.create(name: 'WebShop',
                    description: 'Dies ist ein Webshop',
                    level: 0,
                    duration: 200,
                    startdate: Date.new(2016,1,7),
                    enddate: Date.new(2016,7,25),
                    milestone: true,
                    project: project1)
node2 = Node.create(name: 'Geschäftsplan und Architektur',
                    description: '',
                    level: 1,
                    duration: 30,
                    startdate: Date.new(2016,1,7),
                    enddate: Date.new(2016,2,6),
                    milestone: true,
                    project: project1,
                    parent: node1)
node3 = Node.create(name: 'Geschäftsplan',
                    description: '',
                    level: 2,
                    duration: 29,
                    startdate: Date.new(2016,1,7),
                    enddate: Date.new(2016,2,5),
                    milestone: false,
                    project: project1,
                    parent: node2)
node4 = Node.create(name: 'Business Case',
                    description: '',
                    level: 3,
                    duration: 10,
                    startdate: Date.new(2016,1,7),
                    enddate: Date.new(2016,1,17),
                    milestone: false,
                    project: project1,
                    parent: node3)
node5 = Node.create(name: 'Projektplan',
                    description: '',
                    level: 3,
                    duration: 10,
                    startdate: Date.new(2016,1,17),
                    enddate: Date.new(2016,1,27),
                    milestone: false,
                    project: project1,
                    parent: node3)
node6 = Node.create(name: 'Lastenheft',
                    description: '',
                    level: 3,
                    duration: 29,
                    startdate: Date.new(2016,1,7),
                    enddate: Date.new(2016,2,5),
                    milestone: false,
                    project: project1,
                    parent: node3)
node7 = Node.create(name: 'Architektur',
                    description: '',
                    level: 2,
                    duration: 30,
                    startdate: Date.new(2016,1,7),
                    enddate: Date.new(2016,2,6),
                    milestone: false,
                    project: project1,
                    parent: node2)
node8 = Node.create(name: 'Anwendungsarchitektur',
                    description: '',
                    level: 3,
                    duration: 30,
                    startdate: Date.new(2016,1,7),
                    enddate: Date.new(2016,2,6),
                    milestone: false,
                    project: project1,
                    parent: node7)
node9 = Node.create(name: 'Technische Architektur',
                    description: '',
                    level: 3,
                    duration: 30,
                    startdate: Date.new(2016,1,7),
                    enddate: Date.new(2016,2,6),
                    milestone: false,
                    project: project1,
                    parent: node7)
node10 = Node.create(name: 'Kunden- und Produktverwaltung',
                    description: '',
                    level: 1,
                    duration: 100,
                    startdate: Date.new(2016,2,7),
                    enddate: Date.new(2016,5,18),
                    milestone: true,
                    project: project1,
                    parent: node1)
node11 = Node.create(name: 'Kundendatenbank',
                     description: '',
                     level: 2,
                     duration: 100,
                     startdate: Date.new(2016,2,7),
                     enddate: Date.new(2016,5,18),
                     milestone: false,
                     project: project1,
                     parent: node10)
node12 = Node.create(name: 'Kundenstammdaten',
                     description: '',
                     level: 3,
                     duration: 100,
                     startdate: Date.new(2016,2,7),
                     enddate: Date.new(2016,5,18),
                     milestone: false,
                     project: project1,
                     parent: node11)
node13 = Node.create(name: 'Kundenbewegungsdaten',
                     description: '',
                     level: 3,
                     duration: 100,
                     startdate: Date.new(2016,2,7),
                     enddate: Date.new(2016,5,18),
                     milestone: false,
                     project: project1,
                     parent: node11)
node14  = Node.create(name: 'Produktkatalog',
                     description: '',
                     level: 2,
                     duration: 100,
                     startdate: Date.new(2016,2,7),
                     enddate: Date.new(2016,5,18),
                     milestone: false,
                     project: project1,
                     parent: node10)
node15 = Node.create(name: 'Produktstammdaten',
                     description: '',
                     level: 3,
                     duration: 100,
                     startdate: Date.new(2016,2,7),
                     enddate: Date.new(2016,5,18),
                     milestone: false,
                     project: project1,
                     parent: node14)
node16 = Node.create(name: 'Produktpreisliste',
                     description: '',
                     level: 3,
                     duration: 100,
                     startdate: Date.new(2016,2,7),
                     enddate: Date.new(2016,5,18),
                     milestone: false,
                     project: project1,
                     parent: node14)
node17 = Node.create(name: 'Transaktionsverwaltung',
                     description: '',
                     level: 1,
                     duration: 67,
                     startdate: Date.new(2016,5,19),
                     enddate: Date.new(2016,7,25),
                     milestone: true,
                     project: project1,
                     parent: node1)
node18 = Node.create(name: 'Auftragsverwaltung',
                     description: '',
                     level: 2,
                     duration: 67,
                     startdate: Date.new(2016,5,19),
                     enddate: Date.new(2016,7,25),
                     milestone: false,
                     project: project1,
                     parent: node17)
node19 = Node.create(name: 'Warenkorb',
                     description: '',
                     level: 3,
                     duration: 67,
                     startdate: Date.new(2016,5,19),
                     enddate: Date.new(2016,7,25),
                     milestone: false,
                     project: project1,
                     parent: node18)
node20 = Node.create(name: 'Auftragsprüfung und -bestätigung',
                     description: '',
                     level: 3,
                     duration: 67,
                     startdate: Date.new(2016,5,19),
                     enddate: Date.new(2016,7,25),
                     milestone: false,
                     project: project1,
                     parent: node18)
node21 = Node.create(name: 'Warenwirtschaftsverwaltung',
                     description: '',
                     level: 2,
                     duration: 67,
                     startdate: Date.new(2016,5,19),
                     enddate: Date.new(2016,7,25),
                     milestone: false,
                     project: project1,
                     parent: node17)
node22 = Node.create(name: 'Schnittstelle Lagerverwaltung',
                     description: '',
                     level: 3,
                     duration: 67,
                     startdate: Date.new(2016,5,19),
                     enddate: Date.new(2016,7,25),
                     milestone: false,
                     project: project1,
                     parent: node21)
node23 = Node.create(name: 'Schnittstelle Bestellwesen',
                     description: '',
                     level: 3,
                     duration: 67,
                     startdate: Date.new(2016,5,19),
                     enddate: Date.new(2016,7,25),
                     milestone: false,
                     project: project1,
                     parent: node21)
node24 = Node.create(name: 'Rechnungs- und Zahlungsverwwaltung',
                     description: '',
                     level: 2,
                     duration: 67,
                     startdate: Date.new(2016,5,19),
                     enddate: Date.new(2016,7,25),
                     milestone: false,
                     project: project1,
                     parent: node17)
node25 = Node.create(name: 'Electronic Bill Presentment',
                     description: '',
                     level: 3,
                     duration: 67,
                     startdate: Date.new(2016,5,19),
                     enddate: Date.new(2016,7,25),
                     milestone: false,
                     project: project1,
                     parent: node24)
node26 = Node.create(name: 'Electronic Payments',
                     description: '',
                     level: 3,
                     duration: 67,
                     startdate: Date.new(2016,5,19),
                     enddate: Date.new(2016,7,25),
                     milestone: false,
                     project: project1,
                     parent: node24)
node27 = Node.create(name: 'Schnittstelle Finanzbuchhaltung',
                     description: '',
                     level: 3,
                     duration: 67,
                     startdate: Date.new(2016,5,19),
                     enddate: Date.new(2016,7,25),
                     milestone: false,
                     project: project1,
                     parent: node24)

wp100 = Workpackage.create(name: 'Brücke',
                         description: '',
                         level: 0,
                         duration: 0,
                         project: project2)
wp1 = Workpackage.create(name: 'WebShop',
                         description: 'Dies ist eine Aufgabe für den Webshop',
                         level: 0,
                         duration: 0,
                         project: project1)
wp2 = Workpackage.create(name: 'Projektmanagement',
                         description: 'Aufgaben zum Projektmanagement',
                         level: 1,
                         duration: 0,
                         project: project1,
                         parent: wp1)
wp3 = Workpackage.create(name: 'Geschäftsmodellierung',
                         description: '',
                         level: 2,
                         duration: 0,
                         project: project1,
                         parent: wp2)
wp4 = Workpackage.create(name: 'Wirtschaftlichkeitsrechnung erstellen',
                         description: '',
                         level: 3,
                         duration: 0,
                         project: project1,
                         parent: wp3)
wp5 = Workpackage.create(name: 'Lastenheft erstellen',
                         description: '',
                         level: 3,
                         duration: 0,
                         project: project1,
                         parent: wp3)
wp6 = Workpackage.create(name: 'Projektplanung',
                         description: '',
                         level: 2,
                         duration: 0,
                         project: project1,
                         parent: wp2)
wp7 = Workpackage.create(name: 'Ablauf- und Terminplaunung',
                         description: '',
                         level: 3,
                         duration: 0,
                         project: project1,
                         parent: wp6)
wp8 = Workpackage.create(name: 'Einsatzmittel- und Kostenplaunung',
                         description: '',
                         level: 3,
                         duration: 0,
                         project: project1,
                         parent: wp6)
wp9 = Workpackage.create(name: 'Projektüberwachung und -steuerung',
                         description: '',
                         level: 2,
                         duration: 0,
                         project: project1,
                         parent: wp2)
wp10 = Workpackage.create(name: 'Projektcontrolling',
                         description: '',
                         level: 3,
                         duration: 0,
                         project: project1,
                         parent: wp9)
wp11 = Workpackage.create(name: 'Inhalte-, Änderungens-, Risikomanagement',
                          description: '',
                          level: 3,
                          duration: 0,
                          project: project1,
                          parent: wp9)
wp12 = Workpackage.create(name: 'Definition und Entwurf',
                         description: 'Aufgaben für den Entwurf',
                         level: 1,
                         duration: 0,
                         project: project1,
                         parent: wp1)
wp13 = Workpackage.create(name: 'Funktionale Architektur',
                         description: '',
                         level: 2,
                         duration: 0,
                         project: project1,
                         parent: wp12)
wp14 = Workpackage.create(name: 'Funktionen- und GUI-Modellierung',
                          description: '',
                          level: 3,
                          duration: 0,
                          project: project1,
                          parent: wp13)
wp15 = Workpackage.create(name: 'Prozess- und Datenmodellierung',
                          description: '',
                          level: 3,
                          duration: 0,
                          project: project1,
                          parent: wp13)
wp16 = Workpackage.create(name: 'Anwendungsarchitektur',
                          description: '',
                          level: 2,
                          duration: 0,
                          project: project1,
                          parent: wp12)
wp17 = Workpackage.create(name: 'Komponenten auswählen und definieren',
                          description: '',
                          level: 3,
                          duration: 0,
                          project: project1,
                          parent: wp16)
wp18 = Workpackage.create(name: 'Software-Systemarchitektur festlegen',
                          description: '',
                          level: 3,
                          duration: 0,
                          project: project1,
                          parent: wp16)
wp19 = Workpackage.create(name: 'Implementierung Software',
                          description: '',
                          level: 1,
                          duration: 0,
                          project: project1,
                          parent: wp1)
wp20 = Workpackage.create(name: 'Datenbankentwicklung',
                          description: '',
                          level: 2,
                          duration: 0,
                          project: project1,
                          parent: wp19)
wp21 = Workpackage.create(name: 'Datenbankdesign',
                          description: '',
                          level: 3,
                          duration: 0,
                          project: project1,
                          parent: wp20)
wp22 = Workpackage.create(name: 'Datenbankimplementierung',
                          description: '',
                          level: 3,
                          duration: 0,
                          project: project1,
                          parent: wp20)
wp23 = Workpackage.create(name: 'Softwareentwicklung',
                          description: '',
                          level: 2,
                          duration: 0,
                          project: project1,
                          parent: wp19)
wp24 = Workpackage.create(name: 'Komponentenentwicklung',
                          description: '',
                          level: 3,
                          duration: 0,
                          project: project1,
                          parent: wp23)
wp25 = Workpackage.create(name: 'Komponententest und -integration',
                          description: '',
                          level: 3,
                          duration: 0,
                          project: project1,
                          parent: wp23)
wp26 = Workpackage.create(name: 'Test',
                          description: '',
                          level: 2,
                          duration: 0,
                          project: project1,
                          parent: wp19)
wp27 = Workpackage.create(name: 'Integrationstest',
                          description: '',
                          level: 3,
                          duration: 0,
                          project: project1,
                          parent: wp26)
wp28 = Workpackage.create(name: 'Lasttest',
                          description: '',
                          level: 3,
                          duration: 0,
                          project: project1,
                          parent: wp26)

r100 = Role.create(name: "Brücke",
                 description: "",
                 project: project2,
                 level: 0)
r1 = Role.create(name: "Webshop",
                 description: "",
                 project: project1,
                 level: 0)
r2 = Role.create(name: "Intern",
                 description: "",
                 project: project1,
                 level: 1,
                 parent: r1)
r3 = Role.create(name: "Projektleiter",
                 description: "",
                 quantity: 1,
                 qualification: "PMP",
                 experience: ">3 Projektleitungen",
                 project: project1,
                 level: 2,
                 parent: r2)
r4 = Role.create(name: "projektcontroller",
                 description: "",
                 qualification: "Project Mgmt. Certificate",
                 experience: "Junior",
                 quantity: 1,
                 project: project1,
                 level: 2,
                 parent: r2)
r5 = Role.create(name: "Geschäftsanalytiker",
                 description: "",
                 qualification: "Business Analyst Certificate",
                 experience: ">3 Jahre Product Management",
                 project: project1,
                 quantity: 1,
                 level: 2,
                 parent: r2)
r6 = Role.create(name: "Systemanalytiker",
                 description: "",
                 qualification: "System Analyst Certificate",
                 experience: ">3 Jahre Software Engineering",
                 project: project1,
                 quantity: 1,
                 level: 2,
                 parent: r2)
r7 = Role.create(name: "Extern",
                 description: "",
                 project: project1,
                 level: 1,
                 parent: r1)
r8 = Role.create(name: "Entwicklungsleiter",
                 description: "",
                 qualification: "Level 400 Softw. Eng. Cert.",
                 experience: ">6 Jahre",
                 quantity: 1,
                 project: project1,
                 level: 2,
                 parent: r7)
r9 = Role.create(name: "Technischer Architekt",
                 description: "",
                 qualification: "Level 400 Softw. Eng. Cert.",
                 experience: ">6 Jahre",
                 quantity: 1,
                 project: project1,
                 level: 2,
                 parent: r7)
r10 = Role.create(name: "Datenbankentwickler",
                 description: "",
                 project: project1,
                 level: 2,
                 parent: r7)
r11 = Role.create(name: "Datenbankentwickler",
                 description: "",
                 qualification: "Level 200 Database Eng. C.",
                 experience: "",
                 quantity: 2,
                 project: project1,
                 level: 3,
                 parent: r10)
r12 = Role.create(name: "Datenbankentwickler",
                  description: "",
                  qualification: "Level 300 Database Eng. C.",
                  experience: ">3 Jahre",
                  quantity: 2,
                  project: project1,
                  level: 3,
                  parent: r10)
r13 = Role.create(name: "Softwareentwickler",
                  description: "",
                  project: project1,
                  level: 2,
                  parent: r7)
r14 = Role.create(name: "Softwareentwickler",
                  description: "",
                  qualification: "Level 200 Software Eng. Cert.",
                  experience: "",
                  quantity: 1,
                  project: project1,
                  level: 3,
                  parent: r13)
r15 = Role.create(name: "Softwareentwickler",
                  description: "",
                  qualification: "Level 300 Software Eng. Cert.",
                  experience: ">3 Jahre",
                  quantity: 3,
                  project: project1,
                  level: 3,
                  parent: r13)
r16 = Role.create(name: "Softwareentwickler",
                  description: "",
                  qualification: "Level 400 Software Eng. Cert.",
                  experience: ">6 Jahre",
                  quantity: 3,
                  project: project1,
                  level: 3,
                  parent: r13)
r17 = Role.create(name: "Netzwerkentwickler",
                  description: "",
                  project: project1,
                  level: 2,
                  parent: r7)
r18 = Role.create(name: "Netzwerkentwickler",
                  description: "",
                  qualification: "Level 200 Network Admin C.",
                  experience: "",
                  quantity: 1,
                  project: project1,
                  level: 3,
                  parent: r17)
r19 = Role.create(name: "Netzwerkentwickler",
                  description: "",
                  qualification: "Level 300 Network Admin C.",
                  experience: ">3 Jahre",
                  quantity: 1,
                  project: project1,
                  level: 3,
                  parent: r17)
r20 = Role.create(name: "Operator",
                  description: "",
                  project: project1,
                  level: 2,
                  parent: r7)
r21 = Role.create(name: "Operator",
                  description: "",
                  qualification: "Level 300 Data Center Ops C.",
                  experience: ">3 Jahre",
                  quantity: 1,
                  project: project1,
                  level: 3,
                  parent: r20)
r22 = Role.create(name: "Operator",
                  description: "",
                  qualification: "Level 400 Data Center Ops C.",
                  experience: ">6 Jahre",
                  quantity: 1,
                  project: project1,
                  level: 3,
                  parent: r20)


ram1 = Ram.create(project: project1,
                  node: node1,
                  workpackage: nil,
                  allocatable: false,
                  level: 0,
                  order: 1)
ram2 = Ram.create(project: project1,
                  node: node2,
                  workpackage: nil,
                  allocatable: false,
                  level: 1,
                  order: 2)
ram3 = Ram.create(project: project1,
                  node: node3,
                  workpackage: nil,
                  allocatable: false,
                  level: 2,
                  order: 3)
ram4 = Ram.create(project: project1,
                  node: node4,
                  workpackage: wp4,
                  allocatable: true,
                  level: 3,
                  order: 4)
ram5 = Ram.create(project: project1,
                  node: node5,
                  workpackage: wp7,
                  allocatable: true,
                  level: 3,
                  order: 5)
ram6 = Ram.create(project: project1,
                  node: node6,
                  workpackage: wp5,
                  allocatable: true,
                  level: 3,
                  order: 6)
ram7 = Ram.create(project: project1,
                  node: node7,
                  workpackage: nil,
                  allocatable: false,
                  level: 2,
                  order: 7)
ram8 = Ram.create(project: project1,
                  node: node8,
                  workpackage: wp17,
                  allocatable: true,
                  level: 3,
                  order: 8)
ram9 = Ram.create(project: project1,
                  node: node9,
                  workpackage: wp18,
                  allocatable: true,
                  level: 3,
                  order: 9)
ram10 = Ram.create(project: project1,
                  node: node10,
                  workpackage: nil,
                  allocatable: false,
                  level: 1,
                  order: 10)
ram11 = Ram.create(project: project1,
                  node: node11,
                  workpackage: nil,
                  allocatable: false,
                  level: 2,
                  order: 11)
ram12 = Ram.create(project: project1,
                  node: node12,
                  workpackage: wp21,
                  allocatable: true,
                  level: 3,
                  order: 12)
ram13 = Ram.create(project: project1,
                  node: node13,
                  workpackage: wp22,
                  allocatable: true,
                  level: 3,
                  order: 13)
ram14 = Ram.create(project: project1,
                  node: node14,
                  workpackage: nil,
                  allocatable: false,
                  level: 2,
                  order: 14)
ram15 = Ram.create(project: project1,
                  node: node15,
                  workpackage: wp8,
                  allocatable: true,
                  level: 3,
                  order: 15)
ram16 = Ram.create(project: project1,
                   node: node16,
                   workpackage: wp10,
                   allocatable: true,
                   level: 3,
                   order: 16)
ram17 = Ram.create(project: project1,
                   node: node17,
                   workpackage: nil,
                   allocatable: false,
                   level: 1,
                   order: 17)
ram18 = Ram.create(project: project1,
                   node: node18,
                   workpackage: nil,
                   allocatable: false,
                   level: 2,
                   order: 18)
ram19 = Ram.create(project: project1,
                   node: node19,
                   workpackage: wp14,
                   allocatable: true,
                   level: 3,
                   order: 19)
ram20 = Ram.create(project: project1,
                   node: node20,
                   workpackage: wp11,
                   allocatable: true,
                   level: 3,
                   order: 20)
ram21 = Ram.create(project: project1,
                   node: node21,
                   workpackage: nil,
                   allocatable: false,
                   level: 2,
                   order: 21)
ram22 = Ram.create(project: project1,
                   node: node22,
                   workpackage: wp24,
                   allocatable: true,
                   level: 3,
                   order: 22)
ram23 = Ram.create(project: project1,
                   node: node23,
                   workpackage: wp25,
                   allocatable: true,
                   level: 3,
                   order: 23)
ram24 = Ram.create(project: project1,
                   node: node24,
                   workpackage: nil,
                   allocatable: false,
                   level: 2,
                   order: 24)
ram25 = Ram.create(project: project1,
                   node: node25,
                   workpackage: wp15,
                   allocatable: true,
                   level: 3,
                   order: 25)
ram26 = Ram.create(project: project1,
                   node: node26,
                   workpackage: wp27,
                   allocatable: true,
                   level: 3,
                   order: 26)
ram27 = Ram.create(project: project1,
                   node: node27,
                   workpackage: wp28,
                   allocatable: true,
                   level: 3,
                   order: 27)



ram4.roles << r5
ram5.roles << r5
ram6.roles << r3
ram6.roles << r4
ram8.roles << r6
ram9.roles << r8
ram12.roles << r9
ram13.roles << r11
ram15.roles << r11
ram15.roles << r12
ram16.roles << r14
ram16.roles << r15
ram16.roles << r16
ram19.roles << r18
ram20.roles << r18
ram22.roles << r19
ram23.roles << r19
ram25.roles << r19
ram26.roles << r21
ram27.roles << r22