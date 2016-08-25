From: Olliver Schinagl <oliver@schinagl.nl>
Subject: [PATCHv2] pwm: lpc-18xx: use pwm_set_chip_data
Date: Thu, 25 Aug 2016 18:47:09 +0200
Message-ID: <1472143629-29890-1-git-send-email-oliver@schinagl.nl>
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
To: Thierry Reding <thierry.reding@gmail.com>, Ariel D'Alessandro <ariel@vanguardiasur.com>
Cc: Olliver Schinagl <oliver@schinagl.nl>, linux-pwm@vger.kernel.org, Joachim Eastwood <manabian@gmail.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

The lpc18xx driver currently manipulates the pwm_device struct directly
rather then using the pwm_set_chip_data. While the current method may
save a clock cycle or two, it is more obvious that data is set to
the local chip data pointer.

Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
---
Hi,

This is a resend of a patch-series I sent last year. There was no technical
related feedback and so I am re-sending the patch as is. I did rebase it to
Linus's current master.

Changes since v1:
	- removed wrongfully added sun4i patch
	- split patch series into a single patch
	- added author

 drivers/pwm/pwm-lpc18xx-sct.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/pwm/pwm-lpc18xx-sct.c b/drivers/pwm/pwm-lpc18xx-sct.c
index 19dc64c..a630fc5 100644
--- a/drivers/pwm/pwm-lpc18xx-sct.c
+++ b/drivers/pwm/pwm-lpc18xx-sct.c
@@ -413,14 +413,17 @@ static int lpc18xx_pwm_probe(struct platform_device *pdev)
 	}
 
 	for (i = 0; i < lpc18xx_pwm->chip.npwm; i++) {
+		struct lpc18xx_pwm_data *lpc18xx_data;
+
 		pwm = &lpc18xx_pwm->chip.pwms[i];
-		pwm->chip_data = devm_kzalloc(lpc18xx_pwm->dev,
-					      sizeof(struct lpc18xx_pwm_data),
-					      GFP_KERNEL);
-		if (!pwm->chip_data) {
+		lpc18xx_data = devm_kzalloc(lpc18xx_pwm->dev,
+					    sizeof(struct lpc18xx_pwm_data),
+					    GFP_KERNEL);
+		if (!lpc18xx_data) {
 			ret = -ENOMEM;
 			goto remove_pwmchip;
 		}
+		pwm_set_chip_data(pwm, lpc18xx_data);
 	}
 
 	platform_set_drvdata(pdev, lpc18xx_pwm);
-- 
2.8.1
