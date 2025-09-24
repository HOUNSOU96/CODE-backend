import json
from pathlib import Path

TESTS_FILE = Path(__file__).parent.parent / "data" / "tests_en_cours.json"

def _load_tests():
    if TESTS_FILE.exists():
        with open(TESTS_FILE, "r", encoding="utf-8") as f:
            return json.load(f)
    return {}

def _save_tests(tests):
    with open(TESTS_FILE, "w", encoding="utf-8") as f:
        json.dump(tests, f, ensure_ascii=False, indent=2)

def sauvegarder_test(test_data):
    tests = _load_tests()
    tests[test_data["test_id"]] = test_data
    _save_tests(tests)

def charger_test(test_id):
    tests = _load_tests()
    return tests.get(test_id)

def supprimer_test(test_id):
    tests = _load_tests()
    if test_id in tests:
        del tests[test_id]
        _save_tests(tests)
