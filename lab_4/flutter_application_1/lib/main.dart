// Lab6: Managing State in Flutter - Single-file implementation
// Put this file in lib/main.dart
// Add to pubspec.yaml:
//   dependencies:
//     flutter:
//       sdk: flutter
//     provider: ^6.0.5

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ---------------------------
// Provider Models
// ---------------------------
class CounterModel extends ChangeNotifier {
  int _count = 0;
  int get count => _count;
  void increment() { _count++; notifyListeners(); }
  void decrement() { _count--; notifyListeners(); }
  void reset() { _count = 0; notifyListeners(); }
}

class UserModel extends ChangeNotifier {
  String _username = 'Guest';
  String get username => _username;
  void changeToAdmin() { _username = 'Admin'; notifyListeners(); }
  void setName(String name) { _username = name; notifyListeners(); }
}

class ThemeModel extends ChangeNotifier {
  bool _isDark = false;
  bool get isDark => _isDark;
  void toggle() { _isDark = !_isDark; notifyListeners(); }
}

class TodoListModel extends ChangeNotifier {
  final List<String> _tasks = [];
  List<String> get tasks => List.unmodifiable(_tasks);
  void addTask(String t) { _tasks.add(t); notifyListeners(); }
  void removeTask(int i) { _tasks.removeAt(i); notifyListeners(); }
}

class CartModel extends ChangeNotifier {
  final List<String> _items = [];
  List<String> get items => List.unmodifiable(_items);
  void add(String product) { _items.add(product); notifyListeners(); }
  void removeAt(int i) { _items.removeAt(i); notifyListeners(); }
}

class AsyncFakeModel extends ChangeNotifier {
  bool _isLoading = false;
  String _data = '';
  bool get isLoading => _isLoading;
  String get data => _data;
  Future<void> fetch() async {
    _isLoading = true; notifyListeners();
    await Future.delayed(const Duration(seconds: 2));
    _data = 'Fetched data at ${DateTime.now()}';
    _isLoading = false; notifyListeners();
  }
}

class SettingsModel extends ChangeNotifier {
  bool notificationsEnabled = true;
  double volume = 0.5;
  void setNotifications(bool v) { notificationsEnabled = v; notifyListeners(); }
  void setVolume(double v) { volume = v; notifyListeners(); }
}

// ---------------------------
// Main
// ---------------------------
void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CounterModel()),
        ChangeNotifierProvider(create: (_) => UserModel()),
        ChangeNotifierProvider(create: (_) => ThemeModel()),
        ChangeNotifierProvider(create: (_) => TodoListModel()),
        ChangeNotifierProvider(create: (_) => CartModel()),
        ChangeNotifierProvider(create: (_) => AsyncFakeModel()),
        ChangeNotifierProvider(create: (_) => SettingsModel()),
      ],
      child: const Lab6App(),
    ),
  );
}

class Lab6App extends StatelessWidget {
  const Lab6App({super.key});

  @override
  Widget build(BuildContext context) {
    final themeModel = context.watch<ThemeModel>();
    return MaterialApp(
      title: 'Lab 6 - State Management',
      theme: themeModel.isDark ? ThemeData.dark() : ThemeData.light(),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// ---------------------------
// Home / Navigation
// ---------------------------
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final items = <Map<String, dynamic>>[
      {'title': 'Section 1 - Concept & Widgets', 'route': Section1Screen()},
      {'title': 'Section 2 - setState examples', 'route': Section2Screen()},
      {'title': 'Section 3 - Lifting State Up', 'route': Section3Screen()},
      {'title': 'Section 4 - Provider / Advanced', 'route': Section4Screen()},
      {'title': 'Section 5 - Optional Scenarios', 'route': Section5Screen()},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Lab 6 - State Management (All Tasks)')),
      body: ListView.separated(
        padding: const EdgeInsets.all(12),
        itemCount: items.length,
        separatorBuilder: (_, __) => const Divider(),
        itemBuilder: (context, i) {
          return ListTile(
            title: Text(items[i]['title']),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => items[i]['route'])),
          );
        },
      ),
    );
  }
}

