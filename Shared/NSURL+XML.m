//
//  NSURL+XML.m
//  MBLibrary
//
//  Inspired by Matt Gallagher's XPathQuery on 4/08/08.
//  https://www.cocoawithlove.com/2008/10/using-libxml2-for-parsing-and-xpath.html
//  Copyright 2008 Matt Gallagher. All rights reserved.
//
//  Permission is given to use this source code file, free of charge, in any
//  project, commercial or otherwise, entirely at your risk, with the condition
//  that any redistribution (in part or whole) of source code must retain
//  this copyright and permission notice. Attribution in compiled projects is
//  appreciated but not required.
//
//  Improved with wrapper for Swift by Marco Boschi on 22/04/2017.
//  Copyright © 2017 Marco Boschi. All rights reserved.
//

#import <MBLibrary/MBLibrary-Swift.h>
#import "NSURL+XML.h"

#import <libxml/tree.h>
#import <libxml/parser.h>
#import <libxml/HTMLparser.h>
#import <libxml/xpath.h>
#import <libxml/xpathInternals.h>
#import <libxml/valid.h>
#import <libxml/xmlschemas.h>

@implementation NSURL (XML)

	- (XMLNode *)processNode:(xmlNodePtr)currentNode withParent:(XMLNode *)parent {
		XMLNode *node = nil;
		
		if (currentNode->name) {
			NSString *nodeName = [NSString stringWithCString:(const char *)currentNode->name encoding:NSUTF8StringEncoding];
			node = [[XMLNode alloc] initWithName:nodeName];
		} else if(!currentNode->parent) {
			// Root node
			node = [[XMLNode alloc] initWithName:@""];
		}
		
		if (node && currentNode->content && currentNode->type != XML_DOCUMENT_TYPE_NODE) {
			NSString *currentNodeContent = [NSString stringWithCString:(const char *)currentNode->content encoding:NSUTF8StringEncoding];
			
			if ([node.name isEqual:@"text"] && parent) {
				currentNodeContent = [currentNodeContent stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
				
				NSString *existingContent = [parent content];
				NSString *newContent;
				if (existingContent) {
					newContent = [existingContent stringByAppendingString:currentNodeContent];
				} else {
					newContent = currentNodeContent;
				}
				
				[parent setWithContent:newContent];
				
				return nil;
			}
			
			[node setWithContent:currentNodeContent];
		}
		
		xmlAttr *attribute = currentNode->properties;
		if (attribute) {
			while (attribute) {
				NSString *attrName = [NSString stringWithCString:(const char *)attribute->name encoding:NSUTF8StringEncoding];
				NSString *attrVal = nil;
				if (attribute->children && attribute->children->content) {
					attrVal = [[NSString stringWithCString:(const char *)attribute->children->content encoding:NSUTF8StringEncoding] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
				}
				
				if (attrName && attrVal) {
					[node addWithAttribute:[[XMLAttribute alloc] initWithName:attrName value:attrVal]];
				}
				
				attribute = attribute->next;
			}
		}
		
		xmlNodePtr childNode = currentNode->children;
		if (childNode) {
			while (childNode) {
				XMLNode *child = [self processNode:childNode withParent:node];
				if (child) {
					[node addWithChild:child];
				}
				childNode = childNode->next;
			}
		}
		
		return node;
	}

	- (nullable NSArray *)performXMLXPathQuery:(nonnull NSString *)query withXSD:(nullable NSURL *)xsd {
		xmlDocPtr doc;
		xmlXPathContextPtr xpathCtx;
		xmlSchemaParserCtxtPtr parserCtxt = nil;
		xmlSchemaPtr schema = nil;
		xmlSchemaValidCtxtPtr validCtxt = nil;
		xmlXPathObjectPtr xpathObj;
		
		NSMutableArray<XMLNode *> *result = nil;
		
		NSData *data = [[NSData alloc] initWithContentsOfURL:self];
		if (data == NULL) {
			return nil;
		}
		
		// Load XML document
		doc = xmlReadMemory([data bytes], (int)[data length], "", NULL, XML_PARSE_RECOVER);
		if (doc != NULL) {
			// Create XPath evaluation context
			xpathCtx = xmlXPathNewContext(doc);
			if(xpathCtx != NULL) {
				if (xsd != NULL) {
					parserCtxt = xmlSchemaNewParserCtxt([[xsd absoluteString] cStringUsingEncoding:NSUTF8StringEncoding]);
				}
				
				if (xsd == NULL || parserCtxt != NULL) {
					if (xsd != NULL) {
						schema = xmlSchemaParse(parserCtxt);
					}
					
					if (xsd == NULL || schema != NULL) {
						if (xsd != NULL) {
							validCtxt = xmlSchemaNewValidCtxt(schema);
						}
						
						if (xsd == NULL || validCtxt != NULL) {
							if (xsd == NULL || xmlSchemaValidateDoc(validCtxt, doc) == 0) {
								// Evaluate XPath expression
								xpathObj = xmlXPathEvalExpression((xmlChar *)[query cStringUsingEncoding:NSUTF8StringEncoding], xpathCtx);
								if(xpathObj != NULL) {
									xmlNodeSetPtr nodes = xpathObj->nodesetval;
									if (nodes) {
										// All checked, parse the data
										result = [NSMutableArray array];
										for (NSInteger i = 0; i < nodes->nodeNr; i++) {
											XMLNode *node = [self processNode:nodes->nodeTab[i] withParent:nil];
											if (node) {
												[result addObject:node];
											}
										}
									}
								
									xmlXPathFreeObject(xpathObj);
								}
							}
							
							if (validCtxt != NULL) {
								xmlSchemaFreeValidCtxt(validCtxt);
							}
						}
						
						if (schema != NULL) {
							xmlSchemaFree(schema);
						}
					}
					
					if (parserCtxt != NULL) {
						xmlSchemaFreeParserCtxt(parserCtxt);
					}
				}
				
				xmlXPathFreeContext(xpathCtx);
			}
			xmlFreeDoc(doc);
		}
		
		return result;
	}

@end
