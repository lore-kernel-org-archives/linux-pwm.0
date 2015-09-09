From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: [PATCH] pwm: atmel-hlcdc: add sama5d2 SoC support.
Date: Wed, 9 Sep 2015 15:32:30 +0200
Message-ID: <1441805550-11553-1-git-send-email-nicolas.ferre@atmel.com>
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
To: Boris BREZILLON <boris.brezillon@free-electrons.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, thierry.reding@gmail.com
Cc: linux-pwm@vger.kernel.org, Nicolas Ferre <nicolas.ferre@atmel.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

Add sama5d2 hlcdc backlight PWM support. This chip doesn't have to deal with an
errata, so it's a simple addition of the mfd compatible string.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 drivers/pwm/pwm-atmel-hlcdc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pwm/pwm-atmel-hlcdc.c b/drivers/pwm/pwm-atmel-hlcdc.c
index fa5feaba25a5..6974a0ef986e 100644
--- a/drivers/pwm/pwm-atmel-hlcdc.c
+++ b/drivers/pwm/pwm-atmel-hlcdc.c
@@ -222,6 +222,9 @@ static const struct of_device_id atmel_hlcdc_dt_ids[] = {
 		.data = &atmel_hlcdc_pwm_at91sam9x5_errata,
 	},
 	{
+		.compatible = "atmel,sama5d2-hlcdc",
+	},
+	{
 		.compatible = "atmel,sama5d3-hlcdc",
 		.data = &atmel_hlcdc_pwm_sama5d3_errata,
 	},
-- 
2.1.3