// ---------------------------
// Section 1 Widgets (Understanding State)
// ---------------------------
class Section1Screen extends StatelessWidget {
  const Section1Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Section 1 - Concept of State')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: const [
            StaticProfileCard(),
            SizedBox(height: 12),
            InteractiveProfileCard(),
            SizedBox(height: 12),
            ProductCard(productName: 'Notebook', price: 9.99),
            SizedBox(height: 12),
            LikeButtonInteractive(),
            SizedBox(height: 12),
            NameFormWidget(),
          ],
        ),
      ),
    );
  }
}

class StaticProfileCard extends StatelessWidget {
  const StaticProfileCard({super.key});
  @override
  Widget build(BuildContext context) {
    return const Card(
      child: ListTile(
        leading: Icon(Icons.person),
        title: Text('John Doe'),
        subtitle: Text('john.doe@email.com'),
      ),
    );
  }
}

class InteractiveProfileCard extends StatefulWidget {
  const InteractiveProfileCard({super.key});
  @override
  State<InteractiveProfileCard> createState() => _InteractiveProfileCardState();
}
class _InteractiveProfileCardState extends State<InteractiveProfileCard> {
  @override
  Widget build(BuildContext context) {
    return const Card(
      child: ListTile(
        leading: Icon(Icons.person_outline),
        title: Text('Jane Smith'),
        subtitle: Text('jane.smith@email.com'),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final String productName;
  final double price;
  const ProductCard({super.key, required this.productName, required this.price});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.shopping_bag),
        title: Text(productName),
        subtitle: Text('\$${price.toStringAsFixed(2)}'),
      ),
    );
  }
}

// LikeButton: Task 3 & 4 combined - interactive
class LikeButtonInteractive extends StatefulWidget {
  const LikeButtonInteractive({super.key});
  @override
  State<LikeButtonInteractive> createState() => _LikeButtonInteractiveState();
}
class _LikeButtonInteractiveState extends State<LikeButtonInteractive> {
  bool _isLiked = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: const Text('Like Button (tap icon)'),
        trailing: IconButton(
          icon: Icon(_isLiked ? Icons.favorite : Icons.favorite_border),
          onPressed: () => setState(() => _isLiked = !_isLiked),
        ),
      ),
    );
  }
}

// Task 5: TextFormField and show live _userName
class NameFormWidget extends StatefulWidget {
  const NameFormWidget({super.key});
  @override
  State<NameFormWidget> createState() => _NameFormWidgetState();
}
class _NameFormWidgetState extends State<NameFormWidget> {
  String _userName = '';
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('Enter your name:'),
            TextFormField(
              onChanged: (v) => setState(() => _userName = v),
              decoration: const InputDecoration(hintText: 'Name'),
            ),
            const SizedBox(height: 8),
            Text('You typed: $_userName'),
          ],
        ),
      ),
    );
  }
}

// ---------------------------
// Section 2 - setState examples
// ---------------------------
class Section2Screen extends StatelessWidget {
  const Section2Screen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Section 2 - setState')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(children: const [
          CounterPageLocal(),
          SizedBox(height: 12),
          CounterWithDecrement(),
          SizedBox(height: 12),
          VisibilityToggleWidget(),
          SizedBox(height: 12),
          ItemsListWidget(),
          SizedBox(height: 12),
          ColorBoxWidget(),
        ]),
      ),
    );
  }
}

// Task 1: Counter (local)
class CounterPageLocal extends StatefulWidget {
  const CounterPageLocal({super.key});
  @override
  State<CounterPageLocal> createState() => _CounterPageLocalState();
}
class _CounterPageLocalState extends State<CounterPageLocal> {
  int _counter = 0;
  void _increment() => setState(() => _counter++);
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text('Local Counter: $_counter', style: Theme.of(context).textTheme.titleLarge),
        trailing: FloatingActionButton.small(onPressed: _increment, child: const Icon(Icons.add)),
      ),
    );
  }
}

