From: Hao Zhang <hao5781286-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v3 4/6] DEV: CLK: add function to check the
 using clock name of driver.
Date: Mon, 26 Nov 2018 00:21:18 +0800
Message-ID: <20181125162118.GA5358@arx-s1>
Reply-To: hao5781286-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sunxi+bncBDKITZOARQMBBBMY5PPQKGQEDMLECTA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, sboyd-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, hao5781286-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-pwm@vger.kernel.org

In some situation we want to check clock whether is we want
and after the driver been probed use to change different clock source.

Signed-off-by: Hao Zhang <hao5781286-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/clk/clk.c            | 6 ++++++
 include/linux/clk-provider.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index d31055a..3d2c2cd 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -3466,6 +3466,12 @@ static int devm_clk_hw_match(struct device *dev, void *res, void *data)
 	return hw == data;
 }
 
+bool devm_clk_name_match(struct clk *clk, const char *string)
+{
+	return match_string(&clk->con_id, 1, string) == 0;
+}
+EXPORT_SYMBOL_GPL(devm_clk_name_match);
+
 /**
  * devm_clk_unregister - resource managed clk_unregister()
  * @clk: clock to unregister
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 08b1aa7..5cd2eed 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -764,6 +764,7 @@ struct clk *devm_clk_register(struct device *dev, struct clk_hw *hw);
 int __must_check clk_hw_register(struct device *dev, struct clk_hw *hw);
 int __must_check devm_clk_hw_register(struct device *dev, struct clk_hw *hw);
 
+bool devm_clk_name_match(struct clk *clk, const char *string);
 void clk_unregister(struct clk *clk);
 void devm_clk_unregister(struct device *dev, struct clk *clk);
 
-- 
2.7.4
