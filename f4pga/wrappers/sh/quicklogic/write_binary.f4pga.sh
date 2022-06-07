#!/bin/bash
#
# Copyright (C) 2020-2022 F4PGA Authors.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# SPDX-License-Identifier: Apache-2.0

set -e

PYTHON3=`which python3`

source $(dirname "$(readlink -f "$BASH_SOURCE")")/env

BIT2BINARY="${PYTHON3} -m quicklogic_fasm.bitstream_to_binary"

echo "Converting bitstream to flashable binary format"
${BIT2BINARY} $@
