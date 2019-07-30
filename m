From: Stephen Boyd <swboyd@chromium.org>
Subject: [PATCH v6 36/57] pwm: Remove dev_err() usage after platform_get_irq()
Date: Tue, 30 Jul 2019 11:15:36 -0700
Message-ID: <20190730181557.90391-37-swboyd@chromium.org>
References: <20190730181557.90391-1-swboyd@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190730181557.90391-1-swboyd@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-pwm@vger.kernel.org

We don't need dev_err() messages when platform_get_irq() fails now that
platform_get_irq() prints an error message itself when something goes
wrong. Let's remove these prints with a simple semantic patch.

// <smpl>
@@
expression ret;
struct platform_device *E;
@@

ret =
(
platform_get_irq(E, ...)
|
platform_get_irq_byname(E, ...)
);

if ( \( ret < 0 \| ret <= 0 \) )
{
(
-if (ret != -EPROBE_DEFER)
-{ ...
-dev_err(...);
-... }
|
...
-dev_err(...);
)
...
}
// </smpl>

While we're here, remove braces on if statements that only have one
statement (manually).

Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---

Please apply directly to subsystem trees

 drivers/pwm/pwm-sti.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-sti.c b/drivers/pwm/pwm-sti.c
index 20450e34ad57..1508616d794c 100644
--- a/drivers/pwm/pwm-sti.c
+++ b/drivers/pwm/pwm-sti.c
@@ -564,10 +564,8 @@ static int sti_pwm_probe(struct platform_device *pdev)
 		return PTR_ERR(pc->regmap);
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "Failed to obtain IRQ\n");
+	if (irq < 0)
 		return irq;
-	}
 
 	ret = devm_request_irq(&pdev->dev, irq, sti_pwm_interrupt, 0,
 			       pdev->name, pc);
-- 
Sent by a computer through tubes