// Task 2: Counter with decrement (two FABs shown inline)
class CounterWithDecrement extends StatefulWidget {
  const CounterWithDecrement({super.key});
  @override
  State<CounterWithDecrement> createState() => _CounterWithDecrementState();
}
class _CounterWithDecrementState extends State<CounterWithDecrement> {
  int _count = 0;
  void _inc() => setState(() => _count++);
  void _dec() => setState(() => _count--);
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Count: $_count', style: Theme.of(context).textTheme.titleLarge),
            Row(children: [
              IconButton(onPressed: _dec, icon: const Icon(Icons.remove)),
              IconButton(onPressed: _inc, icon: const Icon(Icons.add)),
            ])
          ],
        ),
      ),
    );
  }
}

// Task 3: Visibility toggle
class VisibilityToggleWidget extends StatefulWidget {
  const VisibilityToggleWidget({super.key});
  @override
  State<VisibilityToggleWidget> createState() => _VisibilityToggleWidgetState();
}
class _VisibilityToggleWidgetState extends State<VisibilityToggleWidget> {
  bool _isVisible = true;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(children: [
          ElevatedButton(onPressed: () => setState(() => _isVisible = !_isVisible), child: const Text('Toggle')),
          const SizedBox(height: 8),
          if (_isVisible) const Text('This text is visible'),
        ]),
      ),
    );
  }
}

// Task 4: List add with TextField
class ItemsListWidget extends StatefulWidget {
  const ItemsListWidget({super.key});
  @override
  State<ItemsListWidget> createState() => _ItemsListWidgetState();
}
class _ItemsListWidgetState extends State<ItemsListWidget> {
  final List<String> _items = [];
  final TextEditingController _ctrl = TextEditingController();
  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(children: [
          Row(children: [
            Expanded(child: TextField(controller: _ctrl, decoration: const InputDecoration(hintText: 'Add item'))),
            IconButton(onPressed: () {
              final v = _ctrl.text.trim();
              if (v.isEmpty) return;
              setState(() { _items.add(v); _ctrl.clear(); });
            }, icon: const Icon(Icons.add))
          ]),
          const SizedBox(height: 8),
          SizedBox(height: 150, child: ListView.builder(itemCount: _items.length, itemBuilder: (_, i) => ListTile(title: Text(_items[i]), trailing: IconButton(icon: const Icon(Icons.delete), onPressed: () => setState(() => _items.removeAt(i))))))
        ]),
      ),
    );
  }
}

// Task 5: Color Box
class ColorBoxWidget extends StatefulWidget {
  const ColorBoxWidget({super.key});
  @override
  State<ColorBoxWidget> createState() => _ColorBoxWidgetState();
}
class _ColorBoxWidgetState extends State<ColorBoxWidget> {
  Color _color = Colors.red;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(children: [
          Container(width: 200, height: 200, color: _color),
          const SizedBox(height: 8),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            ElevatedButton(onPressed: () => setState(() => _color = Colors.red), child: const Text('Red')),
            const SizedBox(width: 8),
            ElevatedButton(onPressed: () => setState(() => _color = Colors.green), child: const Text('Green')),
            const SizedBox(width: 8),
            ElevatedButton(onPressed: () => setState(() => _color = Colors.blue), child: const Text('Blue')),
          ])
        ]),
      ),
    );
  }
}

// ---------------------------
// Section 3 - Lifting State Up
// ---------------------------
class Section3Screen extends StatelessWidget {
  const Section3Screen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Section 3 - Lifting State Up')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(children: const [
          SwitchManager(),
          SizedBox(height: 12),
          GreetingParent(),
          SizedBox(height: 12),
          TemperatureConverterParent(),
          SizedBox(height: 12),
          SurveyWidget(),
          SizedBox(height: 12),
          PropDrillingCounter(),
        ]),
      ),
    );
  }
}

// Task 1: SwitchManager (solution included)
class SwitchManager extends StatefulWidget {
  const SwitchManager({super.key});
  @override
  State<SwitchManager> createState() => _SwitchManagerState();
}
class _SwitchManagerState extends State<SwitchManager> {
  bool _isActive = false;
  void _handleSwitchChanged(bool v) => setState(() => _isActive = v);
  @override
  Widget build(BuildContext context) {
    return Card(child: Padding(padding: const EdgeInsets.all(12), child: Column(children: [Text('The Switch is: ${_isActive ? 'ON' : 'OFF'}'), InteractiveSwitch(isActive: _isActive, onChanged: _handleSwitchChanged)])));
  }
}
class InteractiveSwitch extends StatelessWidget {
  final bool isActive;
  final ValueChanged<bool> onChanged;
  const InteractiveSwitch({super.key, required this.isActive, required this.onChanged});
  @override
  Widget build(BuildContext context) => Switch(value: isActive, onChanged: onChanged);
}

