create or replace package body test_extended_coverage is

  procedure coverage_for_object is
    l_expected  clob;
    l_actual    clob;
    l_results   ut3.ut_varchar2_list;
  begin
    --Arrange
    l_expected := '%<file path="ut3.dummy_coverage_package_with_an_amazingly_long_name_that_you_would_not_think_of_in_real_life_project_because_its_simply_too_long">%<lineToCover lineNumber="4" covered="true" branchesToCover="2" coveredBranches="1"/>%';
    --Act
    select *
      bulk collect into l_results
      from table(
        ut3.ut.run(
          a_path => 'ut3.test_block_dummy_coverage',
          a_reporter=> ut3.ut_coverage_sonar_reporter( ),
          a_include_objects => ut3.ut_varchar2_list( 'ut3.dummy_coverage_package_with_an_amazingly_long_name_that_you_would_not_think_of_in_real_life_project_because_its_simply_too_long' )
        )
      );
    --Assert
    l_actual := ut3_tester_helper.main_helper.table_to_clob(l_results);
    ut.expect(l_actual).to_be_like(l_expected);
  end;

  procedure coverage_for_schema is
    l_expected  clob;
    l_actual    clob;
    l_results   ut3.ut_varchar2_list;
  begin
    --Arrange
    l_expected := '%<file path="ut3.dummy_coverage_package_with_an_amazingly_long_name_that_you_would_not_think_of_in_real_life_project_because_its_simply_too_long">%<lineToCover lineNumber="4" covered="true" branchesToCover="2" coveredBranches="1"/>%';
    --Act
    select *
      bulk collect into l_results
      from table(
        ut3.ut.run(
          a_path => 'ut3.test_block_dummy_coverage',
          a_reporter=> ut3.ut_coverage_sonar_reporter( ),
          a_coverage_schemes => ut3.ut_varchar2_list( 'ut3' )
        )
      );
    --Assert
    l_actual := ut3_tester_helper.main_helper.table_to_clob(l_results);
    ut.expect(l_actual).to_be_like(l_expected);
    ut.expect(l_actual).to_be_like('%<file path="ut3.%">%<file path="ut3.%">%');
  end;

  procedure coverage_for_file is
    l_expected  clob;
    l_actual    clob;
    l_results   ut3.ut_varchar2_list;
    l_file_path varchar2(250);
  begin
    --Arrange
    l_file_path := lower('test/ut3.dummy_coverage_package_with_an_amazingly_long_name_that_you_would_not_think_of_in_real_life_project_because_its_simply_too_long.pkb');
    l_expected := '%<file path="'||l_file_path||'">%<lineToCover lineNumber="4" covered="true" branchesToCover="2" coveredBranches="1"/>%';
    --Act
    select *
      bulk collect into l_results
      from table(
        ut3.ut.run(
          a_path => 'ut3.test_block_dummy_coverage',
          a_reporter=> ut3.ut_coverage_sonar_reporter( ),
          a_source_files => ut3.ut_varchar2_list( l_file_path ),
          a_test_files => ut3.ut_varchar2_list( )
        )
      );
    --Assert
    l_actual := ut3_tester_helper.main_helper.table_to_clob(l_results);
    ut.expect(l_actual).to_be_like(l_expected);
  end;

end;
/
