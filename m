From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: =?iso-8859-1?B?W1JDRqBQQVRDSCx2Miwy?= =?iso-8859-1?B?LzJd?= pwm:
 imx: Configure output to GPIO in disabled state
Date: Sun, 14 Oct 2018 22:24:57 +0200
Message-ID: <20181014202457.dohwgz3frgcpdpy6@pengutronix.de>
References: <1539163920-9442-3-git-send-email-michal.vokac@ysoft.com>
 <20181012085720.GA9451@taurus.defre.kleine-koenig.org>
 <fa96ae2a-c2cc-b47a-1198-5daffa7c865f@ysoft.com>
 <20181012160854.hmgpokxgsrqdzobx@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181012160854.hmgpokxgsrqdzobx@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: =?utf-8?B?Vm9rw6HEjQ==?= Michal <Michal.Vokac@ysoft.com>
Cc: Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, Lukasz Majewski <l.majewski@majess.pl>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@karo-electronics.de>
List-Id: linux-pwm@vger.kernel.org

Hello,

On Fri, Oct 12, 2018 at 06:08:54PM +0200, Uwe Kleine-König wrote:
> > >> +	if (PTR_ERR(imx_chip->pwm_gpiod) == -EPROBE_DEFER) {
> > > 
> > > You must not use PTR_ERR on a value that might not contain an error
> > > pointer.
> > 
> > OK, thank you for valuable info.
> > So it seems like the I2C folks are in troubles as well:
> > 
> > 	https://elixir.bootlin.com/linux/latest/source/drivers/i2c/busses/i2c-imx.c#L996
> 
> correct. I cannot find this documented though.

I found in LDD3[1], chapter 11 on page 295:

	If you need the actual error code, it can be extracted with:

		long PTR_ERR(const void *ptr);

	You should use PTR_ERR only on a value for which IS_ERR returns a true
	value; any other value is a valid pointer.

That is probably where I have my claim from. There is no further
explanation though, so I'll post a patch adding a comment to the
definition of PTR_ERR to find out if there is a relevant reason.

Best regards
Uwe

[1] https://lwn.net/Kernel/LDD3/

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
