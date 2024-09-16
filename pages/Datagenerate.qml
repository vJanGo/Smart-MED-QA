import QtQuick
import QtQuick.Layouts
import QtQuick.Window
import QtQuick.Controls
import FluentUI

FluScrollablePage{

    title: qsTr("Bar Chart")

    FluFrame{
        Layout.preferredWidth: 500
        Layout.preferredHeight: 370
        padding: 10
        Layout.topMargin: 20
        FluChart{
            anchors.fill: parent
            chartType: 'bar'
            chartData: { return {
                    labels: ['January', 'February', 'March', 'April', 'May', 'June', 'July'],
                    datasets: [{
                            label: 'My First Dataset',
                            data: [65, 59, 80, 81, 56, 55, 40],
                            backgroundColor: [
                                'rgba(255, 99, 132, 0.2)',
                                'rgba(255, 159, 64, 0.2)',
                                'rgba(255, 205, 86, 0.2)',
                                'rgba(75, 192, 192, 0.2)',
                                'rgba(54, 162, 235, 0.2)',
                                'rgba(153, 102, 255, 0.2)',
                                'rgba(201, 203, 207, 0.2)'
                            ],
                            borderColor: [
                                'rgb(255, 99, 132)',
                                'rgb(255, 159, 64)',
                                'rgb(255, 205, 86)',
                                'rgb(75, 192, 192)',
                                'rgb(54, 162, 235)',
                                'rgb(153, 102, 255)',
                                'rgb(201, 203, 207)'
                            ],
                            borderWidth: 1
                        }]
                }
            }

            chartOptions: { return {
                    maintainAspectRatio: false,
                    title: {
                        display: true,
                        text: '不知道'
                    },
                    tooltips: {
                        mode: 'index',
                        intersect: false
                    },
                    responsive: true,
                    scales: {
                        xAxes: [{
                                stacked: true,
                            }],
                        yAxes: [{
                                stacked: true
                            }]
                    }
                }
            }
        }
    }

    FluFrame{
        Layout.preferredWidth: 500
        Layout.preferredHeight: 370
        padding: 10
        Layout.topMargin: 20
        FluChart{
            anchors.fill: parent
            chartType: 'horizontalBar'
            chartData: { return {
                    labels: ['January', 'February', 'March', 'April', 'May', 'June', 'July'],
                    datasets: [{
                            label: 'My First Dataset',
                            data: [65, 59, 80, 81, 56, 55, 40],
                            backgroundColor: [
                                'rgba(255, 99, 132, 0.2)',
                                'rgba(255, 159, 64, 0.2)',
                                'rgba(255, 205, 86, 0.2)',
                                'rgba(75, 192, 192, 0.2)',
                                'rgba(54, 162, 235, 0.2)',
                                'rgba(153, 102, 255, 0.2)',
                                'rgba(201, 203, 207, 0.2)'
                            ],
                            borderColor: [
                                'rgb(255, 99, 132)',
                                'rgb(255, 159, 64)',
                                'rgb(255, 205, 86)',
                                'rgb(75, 192, 192)',
                                'rgb(54, 162, 235)',
                                'rgb(153, 102, 255)',
                                'rgb(201, 203, 207)'
                            ],
                            borderWidth: 1
                        }]
                }
            }

            chartOptions: { return {
                    maintainAspectRatio: false,
                    title: {
                        display: true,
                        text: 'Chart.js HorizontalBar Chart - Stacked'
                    },
                    tooltips: {
                        mode: 'index',
                        intersect: false
                    },
                    responsive: true,
                    scales: {
                        xAxes: [{
                                stacked: true,
                            }],
                        yAxes: [{
                                stacked: true
                            }]
                    }
                }
            }
        }
    }

    FluFrame{
            Layout.preferredWidth: 500
            Layout.preferredHeight: 370
            padding: 10
            Layout.topMargin: 20
            FluChart{
                id: chart
                anchors.fill: parent
                chartType: 'line'
                chartData: { return {
                        labels: ['January', 'February', 'March', 'April', 'May', 'June', 'July'],
                        datasets: [{
                                label: 'My First Dataset',
                                data: root.data,
                                fill: false,
                                borderColor: 'rgb(75, 192, 192)',
                                tension: 0.1
                            }]
                    }
                }
                chartOptions: { return {
                        maintainAspectRatio: false,
                        title: {
                            display: true,
                            text: 'Chart.js Line Chart - Stacked'
                        },
                        tooltips: {
                            mode: 'index',
                            intersect: false
                        }
                    }
                }
            }
            Timer{
                id: timer
                interval: 300
                repeat: true
                onTriggered: {
                    root.data.push(Math.random()*100)
                    if(root.data.length>7){
                        root.data.shift()
                    }
                    chart.animateToNewData()
                }
            }
            Component.onCompleted: {
                timer.restart()
            }
        }

    FluFrame{
            Layout.preferredWidth: 500
            Layout.preferredHeight: 370
            padding: 10
            Layout.topMargin: 20
            FluChart{
                anchors.fill: parent
                chartType: "doughnut"
                chartData: { return {
                        labels: [
                            'Red',
                            'Blue',
                            'Yellow'
                        ],
                        datasets: [{
                                label: 'My First Dataset',
                                data: [300, 50, 100],
                                backgroundColor: [
                                    'rgb(255, 99, 132)',
                                    'rgb(54, 162, 235)',
                                    'rgb(255, 205, 86)'
                                ],
                                hoverOffset: 4
                            }]
                    }
                }
                chartOptions: { return {
                        maintainAspectRatio: false,
                        title: {
                            display: true,
                            text: 'Chart.js Doughnut Chart - Stacked'
                        },
                        tooltips: {
                            mode: 'index',
                            intersect: false
                        }
                    }
                }
            }
        }

        FluFrame{
            Layout.preferredWidth: 500
            Layout.preferredHeight: 370
            padding: 10
            Layout.topMargin: 20
            FluChart{
                anchors.fill: parent
                chartType: "pie"
                chartData: { return {
                        labels: [
                            'Red',
                            'Blue',
                            'Yellow'
                        ],
                        datasets: [{
                                label: 'My First Dataset',
                                data: [300, 50, 100],
                                backgroundColor: [
                                    'rgb(255, 99, 132)',
                                    'rgb(54, 162, 235)',
                                    'rgb(255, 205, 86)'
                                ],
                                hoverOffset: 4
                            }]
                    }
                }
                chartOptions: { return {
                        maintainAspectRatio: false,
                        title: {
                            display: true,
                            text: 'Chart.js Pie Chart - Stacked'
                        },
                        tooltips: {
                            mode: 'index',
                            intersect: false
                        }
                    }
                }
            }
        }

}
