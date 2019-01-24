From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [RFC PATCH v3 2/2] pwm: imx: Configure output to GPIO in
 disabled state
Date: Thu, 24 Jan 2019 11:44:35 +0100
Message-ID: <20190124104435.e6paqwcuz3hizwnv@pengutronix.de>
References: <1544103655-104466-1-git-send-email-michal.vokac@ysoft.com>
 <1544103655-104466-3-git-send-email-michal.vokac@ysoft.com>
 <20181212080154.kcfh57mulypwuscu@pengutronix.de>
 <52ed0614-d1f5-81cb-3b17-8eb137967872@ysoft.com>
 <20181212121255.yg6b4pw7qord7ebi@pengutronix.de>
 <4b0356b7-bc7d-a026-ac90-3f0c5754ed29@ysoft.com>
 <20190124092215.zbu62lhxf667rzvs@pengutronix.de>
 <4004896e-34fc-7160-2f21-30280d96f750@ysoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4004896e-34fc-7160-2f21-30280d96f750@ysoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Michal =?utf-8?B?Vm9rw6HEjQ==?= <michal.vokac@ysoft.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Lukasz Majewski <l.majewski@majess.pl>, Fabio Estevam <fabio.estevam@nxp.com>, Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@karo-electronics.de>, Linus Walleij <linus.walleij@linaro.org>
List-Id: linux-pwm@vger.kernel.org

On Thu, Jan 24, 2019 at 11:12:12AM +0100, Michal Vokáč wrote:
> On 24.1.2019 10:22, Uwe Kleine-König wrote:
> > I think it might be beneficial to allow (or require) that disable acts
> > immediately. But this is not how it used to be and in my discussion with
> > Thierry (IIRC) he required to complete the currently running period.
> 
> I am confused here. IFAIK it always used to be that:
> 
> 	pwm_apply_state(pwm, { .enabled = 0 });
> 
> immediately stops the PWM with:
> 
> 	writel(0, imx->mmio_base + MX3_PWMCR);
> 
> regardless of the period (for pwm-imx).

Then is is a bug since forever (well, or a fact that resulted from the
intended semantic not being documented and the driver author not caring
or knowing better).

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
