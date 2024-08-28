using service1 as service           from '../../srv/service';

annotate service.ChartDataEntities with @(
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Value : integerValue,
        },
        {
            $Type : 'UI.DataField',
            Value : forecastValue,
        },
        {
            $Type : 'UI.DataField',
            Value : targetValue,
        },
        {
            $Type : 'UI.DataField',
            Value : dimensions,
        },
    ],
    UI.LineItem.@UI.Criticality : criticality_code,
    //Search-Term: #ChartSection
    UI.Chart : {
        Title       : '{i18n>chart}',
        ChartType   : #Column,
        Measures    : [maxAmount],
        Dimensions  : [dimensions],
        MeasureAttributes   : [
            {
                $Type       : 'UI.ChartMeasureAttributeType',
                Measure     : maxAmount,
                Role        : #Axis1
            },
        ],
        DimensionAttributes : [
            {
                $Type       : 'UI.ChartDimensionAttributeType',
                Dimension   : dimensions,
                Role        : #Category
            },
            {
                $Type       : 'UI.ChartDimensionAttributeType',
                Dimension   : criticality_code,
                Role        : #Category
            },
        ],
        Actions : [
            {
                $Type       : 'UI.DataFieldForAction',
                Action      : 'service1.EntityContainer/unboundAction',
                Label       : '{i18n>unboundAction}',
            },
        ]
    },
    UI.Chart #areaChart : {
        //Search-Term: #microChartArea
        Title       : '{i18n>areaChart}',
        Description : '{i18n>ThisIsAMicroChart}',
        ChartType   : #Area,
        Dimensions  : [dimensions],
        Measures    : [integerValue],
        MeasureAttributes : [
            {
                $Type       : 'UI.ChartMeasureAttributeType',
                Measure     : integerValue,
                Role        : #Axis1,
                DataPoint   : '@UI.DataPoint#areaChart',
            },
        ],
    },
    UI.Chart #lineChart : { 
        //SearchTerm: #microChartLine
        Title       : '{i18n>lineChart}',
        Description : '{i18n>ThisIsAMicroChart}',
        ChartType   : #Line,
        Measures    : [
            integerValueWithUoM,
            targetValue,
        ],
        Dimensions  : [
            dimensions,
            dimensions
        ],
        MeasureAttributes : [
            {
                $Type       : 'UI.ChartMeasureAttributeType',
                Measure     : integerValueWithUoM,
                Role        : #Axis2,
                DataPoint   : '@UI.DataPoint#lineChartWidth',
            },
            {
                $Type       : 'UI.ChartMeasureAttributeType',
                Measure     : targetValue,
                Role        : #Axis2,
                DataPoint   : '@UI.DataPoint#lineChartDepth',
            },
        ],
    },
    UI.Chart #columnChart : { 
        //Search-Term: #microChartColumn
        Title       : '{i18n>columnChart}',
        Description : '{i18n>ThisIsAMicroChart}',
        ChartType   : #Column,
        Measures    : [integerValue],
        Dimensions  : [dimensions],
        MeasureAttributes : [
            {
                $Type       : 'UI.ChartMeasureAttributeType',
                Measure     : integerValue,
                Role        : #Axis1,
                DataPoint   : '@UI.DataPoint#dataPointForChart',
            }
        ]
    },
    UI.Chart #stackedBarChart : { 
        //Search-Term: #microChartStackedBar
        Title       : '{i18n>stackedBarChart}',
        Description : '{i18n>ThisIsAMicroChart}',
        ChartType   : #BarStacked,
        Measures    : [integerValue],
        Dimensions  : [dimensions],
        MeasureAttributes : [
            {
                $Type       : 'UI.ChartMeasureAttributeType',
                Measure     : integerValue,
                Role        : #Axis1,
                DataPoint   : '@UI.DataPoint#dataPointForChart',
            }
        ]
    },
    UI.Chart #comparisonChart : { 
        //Search-Term: #microChartComparision
        Title       : '{i18n>comparisonChart}',
        Description : '{i18n>ThisIsAMicroChart}',
        ChartType   : #Bar,
        Measures    : [integerValue],
        Dimensions  : [dimensions],
        MeasureAttributes : [
            {
                $Type       : 'UI.ChartMeasureAttributeType',
                Measure     : integerValue,
                Role        : #Axis1,
                DataPoint   : '@UI.DataPoint#dataPointForChart',
            }
        ]
    },
    
);

annotate service.ChartDataEntities with @(
    UI.DataPoint #areaChart : { 
        //Search-Term: #microChartArea
        Value                   : integerValue,
        TargetValue             : targetValue,
        CriticalityCalculation  : {
            ImprovementDirection        : #Target,
            ToleranceRangeLowValue      : areaChartToleranceLowerBoundValue,
            ToleranceRangeHighValue     : areaChartDeviationUpperBoundValue,
            DeviationRangeLowValue      : areaChartDeviationLowerBoundValue,
            DeviationRangeHighValue     : areaChartDeviationUpperBoundValue,
        },
    },
    UI.DataPoint #lineChartWidth : { 
        //Search-Term: #microChartLine
        Value                   : integerValueWithUoM,
        Criticality             : criticality_code,
    },
    UI.DataPoint #lineChartDepth : { 
        //Search-Term: #microChartLine
        Value                   : targetValue,
        Criticality             : criticality_code,
    },
    UI.DataPoint #dataPointForChart : {
        //Search-Terms: #microChartColumn, #microChartStackedBar, #microChartComparision
        Value                   : integerValue,
        Criticality             : criticality_code
    },
);

annotate service.ChartDataEntities with @(
    //Search-Term: #ChartSection
    Analytics.AggregatedProperties : [
        {
            Name                 : 'minAmount',
            AggregationMethod    : 'min',
            AggregatableProperty : 'integerValue',
            ![@Common.Label]     : 'Minimal Net Amount'
        },
        {
            Name                 : 'maxAmount',
            AggregationMethod    : 'max',
            AggregatableProperty : 'integerValue',
            ![@Common.Label]     : 'Maximal Net Amount'
        },
        {
            Name                 : 'avgAmount',
            AggregationMethod    : 'average',
            AggregatableProperty : 'integerValue',
            ![@Common.Label]     : 'Average Net Amount'
        }
    ],
);