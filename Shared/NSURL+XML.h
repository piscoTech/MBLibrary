//
//  NSURL+XML.h
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

#import <Foundation/Foundation.h>

@class XMLNode;

@interface NSURL (XML)

- (nullable NSArray<XMLNode *> *)performXMLXPathQuery:(nonnull NSString *)query withXSD:(nullable NSURL *)xsd;

@end
