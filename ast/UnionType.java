package compiler.ast;

public class UnionType extends BasicType {
    public Symbol tag;
	public List<Decl> fields;

    public UnionType() {
    	tag = null;
    	sd = null;
    }

    public UnionType(Symbol tag) {
        this.tag = tag;
        this.sd = null;
    }
    
    public UnionDecl(Symbol tag, List<Decl> fields) {
        this.tag = tag;
        this.fields = fields;
    }
    
    public UnionDecl(List<Decl> fields) {
        this.tag = null;
        this.fields = fields;
    }
    
}
