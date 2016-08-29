package org.uqbar.project.wollok.typesystem

import org.uqbar.project.wollok.wollokDsl.WMethodDeclaration

import static org.uqbar.project.wollok.sdk.WollokDSK.*

/**
 * @author jfernandes
 */
class TypeSystemUtils {
	
	// helper
	def static functionType(WMethodDeclaration m, extension TypeSystem ts) {
		"(" + m.parameters.map[it.type?.name].join(", ") + ') => ' + m.type?.name
	}
	
	// TODO: hardcoded !
	def static typeOfOperation(String op) {
		if (#["&&", "||"].contains(op))
			#[OBJECT,OBJECT] -> BOOLEAN
		else if (#["==", "!=", "===", "<", "<=", ">", ">="].contains(op))
			#[OBJECT,OBJECT] -> BOOLEAN
		else
			#[INTEGER,INTEGER] -> INTEGER
	}
	
}