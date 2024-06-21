// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------

namespace System.TestTools.AITestToolkit;

page 149035 "AIT Test Method Lines Compare"
{
    PageType = Card;
    ApplicationArea = All;
    SourceTable = "AIT Test Method Line";
    ModifyAllowed = false;
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            group("Version Configuration")
            {
                Caption = 'Version Configuration';

                field(Version; this.Version)
                {
                    Caption = 'Version';
                    ToolTip = 'Specifies the Base version to compare with.';
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        UpdateVersionFilter();
                    end;
                }
                field(BaseVersion; this.BaseVersion)
                {
                    Caption = 'Base Version';
                    ToolTip = 'Specifies the Base version to compare to.';
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        UpdateVersionFilter();
                    end;
                }
            }

            group("Version Comparison")
            {
                Caption = 'Version Comparison';
                grid(Summary)
                {
                    group("Summary Captions")
                    {
                        ShowCaption = false;
                        label(NoOfTests)
                        {
                            Caption = 'Number of Tests';
                            Tooltip = 'Specifies the number of tests in this Line';
                            ApplicationArea = All;
                        }
                        label(NoOfTestsPassed)
                        {
                            Caption = 'Number of Tests Passed';
                            ToolTip = 'Specifies the number of tests passed in the version.';
                            ApplicationArea = All;
                        }
                        label(NoOfTestsFailed)
                        {
                            Caption = 'Number of Tests Failed';
                            ToolTip = 'Specifies the number of tests that failed in the version.';
                            ApplicationArea = All;
                        }
                        label(TotalDuration)
                        {
                            Caption = 'Total Duration (ms)';
                            ToolTip = 'Specifies Total Duration of the AIT for this role for the version.';
                            ApplicationArea = All;
                        }
                    }
                    group("Latest Version")
                    {
                        field("No. of Tests"; Rec."No. of Tests")
                        {
                            Tooltip = 'Specifies the number of tests in this Line';
                            ApplicationArea = All;
                            ShowCaption = false;
                        }
                        field("No. of Tests Passed"; Rec."No. of Tests Passed")
                        {
                            ApplicationArea = All;
                            Style = Favorable;
                            ToolTip = 'Specifies the number of tests passed in the current Version.';
                            ShowCaption = false;
                        }
                        field("No. of Tests Failed"; Rec."No. of Tests" - Rec."No. of Tests Passed")
                        {
                            Editable = false;
                            ApplicationArea = All;
                            Caption = 'Number of Tests Failed';
                            ToolTip = 'Specifies the number of tests that failed in the current Version.';
                            ShowCaption = false;
                            Style = Unfavorable;

                            trigger OnDrillDown()
                            var
                                AITLogEntry: Codeunit "AIT Log Entry";
                            begin
                                AITLogEntry.DrillDownFailedAITLogEntries(Rec."Test Suite Code", Rec."Line No.", this.Version);
                            end;
                        }
                        field(Duration; Rec."Total Duration (ms)")
                        {
                            ToolTip = 'Specifies Total Duration of the AIT for this role.';
                            ApplicationArea = All;
                            ShowCaption = false;
                        }
                    }
                    group("Base Version")
                    {
                        field("No. of Tests - Base"; Rec."No. of Tests - Base")
                        {
                            Tooltip = 'Specifies the number of tests in this Line for the base version.';
                            ApplicationArea = All;
                            ShowCaption = false;
                        }
                        field("No. of Tests Passed - Base"; Rec."No. of Tests Passed - Base")
                        {
                            ApplicationArea = All;
                            ToolTip = 'Specifies the number of tests passed in the base Version.';
                            Style = Favorable;
                            ShowCaption = false;
                        }
                        field("No. of Tests Failed - Base"; Rec."No. of Tests - Base" - Rec."No. of Tests Passed - Base")
                        {
                            Editable = false;
                            ApplicationArea = All;
                            Caption = 'No. of Tests Failed - Base';
                            ToolTip = 'Specifies the number of tests that failed in the base Version.';
                            Style = Unfavorable;
                            ShowCaption = false;

                            trigger OnDrillDown()
                            var
                                AITLogEntry: Codeunit "AIT Log Entry";
                            begin
                                AITLogEntry.DrillDownFailedAITLogEntries(Rec."Test Suite Code", Rec."Line No.", this.BaseVersion);
                            end;
                        }
                        field(DurationBase; Rec."Total Duration - Base (ms)")
                        {
                            ToolTip = 'Specifies Total Duration of the AIT for this role for the base version.';
                            Caption = 'Total Duration Base (ms)';
                            ApplicationArea = All;
                            ShowCaption = false;
                        }
                    }
                }
            }
        }
    }

    var
        Version: Integer;
        BaseVersion: Integer;

    trigger OnOpenPage()
    begin
        UpdateVersionFilter();
    end;

    internal procedure SetVersion(VersionNo: Integer)
    begin
        this.Version := VersionNo;
    end;

    internal procedure SetBaseVersion(VersionNo: Integer)
    begin
        this.BaseVersion := VersionNo;
    end;

    local procedure UpdateVersionFilter()
    begin
        Rec.SetRange("Version Filter", this.Version);
        Rec.SetRange("Base Version Filter", this.BaseVersion);
        CurrPage.Update(false);
    end;
}