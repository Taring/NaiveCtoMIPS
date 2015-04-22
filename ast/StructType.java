package compiler.ast;

public class StructType extends BasicType {
    public Symbol tag;
	public List<Decl> fields;

    public StructType() {
    	tag = null;
    	sd = null;
    }

    public StructType(Symbol tag) {
        this.tag = tag;
        this.sd = null;
    }
    
    public StructDecl(Symbol tag, List<Decl> fields) {
        this.tag = tag;
        this.fields = fields;
    }
    
    public StructDecl(List<Decl> fields) {
        this.tag = null;
        this.fields = fields;
    }
}