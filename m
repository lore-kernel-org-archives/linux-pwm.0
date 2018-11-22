From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [RCF PATCH,v2,2/2] pwm: imx: Configure output to GPIO in
 disabled state
Date: Thu, 22 Nov 2018 20:03:21 +0100
Message-ID: <20181122190321.ktqegs7kpvhcemvi@pengutronix.de>
References: <20181109165555.vqbiwh4hlcnozdna@pengutronix.de>
 <20181114113449.GB2620@ulmo>
 <20181114215120.vddykljqyavm64wj@pengutronix.de>
 <20181115152545.GA8611@ulmo>
 <20181115203733.qvonika6yhn2bsnb@pengutronix.de>
 <20181116083430.7f1d8452@ipc1.ka-ro>
 <20181116082557.l2ljgu3hsu7tvdci@pengutronix.de>
 <91640f9b-d219-553e-043a-c6151f2f68d7@ysoft.com>
 <20181122162359.ufngpgxkenlmgqni@pengutronix.de>
 <b332b319-cbb3-547f-c8b7-1dd275c1596d@ysoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <b332b319-cbb3-547f-c8b7-1dd275c1596d@ysoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?utf-8?B?Vm9rw6HEjQ==?= Michal <Michal.Vokac@ysoft.com>
Cc: Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>, Thierry Reding <thierry.reding@gmail.com>, Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, Lukasz Majewski <l.majewski@majess.pl>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, "kernel@pengutronix.de" <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, Linus Walleij <linus.walleij@linaro.org>, viresh kumar <viresh.kumar@linaro.org>
List-Id: linux-pwm@vger.kernel.org

Hello Michal,

On Thu, Nov 22, 2018 at 04:46:39PM +0000, Vokáč Michal wrote:
> On 22.11.2018 17:23, Uwe Kleine-König wrote:
> > On Thu, Nov 22, 2018 at 03:42:14PM +0000, Vokáč Michal wrote:
> >> On 16.11.2018 09:25, Uwe Kleine-König wrote:
> >>> On Fri, Nov 16, 2018 at 08:34:30AM +0100, Lothar Waßmann wrote:
> >>>> No. You can disable the output driver via pinctrl, so that only the
> >>>> selected pull-up/down is relevant. The pin function and GPIO register
> >>>> settings don't matter at all in this case.
> >>
> >> Lothar, please can you be more specific how would you do that? IFAIK the
> >> pull-up/down internal resistors have effect only if the pin is configured
> >> as GPIO *input* (on i.MX6 at least). See the TRM, 29.4.2.2 Output driver:
> >>
> >>    "Internal pull-up, pull-down resistors, and pad keeper are disabled in
> >>     output mode."

This would mean you'd have to rely on an external pull up for your use
case. I wouldn't be surprised however if DSE=0 wouldn't count as "output
mode". Given the reliability of NXP documentation I wouldn't bet neither
on one nor the other possibility.

> > So I'd expect this to really work on i.MX6 but not the earlier SoCs
> > without a gpio specifier.
> 
> Maybe you would expect it to work but I already tested and measured
> that weeks ago ;) It did not work.

Which pin/gpio do we talk about? Which i.MX6 variant did you test this
on? (Assuming i.MX6D or i.MX6Q and PAD_DISP0_DATA09, did you try setting

	IOMUXC_SW_MUX_CTL_PAD_DISP0_DATA09 (0x020E0194) = 0x00000005
	IOMUXC_SW_PAD_CTL_PAD_DISP0_DATA09 (0x020E04A8) = 0x0000b080

and then play with GPIO 4.30 direction and output value?)

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
