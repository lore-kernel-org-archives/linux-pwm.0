From: Caesar Wang <caesar.wang@rock-chips.com>
Subject: [PATCH v4 0/2] This series adds support for RK3288 SoC integrated PWM
Date: Thu, 24 Jul 2014 18:21:33 +0800
Message-ID: <1406197295-10604-1-git-send-email-caesar.wang@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: thierry.reding@gmail.com, heiko@sntech.de, b.galvani@gmail.com, robh+dt@kernel.org, ijc+devicetree@hellion.org.uk, rdunlap@infradead.org, galak@codeaurora.org
Cc: cf@rock-chips.com, huangtao@rock-chips.com, xjq@rock-chips.com, addy.ke@rock-chips.com, cjf@rock-chips.com, hj@rock-chips.com, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, Caesar Wang <caesar.wang@rock-chips.com>
List-Id: linux-pwm@vger.kernel.org

This patch will make applying on the top of Beniamino's submission,
the Beniamino's submission come from [1].

[1]:
    https://git.kernel.org/cgit/linux/kernel/git/thierry.reding/linux-p=
wm.git/log/?h=3Dfor-next

    Beniamino's submission won't be used from genenation Rockchip SoCs.
    So I have to add the new pwm for next genenation Rockchip SoCs.

    Tested on RK3288 SDK board.

Changes in v4:
    * address comments from Heiko St=C3=BCbner:
    - fix the copyright for ROCKCHIP, Inc.=20
    - remove rockchip_pwm_set_enable_vop,then it instead of rockchip_pw=
m_set_enable_v2.
  =20
Changes in v3:
    * address comments from Thierry Reding:
    - fix PWM document deccribes.=20
    - add a description for [PATCH v3 2/2].
    - renamed the PWM registers
    - Changed in rockchip_pwm_data struct
    - remove the devm_ioremap(),fixed in lcdc driver.

Changes in v2:
    * address comments from Beniamino Galvani:
    - remove #include <linux/of_address.h>.=20
    - of_iomap be removed,and devm_ioremap replace it.
    - remove a line no be used.

Caesar Wang (2):
  pwm: rockchip: document RK3288 SoC compatible
  pwm: rockchip: Added to support for RK3288 SoC

 .../devicetree/bindings/pwm/pwm-rockchip.txt       |   5 +-
 drivers/pwm/pwm-rockchip.c                         | 124 +++++++++++++=
++++----
 2 files changed, 109 insertions(+), 20 deletions(-)

--=20
1.9.1
