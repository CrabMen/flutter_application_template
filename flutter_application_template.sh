#!/bin/bash

function build() {
    echo '打包';
} 

function icon() {
  echo '开始生成原生的icon.....'
  flutter pub run flutter_launcher_icons
}

function launcher() {
  echo '开始生成原生的启动图launcher.....'
  flutter pub run flutter_native_splash:create

}


function flavor() {
  echo '开始生成原生的flavor'
  flutter pub run flutter_flavorizr
}


