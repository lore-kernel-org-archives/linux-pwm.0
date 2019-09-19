From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH] pwm: rockchip: simplify rockchip_pwm_get_state()
Date: Thu, 19 Sep 2019 11:17:27 +0200
Message-ID: <20190919091728.24756-1-linux@rasmusvillemoes.dk>
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
To: Thierry Reding <thierry.reding@gmail.com>, Heiko Stuebner <heiko@sntech.de>
Cc: linux-pwm@vger.kernel.org, Rasmus Villemoes <linux@rasmusvillemoes.dk>, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, David Wu <david.wu@rock-chips.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

The way state->enabled is computed is rather convoluted and hard to
read - both branches of the if() actually do the exact same thing. So
remove the if(), and further simplify "<boolean condition> ? true :
false" to "<boolean condition>".

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
I stumbled on this while trying to understand how the pwm subsystem
works. This patch is a semantic no-op, but it's also possible that,
say, the first branch simply contains a "double negative" so either
the != should be == or the "false : true" should be "true : false".

 drivers/pwm/pwm-rockchip.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/pwm/pwm-rockchip.c b/drivers/pwm/pwm-rockchip.c
index 51b96cb7dd25..54c6399e3f00 100644
--- a/drivers/pwm/pwm-rockchip.c
+++ b/drivers/pwm/pwm-rockchip.c
@@ -83,12 +83,7 @@ static void rockchip_pwm_get_state(struct pwm_chip *chip,
 	state->duty_cycle =  DIV_ROUND_CLOSEST_ULL(tmp, clk_rate);
 
 	val = readl_relaxed(pc->base + pc->data->regs.ctrl);
-	if (pc->data->supports_polarity)
-		state->enabled = ((val & enable_conf) != enable_conf) ?
-				 false : true;
-	else
-		state->enabled = ((val & enable_conf) == enable_conf) ?
-				 true : false;
+	state->enabled = ((val & enable_conf) == enable_conf);
 
 	if (pc->data->supports_polarity) {
 		if (!(val & PWM_DUTY_POSITIVE))
-- 
2.20.1
