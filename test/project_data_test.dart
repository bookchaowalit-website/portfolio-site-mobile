import 'package:flutter_test/flutter_test.dart';
import 'package:bookchaowalit_portfolio_mobile/data/project_data.dart';

void main() {
  const projects = ProjectData.allProjects;

  test('every project has a name, description, tags and an https link', () {
    expect(projects, isNotEmpty);
    for (final project in projects) {
      expect(project.name.trim(), isNotEmpty, reason: 'name');
      expect(project.description.trim(), isNotEmpty, reason: project.name);
      expect(project.tags, isNotEmpty, reason: project.name);
      final uri = Uri.parse(project.url);
      expect(uri.scheme, 'https', reason: project.name);
      expect(uri.host, isNotEmpty, reason: project.name);
    }
  });

  test('project names are unique, so favorites and deep links are unambiguous',
      () {
    final names = projects.map((p) => p.name).toList();
    expect(names.toSet().length, names.length);
  });

  test('the Portfolio Mobile App entry links to this repository', () {
    final self = projects.singleWhere((p) => p.name == 'Portfolio Mobile App');
    expect(self.url,
        'https://github.com/bookchaowalit-website/portfolio-site-mobile');
  });
}
