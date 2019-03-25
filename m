From: Andreas Schwab <schwab@suse.de>
Subject: Re: [PATCH v11 0/2] PWM support for HiFive Unleashed
Date: Mon, 25 Mar 2019 16:54:53 +0100
Message-ID: <mvmbm1zueya.fsf@suse.de>
References: <1553508779-9685-1-git-send-email-yash.shah@sifive.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1553508779-9685-1-git-send-email-yash.shah@sifive.com> (Yash
        Shah's message of "Mon, 25 Mar 2019 15:42:57 +0530")
Sender: linux-kernel-owner@vger.kernel.org
To: Yash Shah <yash.shah@sifive.com>
Cc: palmer@sifive.com, linux-pwm@vger.kernel.org, linux-riscv@lists.infradead.org, thierry.reding@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, sachin.ghadi@sifive.com, paul.walmsley@sifive.com
List-Id: linux-pwm@vger.kernel.org

On Mär 25 2019, Yash Shah <yash.shah@sifive.com> wrote:

> v11
> - Change naming convention for pwm_device and pwm_sifive_ddata pointers
> - Assign of_pwm_xlate_with_flag() to of_xlate func ptr since this driver
>   use three pwm-cells (Issue reported by Andreas Schwab <schwab@suse.de>
> - Other minor fixes

I still don't see any improvement.  FYI, this is the patch I use for the
device tree:

diff --git a/fsbl/ux00_fsbl.dts b/fsbl/ux00_fsbl.dts
index f27cc22..56e94c0 100644
--- a/fsbl/ux00_fsbl.dts
+++ b/fsbl/ux00_fsbl.dts
@@ -432,7 +432,7 @@
 			reg-names = "control";
 			clocks = <&tlclk>;
 			sifive,approx-period = <1000000>;
-			#pwm-cells = <2>;
+			#pwm-cells = <3>;
 		};
 		L46: pwm@10021000 {
 			compatible = "sifive,pwm0";
@@ -442,46 +442,46 @@
 			reg-names = "control";
 			clocks = <&tlclk>;
 			sifive,approx-period = <1000000>;
-			#pwm-cells = <2>;
+			#pwm-cells = <3>;
 		};
 		pwmleds {
 			compatible = "pwm-leds";
 			heartbeat {
-				pwms = <&L45 0 0>;
+				pwms = <&L45 0 1000000 0>;
 				max-brightness = <255>;
 				linux,default-trigger = "heartbeat";
 			};
 			mtd {
-				pwms = <&L45 1 0>;
+				pwms = <&L45 1 1000000 0>;
 				max-brightness = <255>;
 				linux,default-trigger = "mtd";
 			};
 			netdev {
-				pwms = <&L45 2 0>;
+				pwms = <&L45 2 1000000 0>;
 				max-brightness = <255>;
 				linux,default-trigger = "netdev";
 			};
 			panic {
-				pwms = <&L45 3 0>;
+				pwms = <&L45 3 1000000 0>;
 				max-brightness = <255>;
 				linux,default-trigger = "panic";
 			};
 			/* These LEDs are on the tester board */
 /*
 			testled {
-				pwms = <&L46 0 0>;
+				pwms = <&L46 0 1000000 0>;
 				max-brightness = <255>;
 			};
 			green {
-				pwms = <&L46 1 0>;
+				pwms = <&L46 1 1000000 0>;
 				max-brightness = <255>;
 			};
 			red {
-				pwms = <&L46 2 0>;
+				pwms = <&L46 2 1000000 0>;
 				max-brightness = <255>;
 			};
 			blue {
-				pwms = <&L46 3 0>;
+				pwms = <&L46 3 1000000 0>;
 				max-brightness = <255>;
 			};
 */
-- 
2.21.0


Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
