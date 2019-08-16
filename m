From: Sam Shih <sam.shih@mediatek.com>
Subject: [PATCH v3 0/10] Add mt7629 and fix mt7628 pwm
Date: Fri, 16 Aug 2019 15:21:18 +0800
Message-ID: <1565940088-845-1-git-send-email-sam.shih@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, Thierry Reding <thierry.reding@gmail.com>
Cc: Ryder Lee <ryder.lee@mediatek.com>, John Crispin <john@phrozen.org>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, sam shih <sam.shih@mediatek.com>
List-Id: linux-pwm@vger.kernel.org

From: sam shih <sam.shih@mediatek.com>

Changes since v2:
- use num-pwms instead of mediatek,num-pwms.
- rename the member from num_pwms to fallback_num_pwms to make it 
  more obvious that it doesn't represent the actually used value.
- add a dev_warn and a expressive comment to help other developers 
  to not start adding num_pwms in the compatible_data.

Changes since v1:
- add some checks for backwards compatibility.

Sam Shih (3):
  pwm: mediatek: add new property and fix mt7628 pwm
  dt-bindings: pwm: update bindings for MT7628 SoC
  arm: dts: mediatek: add mt7629 pwm support

 .../devicetree/bindings/pwm/pwm-mediatek.txt      |  3 +++
 arch/arm/boot/dts/mt7629.dtsi                     | 14 ++++++++++++++
 drivers/pwm/pwm-mediatek.c                        | 15 ++++++++++++++-
 3 files changed, 31 insertions(+), 1 deletion(-)

Ryder Lee (7):
  pwm: mediatek: add a property "num-pwms"
  pwm: mediatek: allocate the clks array dynamically
  pwm: mediatek: use pwm_mediatek as common prefix
  dt-bindings: pwm: add a property "num-pwms"
  arm64: dts: mt7622: add a property "num-pwms" for PWM node
  arm: dts: mt7623: add a property "num-pwms" for PWM node
  dt-bindings: pwm: update bindings for MT7629 SoC

 .../devicetree/bindings/pwm/pwm-mediatek.txt  |   8 +-
 arch/arm/boot/dts/mt7623.dtsi                 |   1 +
 arch/arm64/boot/dts/mediatek/mt7622.dtsi      |   1 +
 drivers/pwm/pwm-mediatek.c                    | 226 +++++++++---------
 4 files changed, 126 insertions(+), 110 deletions(-)
-- 
2.17.1
