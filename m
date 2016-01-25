From: Richard Weinberger <richard@nod.at>
Subject: [PATCH 14/22] pwm: Fix dependencies for !HAS_IOMEM archs
Date: Mon, 25 Jan 2016 23:24:13 +0100
Message-ID: <1453760661-1444-15-git-send-email-richard@nod.at>
References: <1453760661-1444-1-git-send-email-richard@nod.at>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1453760661-1444-1-git-send-email-richard@nod.at>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org
Cc: Richard Weinberger <richard@nod.at>, Thierry Reding <thierry.reding@gmail.com>, user-mode-linux-devel@lists.sourceforge.net, linux-pwm@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

Not every arch has io memory.
So, unbreak the build by fixing the dependencies.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 drivers/pwm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 8cf0dae..e83aa94 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -150,6 +150,7 @@ config PWM_FSL_FTM
 	tristate "Freescale FlexTimer Module (FTM) PWM support"
 	depends on HAS_IOMEM
 	depends on OF
+	depends on HAS_IOMEM
 	select REGMAP_MMIO
 	help
 	  Generic FTM PWM framework driver for Freescale VF610 and
-- 
1.8.4.5


------------------------------------------------------------------------------
Site24x7 APM Insight: Get Deep Visibility into Application Performance
APM + Mobile APM + RUM: Monitor 3 App instances at just $35/Month
Monitor end-to-end web transactions and take corrective actions now
Troubleshoot faster and improve end-user experience. Signup Now!
http://pubads.g.doubleclick.net/gampad/clk?id=267308311&iu=/4140
