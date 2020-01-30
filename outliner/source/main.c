#include <stdlib.h>
#include <stdio.h>
#include <json-c/json.h>
#include <string.h>

enum buf_sizes {
	buf_name = 32,
	buf_email = 32,
	buf_phone = 16,
	buf_office = 8,
	buf_hours = 32,
	buf_max = 1024,
};

typedef struct Instructor Instructor;
struct Instructor {
	char name[buf_name];
	char email[buf_email];
	char phone[buf_phone];
	char office[buf_office];
	char hours[buf_hours];
};

enum efields { ename, eemail, ephone, eoffice, ehours, num_efields };
const char* fields[] = {
	[ename]   = "Name",
	[eemail]  = "Email",
	[ephone]  = "Phone",
	[eoffice] = "Office Location",
	[ehours]  = "Office Hours",
};

char* tag_wrap(const char src[static 1], const char tag[static 1])
{
	size_t len = strlen(src) + strlen(tag) * 2 + 6;
	char* s = (char*) malloc(len);
	snprintf(s, len, "<%s>%s</%s>", tag, src, tag);
	return s;
}

int main(int argc, char* argv[argc+1])
{
	const char fname[] = "../private_data/instructor.json";

	FILE* fp = fopen(fname, "r");
	if (!fp) {
		fprintf(stderr, "Could not open file: %s\n", fname);
		return EXIT_FAILURE;
	}

	char buffer[buf_max];
	fread(buffer, buf_max, 1, fp);
	fclose(fp);

	json_object* parsed_json = json_tokener_parse(buffer);
	if (!parsed_json) {
		fprintf(stderr, "Could not parse json: %s\n", fname);
		return EXIT_FAILURE;
	}

	const char inst[] = "Chris Schick";
	json_object* instructor = NULL;
	if (!json_object_object_get_ex(parsed_json, inst, &instructor)) {
		fprintf(stderr, "Could not find instructor %s\n", inst);
		return EXIT_FAILURE;
	}

	for (int i = 0; i < num_efields; ++i) {
		json_object* field = NULL;
		json_object_object_get_ex(instructor, fields[i], &field);
		if (!field) {
			fprintf(stderr, "Could not locate field %s in %s\n",
					fields[i], inst);
			return EXIT_FAILURE;
		}
		char* s1 = tag_wrap(fields[i], "th");
		//printf("%s\n", s1);
		char* s2 = tag_wrap(json_object_get_string(field), "td");
		//printf("%s\n", s2);
		size_t len = strlen(s1) + strlen(s2);
		char s3[len];
		strcat(s3, s1);
		strcat(s3, s2);
		char* s4 = tag_wrap(s3, "tr");
		printf("%s\n", s4);
		//printf("%s: %s\n", fields[i], json_object_get_string(field));
		free(s1);
		free(s2);
		free(s3);
		free(s4);
	}

	json_object_put(parsed_json);
	return EXIT_SUCCESS;
}
