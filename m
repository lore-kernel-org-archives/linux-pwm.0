From: Vladimir Zapolskiy <vz@mleia.com>
Subject: [PATCH 2/4] pwm: lpc32xx: fix warnings from common clock framework
Date: Tue, 13 Oct 2015 03:20:51 +0300
Message-ID: <1444695653-23491-3-git-send-email-vz@mleia.com>
References: <1444695653-23491-1-git-send-email-vz@mleia.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from li271-223.members.linode.com ([178.79.152.223]:39545 "EHLO
	mail.mleia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752812AbbJMAVC (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
	Mon, 12 Oct 2015 20:21:02 -0400
In-Reply-To: <1444695653-23491-1-git-send-email-vz@mleia.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Alexandre Pereira da Silva <aletes.xgr@gmail.com>
Cc: linux-pwm@vger.kernel.org

As a preparatory change for switching LPC32xx mach support to common
clock framework fix clk_enable/clk_disable calls without matching
clk_prepare/clk_unprepare.

If the driver is used on a machine with common clock framework,
the following warning is generated and it is fixed by this change:

    # echo 1 > /sys/bus/platform/drivers/lpc32xx-pwm/4005c000.pwm/pwm/pwmchip0/pwm0/enable
    ------------[ cut here ]------------
    WARNING: CPU: 0 PID: 701 at drivers/clk/clk.c:727 clk_core_enable+0x2c/0xa4()
    Modules linked in: sc16is7xx
    CPU: 0 PID: 701 Comm: sh Tainted: G        W       4.3.0-rc2+ #171
    Hardware name: LPC32XX SoC (Flattened Device Tree)
    Backtrace:
    [<>] (dump_backtrace) from [<>] (show_stack+0x18/0x1c)
    [<>] (show_stack) from [<>] (dump_stack+0x20/0x28)
    [<>] (dump_stack) from [<>] (warn_slowpath_common+0x90/0xb8)
    [<>] (warn_slowpath_common) from [<>] (warn_slowpath_null+0x24/0x2c)
    [<>] (warn_slowpath_null) from [<>] (clk_core_enable+0x2c/0xa4)
    [<>] (clk_core_enable) from [<>] (clk_enable+0x24/0x38)
    [<>] (clk_enable) from [<>] (lpc32xx_pwm_enable+0x1c/0x40)
    [<>] (lpc32xx_pwm_enable) from [<>] (pwm_enable+0x48/0x5c)
    [<>] (pwm_enable) from [<>] (pwm_enable_store+0x5c/0x78)
    [<>] (pwm_enable_store) from [<>] (dev_attr_store+0x20/0x2c)
    [<>] (dev_attr_store) from [<>] (sysfs_kf_write+0x44/0x50)
    [<>] (sysfs_kf_write) from [<>] (kernfs_fop_write+0x134/0x194)
    [<>] (kernfs_fop_write) from [<>] (__vfs_write+0x34/0xdc)
    [<>] (__vfs_write) from [<>] (vfs_write+0xb8/0x140)
    [<>] (vfs_write) from [<>] (SyS_write+0x50/0x90)
    [<>] (SyS_write) from [<>] (ret_fast_syscall+0x0/0x38)

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
 drivers/pwm/pwm-lpc32xx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-lpc32xx.c b/drivers/pwm/pwm-lpc32xx.c
index ce8ab20..63468a8 100644
--- a/drivers/pwm/pwm-lpc32xx.c
+++ b/drivers/pwm/pwm-lpc32xx.c
@@ -83,7 +83,7 @@ static int lpc32xx_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 	u32 val;
 	int ret;
 
-	ret = clk_enable(lpc32xx->clk);
+	ret = clk_prepare_enable(lpc32xx->clk);
 	if (ret)
 		return ret;
 
@@ -103,7 +103,7 @@ static void lpc32xx_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 	val &= ~PWM_ENABLE;
 	writel(val, lpc32xx->base + (pwm->hwpwm << 2));
 
-	clk_disable(lpc32xx->clk);
+	clk_disable_unprepare(lpc32xx->clk);
 }
 
 static const struct pwm_ops lpc32xx_pwm_ops = {
-- 
2.1.4
