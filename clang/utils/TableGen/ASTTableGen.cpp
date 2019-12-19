//=== ASTTableGen.cpp - Helper functions for working with AST records -----===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// This file defines some helper functions for working with tblegen reocrds
// for the Clang AST: that is, the contents of files such as DeclNodes.td,
// StmtNodes.td, and TypeNodes.td.
//
//===----------------------------------------------------------------------===//

#include "ASTTableGen.h"
#include "llvm/TableGen/Record.h"
#include "llvm/TableGen/Error.h"

using namespace llvm;
using namespace clang;
using namespace clang::tblgen;

static StringRef removeExpectedNodeNameSuffix(Record *node, StringRef suffix) {
  StringRef nodeName = node->getName();
  if (!nodeName.endswith(suffix)) {
    PrintFatalError(node->getLoc(),
                    Twine("name of node doesn't end in ") + suffix);
  }
  return nodeName.drop_back(suffix.size());
}

// Decl node names don't end in Decl for historical reasons, and it would
// be somewhat annoying to fix now.  Conveniently, this means the ID matches
// is exactly the node name, and the class name is simply that plus Decl.
std::string clang::tblgen::DeclNode::getClassName() const {
  return (Twine(getName()) + "Decl").str();
}
StringRef clang::tblgen::DeclNode::getId() const {
  return getName();
}

// Type nodes are all named ending in Type, just like the corresponding
// C++ class, and the ID just strips this suffix.
StringRef clang::tblgen::TypeNode::getClassName() const {
  return getName();
}
StringRef clang::tblgen::TypeNode::getId() const {
  return removeExpectedNodeNameSuffix(getRecord(), "Type");
}

// Stmt nodes are named the same as the C++ class, which has no regular
// naming convention (all the non-expression statements end in Stmt,
// and *many* expressions end in Expr, but there are also several
// core expression classes like IntegerLiteral and BinaryOperator with
// no standard suffix).  The ID adds "Class" for historical reasons.
StringRef clang::tblgen::StmtNode::getClassName() const {
  return getName();
}
std::string clang::tblgen::StmtNode::getId() const {
  return (Twine(getName()) + "Class").str();
}

// A map from a node to each of its child nodes.
template <class NodeClass>
using ChildMap = std::multimap<NodeClass, NodeClass>;

template <class NodeClass>
static void visitASTNodeRecursive(NodeClass node, NodeClass base,
                                  const ChildMap<NodeClass> &map,
                                  ASTNodeHierarchyVisitor<NodeClass> visit) {
  visit(node, base);

  auto i = map.lower_bound(node), e = map.upper_bound(node);
  for (; i != e; ++i) {
    visitASTNodeRecursive(i->second, node, map, visit);
  }
}

template <class NodeClass>
static void visitHierarchy(RecordKeeper &records,
                           StringRef nodeClassName,
                           ASTNodeHierarchyVisitor<NodeClass> visit) {
  // Check for the node class, just as a sanity check.
  if (!records.getClass(nodeClassName)) {
    PrintFatalError(Twine("cannot find definition for node class ")
                      + nodeClassName);
  }

  // Find all the nodes in the hierarchy.
  auto nodes = records.getAllDerivedDefinitions(nodeClassName);

  // Derive the child map.
  ChildMap<NodeClass> hierarchy;
  NodeClass root;
  for (NodeClass node : nodes) {
    if (auto base = node.getBase())
      hierarchy.insert(std::make_pair(base, node));
    else if (root)
      PrintFatalError(node.getLoc(),
                      "multiple root nodes in " + nodeClassName + " hierarchy");
    else
      root = node;
  }
  if (!root)
    PrintFatalError(Twine("no root node in ") + nodeClassName + " hierarchy");

  // Now visit the map recursively, starting at the root node.
  visitASTNodeRecursive(root, NodeClass(), hierarchy, visit);
}

void clang::tblgen::visitASTNodeHierarchy(RecordKeeper &records,
                                          StringRef nodeClassName,
                                      ASTNodeHierarchyVisitor<ASTNode> visit) {
  visitHierarchy(records, nodeClassName, visit);
}

void clang::tblgen::visitDeclNodeHierarchy(RecordKeeper &records,
                                      ASTNodeHierarchyVisitor<DeclNode> visit) {
  visitHierarchy(records, DeclNodeClassName, visit);
}

void clang::tblgen::visitTypeNodeHierarchy(RecordKeeper &records,
                                      ASTNodeHierarchyVisitor<TypeNode> visit) {
  visitHierarchy(records, TypeNodeClassName, visit);
}

void clang::tblgen::visitStmtNodeHierarchy(RecordKeeper &records,
                                      ASTNodeHierarchyVisitor<StmtNode> visit) {
  visitHierarchy(records, StmtNodeClassName, visit);
}
