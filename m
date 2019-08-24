From: Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH 3/3] pwm: bcm2835: suppress error message during deferred probe
Date: Sat, 24 Aug 2019 09:07:25 +0200
Message-ID: <1566630445-4599-4-git-send-email-wahrenst@gmx.net>
References: <1566630445-4599-1-git-send-email-wahrenst@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1566630445-4599-1-git-send-email-wahrenst@gmx.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Thierry Reding <thierry.reding@gmail.com>, Eric Anholt <eric@anholt.net>, Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>
Cc: linux-pwm@vger.kernel.org, Stefan Wahren <wahrenst@gmx.net>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

This suppresses error messages in case the PWM clock isn't ready yet.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
---
 drivers/pwm/pwm-bcm2835.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-bcm2835.c b/drivers/pwm/pwm-bcm2835.c
index 2c82386..ce362be 100644
--- a/drivers/pwm/pwm-bcm2835.c
+++ b/drivers/pwm/pwm-bcm2835.c
@@ -153,7 +153,10 @@ static int bcm2835_pwm_probe(struct platform_device *pdev)

 	pc->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(pc->clk)) {
-		dev_err(&pdev->dev, "clock not found: %ld\n", PTR_ERR(pc->clk));
+		if (PTR_ERR(pc->clk) != -EPROBE_DEFER) {
+			dev_err(&pdev->dev, "clock not found: %ld\n",
+				PTR_ERR(pc->clk));
+		}
 		return PTR_ERR(pc->clk);
 	}

--
2.7.4
