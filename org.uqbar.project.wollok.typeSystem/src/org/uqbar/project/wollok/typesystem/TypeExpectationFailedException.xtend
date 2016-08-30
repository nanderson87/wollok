package org.uqbar.project.wollok.typesystem

import org.eclipse.emf.ecore.EObject
import org.eclipse.xtend.lib.annotations.Accessors

/**
 * @author jfernandes
 */
class TypeExpectationFailedException extends RuntimeException {
	/** The semantic model (ast) which had this issue */
	@Accessors EObject model
	
	new(String message) {
		super(message)
	}
	
	new(EObject m, String message) {
		super(message)
		model = m
	}
	
}