From: Jernej Skrabec <jernej.skrabec-gGgVlfcn5nU@public.gmane.org>
Subject: [PATCH 3/6] pwm: sun4i: Add a quirk for bus clock
Date: Fri, 26 Jul 2019 20:40:42 +0200
Message-ID: <20190726184045.14669-4-jernej.skrabec@siol.net>
References: <20190726184045.14669-1-jernej.skrabec@siol.net>
Reply-To: jernej.skrabec-gGgVlfcn5nU@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sunxi+bncBDQNBWPU7YERBPUS5XUQKGQEE7EPRTQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20190726184045.14669-1-jernej.skrabec-gGgVlfcn5nU@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, mripard-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-pwm@vger.kernel.org

H6 PWM core needs bus clock to be enabled in order to work.

Add a quirk for it.

Signed-off-by: Jernej Skrabec <jernej.skrabec-gGgVlfcn5nU@public.gmane.org>
---
 drivers/pwm/pwm-sun4i.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
index 1b7be8fbde86..7d3ac3f2dc3f 100644
--- a/drivers/pwm/pwm-sun4i.c
+++ b/drivers/pwm/pwm-sun4i.c
@@ -72,6 +72,7 @@ static const u32 prescaler_table[] = {
 };
 
 struct sun4i_pwm_data {
+	bool has_bus_clock;
 	bool has_prescaler_bypass;
 	bool has_reset;
 	unsigned int npwm;
@@ -79,6 +80,7 @@ struct sun4i_pwm_data {
 
 struct sun4i_pwm_chip {
 	struct pwm_chip chip;
+	struct clk *bus_clk;
 	struct clk *clk;
 	struct reset_control *rst;
 	void __iomem *base;
@@ -382,6 +384,16 @@ static int sun4i_pwm_probe(struct platform_device *pdev)
 		reset_control_deassert(pwm->rst);
 	}
 
+	if (pwm->data->has_bus_clock) {
+		pwm->bus_clk = devm_clk_get(&pdev->dev, "bus");
+		if (IS_ERR(pwm->bus_clk)) {
+			ret = PTR_ERR(pwm->bus_clk);
+			goto err_bus;
+		}
+
+		clk_prepare_enable(pwm->bus_clk);
+	}
+
 	pwm->chip.dev = &pdev->dev;
 	pwm->chip.ops = &sun4i_pwm_ops;
 	pwm->chip.base = -1;
@@ -402,6 +414,8 @@ static int sun4i_pwm_probe(struct platform_device *pdev)
 	return 0;
 
 err_pwm_add:
+	clk_disable_unprepare(pwm->bus_clk);
+err_bus:
 	reset_control_assert(pwm->rst);
 
 	return ret;
@@ -416,6 +430,7 @@ static int sun4i_pwm_remove(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	clk_disable_unprepare(pwm->bus_clk);
 	reset_control_assert(pwm->rst);
 
 	return 0;
-- 
2.22.0
