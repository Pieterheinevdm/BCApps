// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------

namespace System.TestTools.TestRunner;

//TODO: Delete, do not check-in
codeunit 130478 "E2E Test Data Driven Output"
{
    Subtype = Test;
    TestPermissions = Disabled;

    [Test]
    procedure TestDataOutput()
    var
        TestOutput: Codeunit "Test Output";
    begin
        TestOutput.TestData().Add('Time', Format(CurrentDateTime(), 0, 9));
        TestOutput.TestData().AddArray('TestList');

        TestOutput.TestData().Element('TestList').Add('Item1', 'aaa');
        TestOutput.TestData().Add('CopilotKPis', '').Add('Number of calls', Format(111, 0, 9));
        TestOutput.TestData().Element('CopilotKPis').Add('Number of tokens', Format(122, 0, 9));

        // Test Integers, decimals, booleans, datetime and date
        TestOutput.TestData().Element('TestList').Add('Decimal', 123.11);
        TestOutput.TestData().Element('TestList').Add('Integer', 123);
        TestOutput.TestData().Element('TestList').Add('Boolean', true);
        TestOutput.TestData().Element('TestList').Add('DateTime', CurrentDateTime());
        TestOutput.TestData().Element('TestList').Add('Date', DT2Date(CurrentDateTime()));
    end;

    [Test]
    procedure TestDataOutput2()
    var
        TestOutput: Codeunit "Test Output";
    begin
        TestOutput.TestData().Add('Time 2', Format(CurrentDateTime(), 0, 9));
        TestOutput.TestData().AddArray('TestList 2');
        TestOutput.TestData().Element('TestList 2').Add('Item1', 'aaa');
        TestOutput.TestData().Add('CopilotKPis 2', '').Add('Number of calls', Format(111, 0, 9));
        TestOutput.TestData().Element('CopilotKPis 2').Add('Number of tokens', Format(122, 0, 9));
        // TODO: Add overloads for decimals, integers, boolean and other commonly used types
        TestOutput.TestData().Element('TestList 2').Add('Amount', '123.11');
    end;

    [Test]
    procedure TestDataInput()
    var
        TestInput: Codeunit "Test Input";
        TestOutput: Codeunit "Test Output";
        TextVariable: Text;
        Amount1: Decimal;
        Amount2: Decimal;
    begin
        TextVariable := TestInput.GetTestInput('harms').ElementAt(0).ValueAsText();
        TextVariable := TestInput.GetTestInput('harms').ElementAt(1).ValueAsText();
        TextVariable := TestInput.GetTestInput('accounts').ElementAt(0).ValueAsText();
        TextVariable := TestInput.GetTestInput('accounts').ElementAt(1).ValueAsText();
        Amount1 := TestInput.GetTestInput('firstLineAmount').ValueAsDecimal();
        Amount2 := TestInput.GetTestInput('secondLineAmount').ValueAsDecimal();
        TestOutput.TestData().Add('Amount 1', Format(Amount1));
        TestOutput.TestData().Add('Amount 2', Format(Amount2));
    end;
}