(*
    Computational Specs Completion Mathematica package
    Copyright (C) 2021  Anton Antonov

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.

    Written by Anton Antonov,
    antononcube @ posteo . net,
    Windermere, Florida, USA.
*)

(*
    Mathematica is (C) Copyright 1988-2021 Wolfram Research, Inc.

    Protected by copyright law and international treaties.

    Unauthorized reproduction or distribution subject to severe civil
    and criminal penalties.

    Mathematica is a registered trademark of Wolfram Research, Inc.
*)

(* Created by the Wolfram Language Plugin for IntelliJ, see http://wlplugin.halirutan.de/ *)

(* :Title: ComputationalSpecCompletion *)
(* :Context: ComputationalSpecCompletion` *)
(* :Author: Anton Antonov *)
(* :Date: 2021-07-19 *)

(* :Package Version: 0.1 *)
(* :Mathematica Version: 11.3 *)
(* :Copyright: (c) 2021 Anton Antonov *)
(* :Keywords: *)
(* :Discussion: *)

BeginPackage["ComputationalSpecCompletion`"];
(* Exported symbols added here with SymbolName::usage *)

GetRawAnswers::usage = "GetRawAnswers";

GetAnswers::usage = "GetAnswers";

ComputationalSpecCompletion::usage = "ComputationalSpecCompletion";

Begin["`Private`"];

End[]; (* `Private` *)


(***********************************************************)
(* Shortcuts                                               *)
(***********************************************************)

aShortcuts = <|
  "QuantileRegression" -> "QuantileRegression",
  "QRMon" -> "QuantileRegression",
  "QR" -> "QuantileRegression",

  "LSAMon" -> "LatentSemanticAnalysis",
  "LSA" -> "LatentSemanticAnalysis",
  "LatentSemanticAnalysis" -> "LatentSemanticAnalysis"|>;


(***********************************************************)
(* Stencils                                                *)
(***********************************************************)

aStencils = <|
  "QuantileRegression" ->
      StringTemplate[
        "QRMonUnit[`dataset`]\[DoubleLongRightArrow]
QRMonEchoDataSummary[]\[DoubleLongRightArrow]
QRMonQuantileRegression[`knots`, `probs`, InterpolationOrder->`intOrder`]\[DoubleLongRightArrow]
QRMonPlot[\"DateListPlot\"->`dateListPlotQ`,PlotTheme->\"Detailed\"]\[DoubleLongRightArrow]
QRMonErrorPlots[\"RelativeErrors\"->`relativeErrorsQ`,\"DateListPlot\"->`dateListPlotQ`,PlotTheme->\"Detailed\"]"],

  "LatentSemanticAnalysis" ->
      StringTemplate["
LSAMonUnit[`textData`] \[DoubleLongRightArrow]
LSAMonMakeDocumentTermMatrix[ \"StemmingRules\" -> `stemmingRules`, \"StopWords\" -> `stopWords`] \[DoubleLongRightArrow]
LSAMonApplyTermWeightFunctions[\"GlobalWeightFunction\" -> \"`globalWeightFunction`\", \"LocalWeightFunction\" -> \"`localWeightFunction`\", \"NormalizerFunction\" -> \"`normalizerFunction`\"] \[DoubleLongRightArrow]
LSAMonExtractTopics[\"NumberOfTopics\" -> `numberOfTopics`, Method -> \"`method`\", \"MaxSteps\" -> `maxSteps`, \"MinNumberOfDocumentsPerTerm\" -> `minNumberOfDocumentsPerTerm`] \[DoubleLongRightArrow]
LSAMonEchoTopicsTable[\"NumberOfTerms\" -> `topicsTableNumberOfTerms`] \[DoubleLongRightArrow]
LSAMonEchoStatisticalThesaurus[ \"Words\" -> `statThesaurusWords`];"]
|>;


(***********************************************************)
(* Questions                                               *)
(***********************************************************)

aQuestions = <|

  "QuantileRegression" ->
      <|
        "How many knots" -> <|"TypePattern" -> _Integer, "Threshold" -> 0.75, "Parameter" -> "knots"|>,
        "What is the interpolation order" -> <|"TypePattern" -> _Integer, "Threshold" -> 0.75, "Parameter" -> "intOrder"|>,
        "Data summary" -> <|"TypePattern" -> _?BooleanQ, "Threshold" -> 0.75, "Parameter" -> "dataSummaryQ"|>,
        "Which axes to rescale" -> <|"TypePattern" -> {_String ..}, "Threshold" -> 0.75, "Parameter" -> {"rescaleTimeAxisQ", "rescaleValueAxisQ"}|>,
        "What kind of plot" -> <|"TypePattern" -> _?BooleanQ, "Threshold" -> 0.75, "Parameter" -> "dateListPlotQ",
          "TrueValues" -> {"true", "yes", "datelist", "date list", "datelist plot", "use date list plot"}|>,
        "Date list plot" -> <|"TypePattern" -> _?BooleanQ, "Threshold" -> 0.75,
          "Parameter" -> "dateListPlotQ",
          "TrueValues" -> {"true", "yes", "datelist", "date list", "datelist plot", "use date list plot"}|>,
        "Relative errors plot" -> <|"TypePattern" -> _?BooleanQ, "Threshold" -> 0.75, "Parameter" -> "relativeErrorsQ"|>,
        "Absolute errors plot" -> <|"TypePattern" -> _?BooleanQ, "Threshold" -> 0.75, "Parameter" -> "absoluteErrorsQ"|>,
        "Which dataset to use" -> <|"TypePattern" -> _String, "Threshold" -> 0.70, "Parameter" -> "dataset"|>,
        "Which data to use" -> <|"TypePattern" -> _String, "Threshold" -> 0.40, "Parameter" -> "dataset"|>,
        "Which time series to use" -> <|"TypePattern" -> _String, "Threshold" -> 0.4, "Parameter" -> "dataset"|>,
        "Which probabilities" -> <|"TypePattern" -> {_?NumericQ ..}, "Threshold" -> 0.7, "Parameter" -> "probs"|>,
        "Which regression quantiles" -> <|"TypePattern" -> {_?NumericQ ..}, "Threshold" -> 0.6, "Parameter" -> "probs"|>
      |>,

  "LatentSemanticAnalysis" ->
      <|
        "How many topics" -> <|"TypePattern" -> _Integer, "Threshold" -> 0.75, "Parameter" -> "numberOfTopics"|>,
        "Which method" -> <|"TypePattern" -> _String, "Threshold" -> 0.5, "Parameter" -> "method"|>,
        "Which dimension reduction method" -> <|"TypePattern" -> _String, "Threshold" -> 0.5, "Parameter" -> "method"|>,
        "Which topic extraction method" -> <|"TypePattern" -> _String, "Threshold" -> 0.5, "Parameter" -> "method"|>,
        "Apply stemming" -> <|"TypePattern" -> _?BooleanQ, "Threshold" -> 0.75, "Parameter" -> "stemmingRules"|>,
        "Show topics table" -> <|"TypePattern" -> _?BooleanQ, "Threshold" -> 0.75, "Parameter" -> "showTopicsTableQ"|>,
        "Number of terms in the topics table" -> <|"TypePattern" -> _?BooleanQ, "Threshold" -> 0.75, "Parameter" -> "topicsTableNumberOfTerms"|>,
        "Which words to use for statistical thesaurus" -> <|"TypePattern" -> {_String ..}, "Threshold" -> 0.15, "Parameter" -> "statThesaurusWords"|>,
        "Thesaurus words" -> <|"TypePattern" -> {_String ..}, "Threshold" -> 0.15, "Parameter" -> "statThesaurusWords"|>,
        "Thesaurus words to show" -> <|"TypePattern" -> {_String ..}, "Threshold" -> 0.15, "Parameter" -> "statThesaurusWords"|>,
        "Statistical thesaurus words" -> <|"TypePattern" -> {_String ..}, "Threshold" -> 0.75, "Parameter" -> "statThesaurusWords"|>,
        "Which dataset to use" -> <|"TypePattern" -> _String, "Threshold" -> 0.35, "Parameter" -> "textData"|>,
        "Which text corpus" -> <|"TypePattern" -> _String, "Threshold" -> 0.35, "Parameter" -> "textData"|>,
        "Which collection of texts" -> <|"TypePattern" -> _String, "Threshold" -> 0.35, "Parameter" -> "textData"|>
      |>
|>;


(***********************************************************)
(* Defaults                                                *)
(***********************************************************)

aDefaults = <|
  "QuantileRegression" -> <|
    "knots" -> 12,
    "probs" -> {0.25, 0.5, 0.75},
    "intOrder" -> 3,
    "rescaleTimeAxisQ" -> False,
    "rescaleValueAxisQ" -> False,
    "dateListPlotQ" -> False,
    "dataset" -> None,
    "relativeErrorsQ" -> False
  |>,
  "LatentSemanticAnalysis" -> <|
    "globalWeightFunction" -> "IDF",
    "localWeightFunction" -> "None",
    "maxSteps" -> 16,
    "method" -> "SVD",
    "minNumberOfDocumentsPerTerm" -> 20,
    "normalizerFunction" -> "Cosine",
    "numberOfTopics" -> 40,
    "removeStopWordsQ" -> True,
    "showTopicsTableQ" -> True,
    "statThesaurusWords" -> None,
    "stemmingRules" -> Automatic,
    "stopWords" -> Automatic,
    "textData" -> None,
    "thesaurusWords" -> None,
    "topicsTableNumberOfTerms" -> 10|>
|>;

(***********************************************************)
(* GetRawAnswers                                           *)
(***********************************************************)

Clear[GetRawAnswers];

GetRawAnswers::nwft =
    "The first argument is an unknown workflow type. The first argument is expected to be one of `1`.";

Options[GetRawAnswers] = Options[FindTextualAnswer];

GetRawAnswers[workflowTypeArg_String, command_String, nAnswers_Integer : 4, opts : OptionsPattern[]] :=
    Block[{workflowType = workflowTypeArg, aRes},

      workflowType = workflowType /. aShortcuts;

      If[! MemberQ[Values[aShortcuts], workflowType],
        Message[GetRawAnswers::nwft, Union[Keys[aShortcuts], Values[aShortcuts]]];
        Return[$Failed]
      ];

      aRes =
          Association@
              Map[# ->
                  FindTextualAnswer[command, #, nAnswers, {"String", "Probability"},
                    opts] &, Keys@aQuestions[workflowType]];

      Map[Association[Rule @@@ #] &, aRes]
    ];


(***********************************************************)
(* GetAnswers                                              *)
(***********************************************************)

ClearAll[TakeLargestKey];
TakeLargestKey[args__] := StringTrim@First@Keys@TakeLargest[args];

Clear[GetAnswers];
Options[GetAnswers] = Options[GetRawAnswers];
GetAnswers[workflowType_String, command_String, nAnswers_Integer : 4, opts : OptionsPattern[]] :=
    Block[{aRes, aParameterQuestions, parVal},

      (*Get raw answers*)

      aRes =
          GetRawAnswers[workflowType, command, nAnswers,
            FilterRules[{opts}, Options[GetRawAnswers]]];
      If[TrueQ[aRes === $Failed],
        Return[$Failed]
      ];

      (*Filter out candidates with too low probabilities*)

      aRes =
          Association@
              KeyValueMap[
                Function[{k, v},
                  k -> Select[v, # >= aQuestions[workflowType, k, "Threshold"] &]], aRes];
      aRes = Select[aRes, Length[#] > 0 &];

      (*Group the questions per parameter *)

      aParameterQuestions = GroupBy[aQuestions[workflowType], #["Parameter"] &, Keys];
      (*aParameterCandidateValues=Map[Merge[Values@KeyTake[aRes,#],Max]&, aParameterQuestions];*)

      (*For each parameter and each question of that parameter extract the top candidate parameter value and associated probability *)
      aRes =
          Map[
            KeyValueMap[
              Function[{k, v},
                parVal =
                    Switch[
                      ToString[aQuestions[workflowType, k, "TypePattern"]],

                      "{_String..}",

                      Map["\"" <> # <> "\"" &,
                        Select[StringTrim[StringSplit[TakeLargestKey[v, 1], {",", "and"}]], StringLength[#] > 0 &]],

                      "{_?NumericQ..}" | "{_Integer..}",

                      ToExpression /@ StringTrim[StringSplit[TakeLargestKey[v, 1], {",", "and"}]],

                      "_?NumericQ" | "_Integer",
                      ToExpression[TakeLargestKey[v, 1]],

                      "_?BooleanQ" | "(True|False)" | "(False|True)",
                      MemberQ[
                        If[KeyExistsQ[aQuestions[workflowType, k], "TrueValues"], aQuestions[workflowType, k, "TrueValues"], {"true", "false"}],
                        ToLowerCase[TakeLargestKey[v, 1]]
                      ],

                      _,
                      TakeLargestKey[v, 1]
                    ];
                parVal -> TakeLargest[v, 1][[1]]
              ],
              KeyTake[aRes, Flatten[{#}]]
            ] &,
            aParameterQuestions
          ];

      (*For each parameter take the parameter value candidate with the largest probability *)

      aRes = TakeLargestBy[#, #[[2]] &, 1][[1]] & /@ Select[aRes, Length[#] > 0 &];

      (*Drop the associated probabilities*)
      Keys /@ aRes
    ];


(***********************************************************)
(* ComputationalSpecCompletion                             *)
(***********************************************************)

ClearAll[ComputationalSpecCompletion];
ComputationalSpecCompletion[workflowType_String, command_String, opts : OptionsPattern[]] :=
    Block[{aRes},

      aRes = GetAnswers[workflowType, command, FilterRules[{opts}, Options[GetAnswers]]];

      If[TrueQ[aRes === $Failed],
        Return[$Failed]
      ];

      ToExpression["Hold[" <> aStencils[workflowType][Join[aDefaults[workflowType], aRes]] <> "]"]
    ];

EndPackage[]