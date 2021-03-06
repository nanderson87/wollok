package org.uqbar.project.wollok.tests.interpreter

import org.junit.Test
import org.uqbar.project.wollok.interpreter.core.WollokProgramExceptionWrapper

/**
 * @author jfernandes
 */
class ListTestCase extends CollectionTestCase {
	
	@Test
	def void subList() {
		'''
		program p {
			«instantiateCollectionAsNumbersVariable»
			assert.equals([22,2], numbers.subList(0,1))
			assert.equals([22,2,10], numbers.subList(0,2))
			assert.equals([2,10], numbers.subList(1,2))
			assert.equals([2], numbers.subList(1,1))
		}'''.interpretPropagatingErrors
	}
	
	@Test
	def void subListUnhappyPath() {
		'''
		program p {
			«instantiateCollectionAsNumbersVariable»
			assert.equals([2,22], numbers.subList(1,0))
			assert.equals([22,2,10], numbers.subList(0,25))
			assert.equals([2,10], numbers.subList(1,2))
			assert.equals([2], numbers.subList(1,1))
		}'''.interpretPropagatingErrors
	}
	
	@Test
	def void take() {
		'''
		program p {
			«instantiateCollectionAsNumbersVariable»
			assert.equals([], numbers.take(-1))
			assert.equals([], numbers.take(0))
			assert.equals([22], numbers.take(1))
			assert.equals([22,2], numbers.take(2))
			assert.equals([22,2,10], numbers.take(3))
			assert.equals([22,2,10], numbers.take(4))
			assert.equals([22,2,10], numbers)
		}'''.interpretPropagatingErrors
	}
	
	@Test
	def void takeUnhappyPath() {
		'''
		program p {
			«instantiateCollectionAsNumbersVariable»
			assert.equals([], [].take(-1))
			assert.equals([], [].take(0))
			assert.equals([], [].take(1))
			assert.equals([], [].take(2))
		}'''.interpretPropagatingErrors
	}
	
	@Test
	def void drop() {
		'''
		program p {
			«instantiateCollectionAsNumbersVariable»
			assert.equals([22,2,10], numbers.drop(-1))
			assert.equals([22,2,10], numbers.drop(0))
			assert.equals([2,10], numbers.drop(1))			
			assert.equals([10], numbers.drop(2))
			assert.equals([], numbers.drop(3))
			assert.equals([], numbers.drop(4))
			assert.equals([22,2,10], numbers)
		}'''.interpretPropagatingErrors
	}
	
	@Test
	def void dropUnhappyPath() {
		'''
		program p {
			«instantiateCollectionAsNumbersVariable»
			assert.equals([], [].drop(-1))
			assert.equals([], [].drop(0))
			assert.equals([], [].drop(1))
			assert.equals([], [].drop(2))
		}'''.interpretPropagatingErrors
	}	
	
	@Test
	def void reverse() {
		'''
		program p {
			«instantiateCollectionAsNumbersVariable»
			assert.equals([10,2,22], numbers.reverse())
			assert.equals([], [].reverse())
			assert.equals([2], [2].reverse())			
		}'''.interpretPropagatingErrors
	}
	
	@Test
	def void printingDuplicatedElements(){
		'''
			program p {
				const l1 = [[3,5,2], [4,2,6]].flatten()
				assert.equals("[3, 5, 2, 4, 2, 6]", l1.toString())


				const l2 = [1,2,3].flatMap({x => [x, x * 2, x * 3]})
				assert.equals("[1, 2, 3, 2, 4, 6, 3, 6, 9]", l2.toString())

				const l3 = [1,1,1]
				assert.equals("[1, 1, 1]", l3.toString())
			}
		'''.interpretPropagatingErrors		
	}

	@Test
	def void equalityCaseTrue() {
		'''
			program p {
				assert.equals(['Hello'], ['Hello'])
				assert.equals([4, 5, 9], [4, 5, 9])
				assert.equals([true], [true])
				assert.equals([], [])
			}
		'''.interpretPropagatingErrors		
	}
			
	@Test
	def void equalityCaseFalse() {
		'''
			program p {
				assert.notEquals(['Hello'], ['Hellou'])
				assert.notEquals([4, 5, 9], [5, 4, 9])
				assert.notEquals([4, 5, 9], #{4, 5, 9})
			}
		'''.interpretPropagatingErrors		
	}	
		
		
}