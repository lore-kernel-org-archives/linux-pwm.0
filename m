From: David Wu <david.wu@rock-chips.com>
Subject: [PATCH v2 0/7] Add rk3328 pwm support
Date: Sat,  8 Jul 2017 12:03:42 +0800
Message-ID: <1499486629-9659-1-git-send-email-david.wu@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: thierry.reding@gmail.com, heiko@sntech.de, boris.brezillon@free-electrons.com, robh+dt@kernel.org
Cc: mark.rutland@arm.com, huangtao@rock-chips.com, linux-pwm@vger.kernel.org, catalin.marinas@arm.com, briannorris@chromium.org, dianders@chromium.org, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, David Wu <david.wu@rock-chips.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

There are two features of rk3328 pwm module.
 - PWM APB and function clocks are different.
 - Add pwm atomic hardware update

David Wu (7):
  pwm: rockchip: Add APB and function both clocks support
  pwm: rockchip: Remove the judge from return value of pwm_config
  pwm: rockchip: Remove the dumplicate rockchip_pwm_ops ops
  pwm: rockchip: Use pwm_apply instead of the pwm_enable
  pwm: rockchip: Move the configuration of polarity from
    rockchip_pwm_set_enable() to rockchip_pwm_config()
  pwm: rockchip: Add rk3328 pwm support
  arm64: dts: rockchip: Add pwm nodes for rk3328

 .../devicetree/bindings/pwm/pwm-rockchip.txt       |   9 +-
 arch/arm64/boot/dts/rockchip/rk3328.dtsi           |  45 ++++
 drivers/pwm/pwm-rockchip.c                         | 275 ++++++++++++++-------
 3 files changed, 236 insertions(+), 93 deletions(-)

-- 
1.9.1
