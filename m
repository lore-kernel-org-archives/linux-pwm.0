Return-Path: <tomasz.figa@gmail.com>
Return-Path: <tomasz.figa@gmail.com>
From: Tomasz Figa <tomasz.figa@gmail.com>
Subject: Re: [PATCH 08/15] pwm: Add new pwm-samsung driver
Date: Tue, 18 Jun 2013 23:42:37 +0200
Message-ID: <1834122.aETH5FyPtO@flatron>
In-Reply-To: <20130618214023.GB1926@mithrandir>
References: <1370467100-10820-1-git-send-email-tomasz.figa@gmail.com> <6439807.SaPozSx51p@flatron> <20130618214023.GB1926@mithrandir>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-pwm.vger.kernel.org>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-pwm@vger.kernel.org, Kukjin Kim <kgene.kim@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Sylwester Nawrocki <sylvester.nawrocki@gmail.com>, Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>, Mark Brown <broonie@kernel.org>, Thomas Abraham <thomas.abraham@linaro.org>

On Tuesday 18 of June 2013 23:40:23 Thierry Reding wrote:
> On Tue, Jun 18, 2013 at 09:41:09PM +0200, Tomasz Figa wrote:
> > On Monday 17 of June 2013 22:29:11 Thierry Reding wrote:
> > > On Wed, Jun 05, 2013 at 11:18:13PM +0200, Tomasz Figa wrote:
> [...]
> 
> > > > +struct samsung_pwm_channel {
> > > > +	unsigned long period_ns;
> > > > +	unsigned long duty_ns;
> > > > +	unsigned long tin_ns;
> > > > +};
> > > > +
> > > > +struct samsung_pwm_chip {
> > > > +	struct pwm_chip chip;
> > > > +	struct samsung_pwm_variant variant;
> > > > +	struct samsung_pwm_channel channels[SAMSUNG_PWM_NUM];
> > > 
> > > The new driver for Renesas did something similar, but I want to
> > > discourage storing per-channel data within the chip structure.
> > > 
> > > The PWM framework provides a way to store this information along
> > > with
> > > the PWM device (see pwm_{set,get}_chip_data()).
> > 
> > OK, this looks good, but in my case is not really useful. I need to
> > access those channel data in my suspend/resume callbacks and
> > obviously I don't have access to any pwm_device there. Any
> > suggestions?
> 
> You do have access to the struct pwm_chip, and that already has an array
> of struct pwm_devices, so you could obtain the driver-specific data
> from those (see pwm_chip.pwms).

Well, if it's legal to access internals of pwm_chip from PWM drivers then 
there is no problem. Based on other subsystems, like regulators or clocks 
I have concluded that this structure should be dereferenced only inside 
PWM core.

Best regards,
Tomasz
