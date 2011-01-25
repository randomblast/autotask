/*
This test should create new issues for
  fn_with_inline_unprocessed_todo
  fn_with_inline_unprocessed_fixme
  fn_with_multiline_unprocessed_todo
  fn_with_multiline_unprocessed_fixme

This test should find existing issues for
  fn_with_inline_processed_todo (#21234)
  fn_with_inline_processed_fixme (#22345)
  fn_with_multiline_processed_todo (#23456)
  fn_with_multiline_processed_fixme (#24567)
  fn_with_jsdoc_processed_todo (#27890)
  fn_with_jsdoc_processed_fixme (#212345)

This test should NOT return issues for
  fn_with_todo_outside_comment
  fn_with_fixme_outside_comment
  THIS TEXT
*/

function fn_with_inline_unprocessed_todo() {
  // TODO from fn_with_inline_unprocessed_todo()
}
function fn_with_inline_unprocessed_fixme() {
  // FIXME from fn_with_inline_unprocessed_fixme()
}
function fn_with_inline_processed_todo() {
  // TODO #21234 from fn_with_inline_processed_todo()
}
function fn_with_inline_processed_fixme() {
  // TODO #22345 from fn_with_inline_processed_fixme()
}
function fn_with_multiline_unprocessed_todo() {
  /*
   * TODO from fn_with_multiline_unprocessed_todo()
   */
}
function fn_with_multiline_unprocessed_fixme() {
  /*
   * FIXME from fn_with_multiline_unprocessed_fixme()
   */
}
function fn_with_multiline_processed_todo() {
  /*
   * TODO #23456 from fn_with_multiline_processed_todo()
   */
}
function fn_with_multiline_processed_fixme() {
  /*
   * TODO #24567 from fn_with_multiline_processed_fixme()
   */
}
/**
 * @todo from fn_with_jsdoc_unprocessed_todo
 */
function fn_with_jsdoc_unprocessed_todo() {
}
/**
 * @fixme from fn_with_jsdoc_unprocessed_fixme
 */
function fn_with_jsdoc_unprocessed_fixme() {
}
/**
 * @todo #27890 from fn_with_jsdoc_processed_todo
 */
function fn_with_jsdoc_processed_todo() {
}
/**
 * @fixme #212345 from fn_with_jsdoc_processed_fixme
 */
function fn_with_jsdoc_processed_fixme() {
}
function fn_with_todo_outside_comment() {
  console.log("This is not a TODO to be processed.");
}
function fn_with_fixme_outside_comment() {
  console.log("This is not a FIXME to be processed.");
}

