#include "ruby.h"

typedef struct struct_node {
	VALUE obj;
	struct struct_node *npx; // XOR of next and previous
} node;

typedef struct {
	unsigned int size;
	node *front;
	node *back;
} xor_list;

node* xor(node *a, node *b)
{
    return (node*) ((uintptr_t) (a) ^ (uintptr_t) (b));
}

static xor_list* get_xor_list(VALUE self) {
	xor_list *list;
	Data_Get_Struct(self, xor_list, list);
	return list;
}

static xor_list* create_xor_list() {
	xor_list *list = ALLOC(xor_list);
	list->size = 0;
	list->front = NULL;
	list->back = NULL;
	return list;
}

static void xor_list_mark(void *ptr) {
  node *prev = NULL, *next = NULL;
  if (ptr) {
		xor_list *list = ptr;
		node *current = list->front;
		while(current) {
			rb_gc_mark(current->obj);
			next = xor(prev, current->npx);
			prev = current;
			current = next;
		}
	}
}

void free_nodes(node *current) {
	node *prev = NULL, *next = NULL;
	while(current) {
	    xfree(current);
		next = xor(prev, current->npx);
        prev = current;
        current = next;
	}
	return;
}

static void xor_list_free(void *ptr) {
	if (ptr) {
		xor_list *list = ptr;
		free_nodes(list->front);
		xfree(list);
	}
}

static VALUE xor_list_alloc(VALUE klass) {
	xor_list *list = create_xor_list();
	return Data_Wrap_Struct(klass, xor_list_mark, xor_list_free, list);
}

static node* create_node(VALUE obj) {
	node *n = ALLOC(node);
	n->obj = obj;
	n->npx = NULL;
	return n;
}

static VALUE xor_list_init(VALUE self)
{
	return self;
}

static VALUE xor_list_push_front(VALUE self, VALUE obj) {
	xor_list *list = get_xor_list(self);
	node *current = create_node(obj);
	if(list->front) {
		current->npx = xor(NULL, list->front);
		list->front->npx = xor(current, xor(NULL, list->front->npx));
	}
	else {
		list->back = current;
	}
	list->front = current;
	list->size++;
	return obj;
}

static VALUE xor_list_each(VALUE self) {
    xor_list *list = get_xor_list(self);
    node *current = list->front;
    node *prev = NULL, *next = NULL;
    while(current) {
        rb_yield(current->obj);
        next = xor(prev, current->npx);
        prev = current;
        current = next;
    }
    return self;
}

static VALUE list;
static VALUE containers;

void Init_XORList() {
    containers = rb_define_module("Containers");
    list = rb_define_class_under(containers, "XORList", rb_cObject);
    rb_define_alloc_func(list, xor_list_alloc);
    rb_define_method(list, "initialize", xor_list_init, 0);
    rb_define_method(list, "push_front", xor_list_push_front, 1);
    rb_define_method(list, "each", xor_list_each, 0);
    rb_include_module(list, rb_eval_string("Enumerable"));
}