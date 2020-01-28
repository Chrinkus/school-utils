#include <stdlib.h>
#include <stdio.h>
#include <json-c/json.h>

int main(void)
{
	char s[] = "{\"name\": \"joys of programming\"}";

	json_object* jobj = json_tokener_parse(s);
	enum json_type type = json_object_get_type(jobj);

	printf("type: %d\n", type);
	switch (type) {
	case json_type_null:	printf("JSON type null\n");	break;
	case json_type_boolean:	printf("JSON type bool\n");	break;
	case json_type_int:	printf("JSON type int\n");	break;
	case json_type_double:	printf("JSON type double\n");	break;
	case json_type_object:	printf("JSON type object\n");	break;
	case json_type_array:	printf("JSON type array\n");	break;
	case json_type_string:	printf("JSON type string\n");	break;
	}

	return EXIT_SUCCESS;
}
