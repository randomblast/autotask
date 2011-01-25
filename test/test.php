This test should create new issues for
  fn_with_inline_unprocessed_todo
  fn_with_inline_unprocessed_fixme
  fn_with_multiline_unprocessed_todo
  fn_with_multiline_unprocessed_fixme
  fn_with_hash_commented_unprocessed_todo
  fn_with_hash_commented_unprocessed_fixme

This test should find existing issues for
  fn_with_inline_processed_todo (#1234)
  fn_with_inline_processed_fixme (#2345)
  fn_with_multiline_processed_todo (#3456)
  fn_with_multiline_processed_fixme (#4567)
  fn_with_hash_commented_processed_todo (#5678)
  fn_with_hash_commented_processed_fixme (#6789)
  fn_with_phpdoc_processed_todo (#7890)
  fn_with_phpdoc_processed_fixme (#12345)

This test should NOT return issues for
  fn_with_todo_outside_comment
  fn_with_fixme_outside_comment
  THIS TEXT (outside <?php ?> markers )
<?php

function fn_with_inline_unprocessed_todo()
{
  // TODO from fn_with_inline_unprocessed_todo()
}

function fn_with_inline_unprocessed_fixme()
{
  // FIXME from fn_with_inline_unprocessed_fixme()
}

function fn_with_inline_processed_todo()
{
  // TODO #1234 from fn_with_inline_processed_todo()
}

function fn_with_inline_processed_fixme()
{
  // TODO #2345 from fn_with_inline_processed_fixme()
}

function fn_with_multiline_unprocessed_todo()
{
  /*
   * TODO from fn_with_multiline_unprocessed_todo()
   */
}

function fn_with_multiline_unprocessed_fixme()
{
  /*
   * FIXME from fn_with_multiline_unprocessed_fixme()
   */
}

function fn_with_multiline_processed_todo()
{
  /*
   * TODO #3456 from fn_with_multiline_processed_todo()
   */
}

function fn_with_multiline_processed_fixme()
{
  /*
   * TODO #4567 from fn_with_multiline_processed_fixme()
   */
}

function fn_with_hash_commented_unprocessed_todo()
{
  # TODO from fn_with_hash_commented_unprocessed_todo()
}

function fn_with_hash_commented_unprocessed_fixme()
{
  # FIXME from fn_with_hash_commented_unprocessed_fixme()
}

function fn_with_hash_commented_processed_todo()
{
  # TODO #5678 from fn_with_hash_commented_processed_todo()
}

function fn_with_hash_commented_processed_fixme()
{
  # TODO #6789 from fn_with_hash_commented_processed_fixme()
}

/**
 * @todo from fn_with_phpdoc_unprocessed_todo
 */
function fn_with_phpdoc_unprocessed_todo()
{
}

/**
 * @fixme from fn_with_phpdoc_unprocessed_fixme
 */
function fn_with_phpdoc_unprocessed_fixme()
{
}

/**
 * @todo #7890 from fn_with_phpdoc_processed_todo
 */
function fn_with_phpdoc_processed_todo()
{
}

/**
 * @fixme #12345 from fn_with_phpdoc_processed_fixme
 */
function fn_with_phpdoc_processed_fixme()
{
}

function fn_with_todo_outside_comment()
{
  echo "This is not a TODO to be processed.";
}

function fn_with_fixme_outside_comment()
{
  echo "This is not a FIXME to be processed.";
}


