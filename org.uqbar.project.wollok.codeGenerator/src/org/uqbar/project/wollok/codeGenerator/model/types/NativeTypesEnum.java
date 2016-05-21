package org.uqbar.project.wollok.codeGenerator.model.types;

import org.uqbar.project.wollok.sdk.WollokDSK;

public enum NativeTypesEnum {
	DOUBLE(WollokDSK.DOUBLE){
		public NativeTypesEnum max(NativeTypesEnum other) {
			if(other == DOUBLE || other == INT)return this;
			return super.max(other);
		}
	},

	INT(WollokDSK.INTEGER) {
		public NativeTypesEnum max(NativeTypesEnum other) {
			if(this==other)return this;
			if(other==DOUBLE)return other;
			return super.max(other);
		}
	},
	
	STRING(WollokDSK.STRING);

	private String wollokClassName;
	
	private NativeTypesEnum(String wollokClassName){
		this.wollokClassName = wollokClassName;
	}
	
	public String getWollokClassName(){
		return wollokClassName;
	}
	
	public NativeTypesEnum max(NativeTypesEnum other) {
		throw new RuntimeException("There is not coercion between " + this.toString() + " and " + other.toString());
	}
}
