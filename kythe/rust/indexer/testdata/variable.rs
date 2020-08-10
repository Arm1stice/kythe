//- @_TEST_CONSTANT defines/binding Constant
//- Constant.node/kind constant
const _TEST_CONSTANT: u32 = 0;

//- @_TEST_STATIC defines/binding Static
//- Static.node/kind constant
static _TEST_STATIC: &str = "Kythe";

fn main() {
    //- @_test_variable defines/binding Local
    //- Local.node/kind variable
    //- Local.subkind local
    let _test_variable = 0;

    // TODO: Identify declaractions and emit an ".complete = imcomplete" fact
    //- @_test_declaration defines/binding Decl
    //- Decl.node/kind variable
    //- Decl.subkind local
    let _test_declaration: u32;
}
