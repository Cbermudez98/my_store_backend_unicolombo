def parse_response_list_dict(column_names: list, result: list[tuple]) -> list[dict]:
    return [dict(zip(column_names, row)) for row in result]