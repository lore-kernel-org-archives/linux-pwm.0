From: Zhi Mao <zhi.mao@mediatek.com>
Subject: [PATCH v2 0/6] mediatek: pwm driver add MT2712/MT7622 support
Date: Fri, 23 Jun 2017 13:08:19 +0800
Message-ID: <1498194505-30930-1-git-send-email-zhi.mao@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: john@phrozen.org, Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, linux-pwm@vger.kernel.org
Cc: srv_heupstream@mediatek.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, zhi.mao@mediatek.com, yingjoe.chen@mediatek.com, yt.shen@mediatek.com, sean.wang@mediatek.com, zhenbao.liu@mediatek.com
List-Id: linux-pwm@vger.kernel.org

change in v2:
1. add error check for enable colock control flow
2. use "goto err_clk(main/top)" coding style, for preparing clk error case
3. remove comments inline /*===*/
4. move "PWM_CLK_DIV_MAX" modification to its own patch
5. move pwm source clock selection to its own patch

Zhi Mao (6):
  pwm: kconfig: modify mediatek information
  pwm: mediatek: fix pwm source clock selection
  pwm: mediatek: fix clock control issue
  pwm: bindings: add MT2712/MT7622 information
  pwm: mediatek: add PWM_CLK_DIV_MAX
  pwm: mediatek: add MT2712/MT7622 support

 .../devicetree/bindings/pwm/pwm-mediatek.txt       |    6 +-
 drivers/pwm/Kconfig                                |    2 +-
 drivers/pwm/pwm-mediatek.c                         |  132 ++++++++++++++------
 3 files changed, 103 insertions(+), 37 deletions(-)