// Task 2: Greeting - parent holds name
class GreetingParent extends StatefulWidget {
  const GreetingParent({super.key});
  @override
  State<GreetingParent> createState() => _GreetingParentState();
}
class _GreetingParentState extends State<GreetingParent> {
  String _name = 'Guest';
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Greeting(name: _name),
          const SizedBox(height: 8),
          ElevatedButton(onPressed: () => setState(() => _name = 'Alice'), child: const Text('Set Alice'))
        ]),
      ),
    );
  }
}
class Greeting extends StatelessWidget {
  final String name;
  const Greeting({super.key, required this.name});
  @override
  Widget build(BuildContext context) => Text('Hello, $name', style: Theme.of(context).textTheme.titleLarge);
}

// Task 3: TemperatureConverter
class TemperatureConverterParent extends StatefulWidget {
  const TemperatureConverterParent({super.key});
  @override
  State<TemperatureConverterParent> createState() => _TemperatureConverterParentState();
}
class _TemperatureConverterParentState extends State<TemperatureConverterParent> {
  double _celsius = 0.0;
  void _updateCelsius(double v) => setState(() => _celsius = v);
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(padding: const EdgeInsets.all(12), child: Column(children: [CelsiusInput(onChanged: _updateCelsius), const SizedBox(height: 8), FahrenheitDisplay(celsius: _celsius)])),
    );
  }
}
class CelsiusInput extends StatelessWidget {
  final ValueChanged<double> onChanged;
  const CelsiusInput({super.key, required this.onChanged});
  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(labelText: 'Celsius'),
      onChanged: (s) {
        final v = double.tryParse(s) ?? 0.0;
        onChanged(v);
      },
    );
  }
}
class FahrenheitDisplay extends StatelessWidget {
  final double celsius;
  const FahrenheitDisplay({super.key, required this.celsius});
  @override
  Widget build(BuildContext context) {
    final f = celsius * 9 / 5 + 32;
    return Text('Fahrenheit: ${f.toStringAsFixed(2)}');
  }
}

// Task 4: Survey slider
class SurveyWidget extends StatefulWidget {
  const SurveyWidget({super.key});
  @override
  State<SurveyWidget> createState() => _SurveyWidgetState();
}
class _SurveyWidgetState extends State<SurveyWidget> {
  double _satisfaction = 5.0;
  @override
  Widget build(BuildContext context) {
    String msg;
    if (_satisfaction < 3) msg = 'Awful';
    else if (_satisfaction < 7) msg = 'Okay';
    else msg = 'Great!';
    return Card(child: Padding(padding: const EdgeInsets.all(12), child: Column(children: [Text('Satisfaction: ${_satisfaction.toStringAsFixed(1)}'), Slider(value: _satisfaction, min: 0, max: 10, onChanged: (v) => setState(() => _satisfaction = v)), Text(msg)])));
  }
}

// Task 5: Prop drilling (grandparent -> parent -> child)
class PropDrillingCounter extends StatefulWidget {
  const PropDrillingCounter({super.key});
  @override
  State<PropDrillingCounter> createState() => _PropDrillingCounterState();
}
class _PropDrillingCounterState extends State<PropDrillingCounter> {
  int _counter = 0;
  void _increment() => setState(() => _counter++);
  @override
  Widget build(BuildContext context) {
    return Card(child: Padding(padding: const EdgeInsets.all(12), child: Column(children: [Text('Grandparent count: $_counter'), ParentWidget(count: _counter, onIncrement: _increment)])));
  }
}
class ParentWidget extends StatelessWidget {
  final int count; final VoidCallback onIncrement;
  const ParentWidget({super.key, required this.count, required this.onIncrement});
  @override
  Widget build(BuildContext context) => ChildWidget(count: count, onIncrement: onIncrement);
}
class ChildWidget extends StatelessWidget {
  final int count; final VoidCallback onIncrement;
  const ChildWidget({super.key, required this.count, required this.onIncrement});
  @override
  Widget build(BuildContext context) => ElevatedButton(onPressed: onIncrement, child: Text('Increment (child) - currently $count'));
}

