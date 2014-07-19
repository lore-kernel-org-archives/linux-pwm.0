From: Caesar Wang <caesar.wang@rock-chips.com>
Subject: [PATCH v2 0/2] This series adds support for Rockchip SoCs integrated PWM.
Date: Sat, 19 Jul 2014 20:55:27 +0800
Message-ID: <1405774529-26027-1-git-send-email-caesar.wang@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: heiko@sntech.de, thierry.reding@gmail.com, b.galvani@gmail.com
Cc: cf@rock-chips.com, huangtao@rock-chips.com, addy.ke@rock-chips.com, xjq@rock-chips.com, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Caesar Wang <caesar.wang@rock-chips.com>
List-Id: linux-pwm@vger.kernel.org

This patch will make applying on the top of Beniamino's submission,
the Beniamino's submission come from [1].

[1]:
https://git.kernel.org/cgit/linux/kernel/git/thierry.reding/linux-pwm.git/log/?h=for-next

Beniamino's submission won't be used from genenation Rockchip SoCs.
So I have to add the new pwm for next genenation Rockchip SoCs.

Tested on RK3288 SDK board.

Changes in v2:
    * address comments from Beniamino Galvani Reding:
      - remove #include <linux/of_address.h>. 
      - of_iomap be removed,and devm_ioremap replace it.
      - remove a line no be used.

Caesar Wang (2):
  [PATCH v2 1/2] pwm: add this patch to introduce for rk-pwm and vop-pwm

  [PATCH v2 2/2] pwm: add this patch to support the new pwm of Rockchip SoCs

 .../devicetree/bindings/pwm/pwm-rockchip.txt       | 13 +--
 drivers/pwm/pwm-rockchip.c                         | 97 ++++++++++++++++++----
 2 files changed, 87 insertions(+), 23 deletions(-)

-- 
1.9.1
