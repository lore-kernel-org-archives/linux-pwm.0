From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v3] pwm: imx: Let PWM be active during suspend
Date: Mon, 11 Dec 2017 08:54:19 -0200
Message-ID: <CAOMZO5DiOx5m1Wew9v5xaqgbcNDR7gio93EKP48bdM3kaqfkoA@mail.gmail.com>
References: <1511220443-26629-1-git-send-email-festevam@gmail.com>
 <20171205084701.GC7386@ulmo> <CAOMZO5DsWN_N5ygkCmNK_Dktp7UANdkSXi+iLacXnVHQ9j53AA@mail.gmail.com>
 <20171211091625.GA10671@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-ot0-f172.google.com ([74.125.82.172]:46004 "EHLO
        mail-ot0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751347AbdLKKyU (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 11 Dec 2017 05:54:20 -0500
Received: by mail-ot0-f172.google.com with SMTP id 103so14329093otj.12
        for <linux-pwm@vger.kernel.org>; Mon, 11 Dec 2017 02:54:20 -0800 (PST)
In-Reply-To: <20171211091625.GA10671@ulmo>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, Rob Herring <robh@kernel.org>, Russell King <linux@arm.linux.org.uk>, Fabio Estevam <fabio.estevam@nxp.com>

Hi Thierry,

On Mon, Dec 11, 2017 at 7:16 AM, Thierry Reding
<thierry.reding@gmail.com> wrote:

> How does it break? Note that you have to change the polarity of the PWM
> signal (in the pwms property) and then remove the "active-low" property
> from the leds device tree node to avoid double inversion.

This is what I tried as per your suggestion:

--- a/arch/arm/boot/dts/imx6qdl-cubox-i.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-cubox-i.dtsi
@@ -42,6 +42,7 @@
 #include "imx6qdl-microsom-ar8035.dtsi"
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/pwm/pwm.h>

 / {
        ir_recv: ir-receiver {
@@ -57,10 +58,9 @@
                pinctrl-0 = <&pinctrl_cubox_i_pwm1>;

                front {
-                       active-low;
                        label = "imx6:red:front";
                        max-brightness = <248>;
-                       pwms = <&pwm1 0 50000>;
+                       pwms = <&pwm1 0 50000 PWM_POLARITY_INVERTED>;
                };
        };

@@ -231,6 +231,7 @@
 };

 &pwm1 {
+       #pwm-cells = <3>;
        status = "okay";
 };

The problem I see is that it seems to be an off-by-one calculation in
the pwm-imx driver for the inverted polarity case.

For example:

# cd /sys/class/leds/imx6\:red\:front/
# echo 0 > brightness (This keeps the LED on with its maximum brightness)
# echo 1 > brightness (This keeps the LED off)
# echo 248 > brightness (This keeps the LED on with its maximum brightness)

When I go to suspend:

# echo enabled > /sys/class/tty/ttymxc0/power/wakeup
# echo mem > /sys/power/state

Then LED goes on with its maximum brightness.

So the issue now is that I need to tell the pwm-imx driver that '0'
means to turn the LED off.

Thanks