// ---------------------------
// Section 4 - Provider tasks
// ---------------------------
class Section4Screen extends StatelessWidget {
  const Section4Screen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Section 4 - Provider')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(children: const [
          ProviderCounterScreen(),
          SizedBox(height: 12),
          UserModelWidget(),
          SizedBox(height: 12),
          CounterExtendedWidget(),
          SizedBox(height: 12),
          ThemeSwitcherWidget(),
          SizedBox(height: 12),
          TodoListProviderWidget(),
        ]),
      ),
    );
  }
}

// Task 1: Counter with Provider
class ProviderCounterScreen extends StatelessWidget {
  const ProviderCounterScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final counter = context.watch<CounterModel>();
    return Card(child: ListTile(title: Text('Provider Counter: ${counter.count}'), trailing: FloatingActionButton.small(onPressed: () => context.read<CounterModel>().increment(), child: const Icon(Icons.add))));
  }
}

// Task 2: UserModel
class UserModelWidget extends StatelessWidget {
  const UserModelWidget({super.key});
  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserModel>();
    return Card(child: ListTile(title: Text('User: ${user.username}'), trailing: ElevatedButton(onPressed: () => context.read<UserModel>().changeToAdmin(), child: const Text('Make Admin'))));
  }
}

// Task 3: Extend Counter - decrement & reset
class CounterExtendedWidget extends StatelessWidget {
  const CounterExtendedWidget({super.key});
  @override
  Widget build(BuildContext context) {
    final counter = context.watch<CounterModel>();
    return Card(child: Padding(padding: const EdgeInsets.all(8), child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text('Count: ${counter.count}'),
      Row(children: [
        IconButton(onPressed: () => context.read<CounterModel>().decrement(), icon: const Icon(Icons.remove)),
        IconButton(onPressed: () => context.read<CounterModel>().increment(), icon: const Icon(Icons.add)),
        IconButton(onPressed: () => context.read<CounterModel>().reset(), icon: const Icon(Icons.refresh)),
      ])
    ])));
  }
}

// Task 4: Theme switching
class ThemeSwitcherWidget extends StatelessWidget {
  const ThemeSwitcherWidget({super.key});
  @override
  Widget build(BuildContext context) {
    final tm = context.watch<ThemeModel>();
    return Card(child: ListTile(title: const Text('Theme'), trailing: Switch(value: tm.isDark, onChanged: (_) => context.read<ThemeModel>().toggle())));
  }
}

// Task 5: TodoListModel
class TodoListProviderWidget extends StatelessWidget {
  const TodoListProviderWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Card(child: Padding(padding: const EdgeInsets.all(8), child: Column(children: [
      const Text('Todo List (Provider)'),
      Row(children: [Expanded(child: _TodoInput()), IconButton(onPressed: () => null, icon: const Icon(Icons.help_outline))]),
      SizedBox(height: 150, child: Consumer<TodoListModel>(builder: (context, model, _) => ListView.builder(itemCount: model.tasks.length, itemBuilder: (_, i) => ListTile(title: Text(model.tasks[i]), trailing: IconButton(icon: const Icon(Icons.delete), onPressed: () => model.removeTask(i))))))
    ])));
  }
}
class _TodoInput extends StatefulWidget {
  @override
  State<_TodoInput> createState() => _TodoInputState();
}
class _TodoInputState extends State<_TodoInput> {
  final TextEditingController _c = TextEditingController();
  @override
  void dispose() { _c.dispose(); super.dispose(); }
  @override
  Widget build(BuildContext context) {
    return Row(children: [Expanded(child: TextField(controller: _c, decoration: const InputDecoration(hintText: 'New task'))), IconButton(onPressed: () { final v = _c.text.trim(); if (v.isEmpty) return; context.read<TodoListModel>().addTask(v); _c.clear(); }, icon: const Icon(Icons.add))]);
  }
}

