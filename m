From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [RCF PATCH,v2,2/2] pwm: imx: Configure output to GPIO in
 disabled state
Date: Thu, 22 Nov 2018 17:23:59 +0100
Message-ID: <20181122162359.ufngpgxkenlmgqni@pengutronix.de>
References: <20181108191855.zuon3ecv4yjfbs7g@pengutronix.de>
 <283cfef3-16d0-8bd4-e306-6e34d44c3a86@ysoft.com>
 <20181109165555.vqbiwh4hlcnozdna@pengutronix.de>
 <20181114113449.GB2620@ulmo>
 <20181114215120.vddykljqyavm64wj@pengutronix.de>
 <20181115152545.GA8611@ulmo>
 <20181115203733.qvonika6yhn2bsnb@pengutronix.de>
 <20181116083430.7f1d8452@ipc1.ka-ro>
 <20181116082557.l2ljgu3hsu7tvdci@pengutronix.de>
 <91640f9b-d219-553e-043a-c6151f2f68d7@ysoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <91640f9b-d219-553e-043a-c6151f2f68d7@ysoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?utf-8?B?Vm9rw6HEjQ==?= Michal <Michal.Vokac@ysoft.com>
Cc: Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>, Thierry Reding <thierry.reding@gmail.com>, Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, Lukasz Majewski <l.majewski@majess.pl>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, "kernel@pengutronix.de" <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, Linus Walleij <linus.walleij@linaro.org>, viresh kumar <viresh.kumar@linaro.org>
List-Id: linux-pwm@vger.kernel.org

Hello Michal,

On Thu, Nov 22, 2018 at 03:42:14PM +0000, Vokáč Michal wrote:
> On 16.11.2018 09:25, Uwe Kleine-König wrote:
> > On Fri, Nov 16, 2018 at 08:34:30AM +0100, Lothar Waßmann wrote:
> > > No. You can disable the output driver via pinctrl, so that only the
> > > selected pull-up/down is relevant. The pin function and GPIO register
> > > settings don't matter at all in this case.
> 
> Lothar, please can you be more specific how would you do that? IFAIK the
> pull-up/down internal resistors have effect only if the pin is configured
> as GPIO *input* (on i.MX6 at least). See the TRM, 29.4.2.2 Output driver:
> 
>   "Internal pull-up, pull-down resistors, and pad keeper are disabled in
>    output mode."
> 
> > Is this about DSE=HI-Z in the pad control register? I didn't know about
> > this. I see this exists on i.MX6 but not on i.MX25. Also i.MX51 doesn't
> > seem to have this feature.
> 
> Uwe, I also did not find the DSE option on other SoCs in their respective
> manuals and source code. But even if it would be available on all SoCs
> I still think it is not enough.

If I understand Lothar correctly and this is about the pad control
register, there is no need for software support. You just specify the
value you want to have written to the pad register in the device tree.

So I'd expect this to really work on i.MX6 but not the earlier SoCs
without a gpio specifier.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
