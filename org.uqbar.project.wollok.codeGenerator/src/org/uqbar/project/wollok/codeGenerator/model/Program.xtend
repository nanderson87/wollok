package org.uqbar.project.wollok.codeGenerator.model

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.project.wollok.codeGenerator.CodeAnalyzer

@Accessors
class Program extends AbstractCompositeContext {	
	val classes = <String,ClassDefinition> newHashMap
	val CodeAnalyzer analyzer
	
	new(CodeAnalyzer analyzer){
		this.analyzer = analyzer
	}
	
	override getParent() {
		null
	}
	
	def ClassDefinition resolveWollokClass(String name) {
		if(!classes.containsKey(name)){
			analyzer.tryToResolve(name)
		}
		
		classes.get(name)
	}
	
	def storeWollokClass(String name, ClassDefinition cd) {
		classes.put(name, cd)
	}	
}