// ---------------------------
// Section 5 - Optional practical scenarios
// ---------------------------
class Section5Screen extends StatelessWidget {
  const Section5Screen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Section 5 - Optional')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(children: const [
          RefactorProviderExample(),
          SizedBox(height: 12),
          FavoriteProviderExample(),
          SizedBox(height: 12),
          ShopCartExample(),
          SizedBox(height: 12),
          AsyncFakeExample(),
          SizedBox(height: 12),
          SettingsExample(),
        ]),
      ),
    );
  }
}

// Task1: refactor prop drilling with provider (simple display)
class RefactorProviderExample extends StatelessWidget {
  const RefactorProviderExample({super.key});
  @override
  Widget build(BuildContext context) {
    return Card(child: ListTile(title: const Text('Profile (Provider)'), subtitle: Consumer<UserModel>(builder: (_, user, __) => Text('Name: ${user.username}')), trailing: ElevatedButton(onPressed: () => context.read<UserModel>().setName('Bob'), child: const Text('Set Bob'))));
  }
}

// Task2: Favorite -> use provider (reuse CounterModel as favorite? create small FavoriteModel locally)
class FavoriteModel extends ChangeNotifier {
  bool _fav = false; bool get fav => _fav;
  void toggle() { _fav = !_fav; notifyListeners(); }
}
class FavoriteProviderExample extends StatelessWidget {
  const FavoriteProviderExample({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (_) => FavoriteModel(), child: Consumer<FavoriteModel>(builder: (context, model, _) => Card(child: ListTile(title: const Text('Favorite (Provider)'), trailing: IconButton(icon: Icon(model.fav ? Icons.favorite : Icons.favorite_border), onPressed: () => model.toggle())))));
  }
}

// Task3: Multi-screen shopping cart (simplified)
class ShopCartExample extends StatelessWidget {
  const ShopCartExample({super.key});
  @override
  Widget build(BuildContext context) {
    return Card(child: ListTile(title: const Text('Shop (Provider)'), subtitle: const Text('Open product screen or view cart'), trailing: Row(mainAxisSize: MainAxisSize.min, children: [IconButton(icon: const Icon(Icons.store), onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const ProductScreen()))), IconButton(icon: const Icon(Icons.shopping_cart), onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const CartScreen())))])));
  }
}
class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});
  final products = const ['Apple', 'Banana', 'Chocolate', 'Milk'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text('Products')), body: ListView.builder(itemCount: products.length, itemBuilder: (context, i) => ListTile(title: Text(products[i]), trailing: ElevatedButton(onPressed: () => context.read<CartModel>().add(products[i]), child: const Text('Add')))));
  }
}
class CartScreen extends StatelessWidget {
  const CartScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartModel>();
    return Scaffold(appBar: AppBar(title: const Text('Cart')), body: ListView.builder(itemCount: cart.items.length, itemBuilder: (context, i) => ListTile(title: Text(cart.items[i]), trailing: IconButton(icon: const Icon(Icons.delete), onPressed: () => cart.removeAt(i)))));
  }
}

// Task4: Fake async model
class AsyncFakeExample extends StatelessWidget {
  const AsyncFakeExample({super.key});
  @override
  Widget build(BuildContext context) {
    final model = context.watch<AsyncFakeModel>();
    return Card(child: ListTile(title: const Text('Async Fake'), subtitle: model.isLoading ? const Text('Loading...') : Text(model.data.isEmpty ? 'No data' : model.data), trailing: ElevatedButton(onPressed: () => context.read<AsyncFakeModel>().fetch(), child: const Text('Fetch'))));
  }
}

// Task5: Settings screen
class SettingsExample extends StatelessWidget {
  const SettingsExample({super.key});
  @override
  Widget build(BuildContext context) {
    final s = context.watch<SettingsModel>();
    return Card(child: Padding(padding: const EdgeInsets.all(8), child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [Text('Notifications: ${s.notificationsEnabled}'), Switch(value: s.notificationsEnabled, onChanged: (v) => context.read<SettingsModel>().setNotifications(v)), Text('Volume: ${s.volume.toStringAsFixed(2)}'), Slider(value: s.volume, onChanged: (v) => context.read<SettingsModel>().setVolume(v)),])));
  }
}

// ---------------------------
// End
// ---------------------------
