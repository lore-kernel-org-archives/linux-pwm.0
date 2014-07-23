From: Caesar Wang <caesar.wang@rock-chips.com>
Subject: [PATCH v3 0/2] This series adds support for RK3288 SoC integrated PWM
Date: Wed, 23 Jul 2014 14:38:39 +0800
Message-ID: <1406097521-6457-1-git-send-email-caesar.wang@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: heiko@sntech.de, thierry.reding@gmail.com, b.galvani@gmail.com
Cc: linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, cf@rock-chips.com, huangtao@rock-chips.com, hj@rock-chips.com, xjq@rock-chips.com, addy.ke@rock-chips.com, Caesar Wang <caesar.wang@rock-chips.com>
List-Id: linux-pwm@vger.kernel.org

This patch will make applying on the top of Beniamino's submission,
the Beniamino's submission come from [1].

[1]:
    https://git.kernel.org/cgit/linux/kernel/git/thierry.reding/linux-pwm.git/log/?h=for-next

    Beniamino's submission won't be used from genenation Rockchip SoCs.
    So I have to add the new pwm for next genenation Rockchip SoCs.

    Tested on RK3288 SDK board.
   
Changes in v3:
    * address comments from Thierry Reding:
    - fix PWM document deccribes. 
    - add a description for [PATCH v3 2/2].
    - renamed the PWM registers
    - Changed in rockchip_pwm_data struct
    - remove the devm_ioremap(),fixed in lcdc driver.

Changes in v2:
    * address comments from Beniamino Galvani:
    - remove #include <linux/of_address.h>. 
    - of_iomap be removed,and devm_ioremap replace it.
    - remove a line no be used.

Caesar Wang (2):
  pwm: rockchip: document RK3288 SoC compatible
  pwm: rockchip: Added to support for RK3288 SoC

 .../devicetree/bindings/pwm/pwm-rockchip.txt       |   5 +-
 drivers/pwm/pwm-rockchip.c                         | 141 ++++++++++++++++++---
 2 files changed, 126 insertions(+), 20 deletions(-)

-- 
1.9.1
