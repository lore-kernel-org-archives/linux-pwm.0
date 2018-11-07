From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: =?iso-8859-1?B?W1JDRqBQQVRDSCx2Miwy?= =?iso-8859-1?B?LzJd?= pwm:
 imx: Configure output to GPIO in disabled state
Date: Wed, 7 Nov 2018 10:33:55 +0100
Message-ID: <20181107093355.e4n3irrnkybqsjvc@pengutronix.de>
References: <1539163920-9442-3-git-send-email-michal.vokac@ysoft.com>
 <20181012085720.GA9451@taurus.defre.kleine-koenig.org>
 <fa96ae2a-c2cc-b47a-1198-5daffa7c865f@ysoft.com>
 <20181012160854.hmgpokxgsrqdzobx@pengutronix.de>
 <e4289ee5-3fc1-2848-1cae-77d29b5ed93c@ysoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <e4289ee5-3fc1-2848-1cae-77d29b5ed93c@ysoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?utf-8?B?Vm9rw6HEjQ==?= Michal <Michal.Vokac@ysoft.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Lukasz Majewski <l.majewski@majess.pl>, Fabio Estevam <fabio.estevam@nxp.com>, Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@karo-electronics.de>, kernel@pengutronix.de
List-Id: linux-pwm@vger.kernel.org

Hello Michal,

just to state it more explicitly, I think the following patch (not even
compile tested) is much preferable over your approach:

diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
index 1d5242c9cde0..af88644b5efb 100644
--- a/drivers/pwm/pwm-imx.c
+++ b/drivers/pwm/pwm-imx.c
@@ -216,7 +216,14 @@ static int imx_pwm_apply_v2(struct pwm_chip *chip, struct pwm_device *pwm,
 			cr |= MX3_PWMCR_POUTC;
 
 		writel(cr, imx->mmio_base + MX3_PWMCR);
-	} else if (cstate.enabled) {
+	} else if (cstate.enabled && state->polarity == PWM_POLARITY_NORMAL) {
+		/*
+		 * When disabled in hardware the output pin goes to 0
+		 * independant of the polarity setting. The expectation of some
+		 * people however is that after disabling the pin goes to the
+		 * inactive level which isn't given for an inversed pwm, so
+		 * only disable for normal polarity.
+		 */
 		writel(0, imx->mmio_base + MX3_PWMCR);
 
 		clk_disable_unprepare(imx->clk_per);

I think it solves most if not all problems you want to address with the
pinctrl stuff.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
