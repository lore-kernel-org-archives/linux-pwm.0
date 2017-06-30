From: Zhi Mao <zhi.mao@mediatek.com>
Subject: [PATCH v3 0/6] mediatek: pwm driver add MT2712/MT7622 support
Date: Fri, 30 Jun 2017 14:05:15 +0800
Message-ID: <1498802721-32455-1-git-send-email-zhi.mao@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mailgw01.mediatek.com ([210.61.82.183]:55125 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751729AbdF3GFn (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 30 Jun 2017 02:05:43 -0400
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: john@phrozen.org, Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, linux-pwm@vger.kernel.org
Cc: srv_heupstream@mediatek.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, zhi.mao@mediatek.com, yingjoe.chen@mediatek.com, yt.shen@mediatek.com, sean.wang@mediatek.com, zhenbao.liu@mediatek.com

change in v3:
1. add pwm clk disable in function:mtk_pwm_config()
   for error parameter checking case

Zhi Mao (6):
  pwm: kconfig: modify mediatek information
  pwm: mediatek: fix pwm source clock selection
  pwm: mediatek: fix clock control issue
  pwm: bindings: add MT2712/MT7622 information
  pwm: mediatek: add PWM_CLK_DIV_MAX
  pwm: mediatek: add MT2712/MT7622 support

 .../devicetree/bindings/pwm/pwm-mediatek.txt       |    6 +-
 drivers/pwm/Kconfig                                |    2 +-
 drivers/pwm/pwm-mediatek.c                         |  133 ++++++++++++++------
 3 files changed, 104 insertions(+), 37 deletions(-)
