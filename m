From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: [PATCH] pwm: atmel-hlcdc: Prevent div by zero
Date: Thu, 18 Dec 2014 21:05:30 +0100
Message-ID: <1418933131-12270-1-git-send-email-boris.brezillon@free-electrons.com>
References: <20141218094442.GA24383@ulmo>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20141218094442.GA24383@ulmo>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org
Cc: Jim Davis <jim.epost@gmail.com>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, Boris Brezillon <boris.brezillon@free-electrons.com>
List-Id: linux-pwm@vger.kernel.org

The slow and system clock should never return a rate of zero, but this
might happen if the clocks property defined in the DT is referencing the
wrong clocks.
Prevent any division by zero from happening by testing the clk_freq value
before calling do_div.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/pwm/pwm-atmel-hlcdc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pwm/pwm-atmel-hlcdc.c b/drivers/pwm/pwm-atmel-hlcdc.c
index e7a785f..522f707 100644
--- a/drivers/pwm/pwm-atmel-hlcdc.c
+++ b/drivers/pwm/pwm-atmel-hlcdc.c
@@ -64,6 +64,9 @@ static int atmel_hlcdc_pwm_config(struct pwm_chip *c,
 
 	if (!chip->errata || !chip->errata->slow_clk_erratum) {
 		clk_freq = clk_get_rate(new_clk);
+		if (!clk_freq)
+			return -EINVAL;
+
 		clk_period_ns = (u64)NSEC_PER_SEC * 256;
 		do_div(clk_period_ns, clk_freq);
 	}
@@ -73,6 +76,9 @@ static int atmel_hlcdc_pwm_config(struct pwm_chip *c,
 	    clk_period_ns > period_ns) {
 		new_clk = hlcdc->sys_clk;
 		clk_freq = clk_get_rate(new_clk);
+		if (!clk_freq)
+			return -EINVAL;
+
 		clk_period_ns = (u64)NSEC_PER_SEC * 256;
 		do_div(clk_period_ns, clk_freq);
 	}
-- 
1.9.1
