Return-Path: <festevam@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20131125031029.GC11613@S2101-09.ap.freescale.net>
References: <20131122142231.GA1741@ulmo.nvidia.com>
	<20131122145224.GO14725@sirena.org.uk>
	<20131125031029.GC11613@S2101-09.ap.freescale.net>
Date: Mon, 25 Nov 2013 11:26:53 -0200
Message-ID: <CAOMZO5CtNnma8Sv35P3jeNYQiLV=jdmN0Q7w2_LFMOj-nTbPZg@mail.gmail.com>
Subject: Re: [PATCH] backlight: pwm_bl: Do not make the regulator mandatory
From: Fabio Estevam <festevam@gmail.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pwm.vger.kernel.org>
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Mark Brown <broonie@kernel.org>, Fabio Estevam <fabio.estevam@freescale.com>, =?UTF-8?B?TWFyZWsgVmHFoXV0?= <marex@denx.de>, Thierry Reding <thierry.reding@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-pwm@vger.kernel.org

Hi Shawn,

On Mon, Nov 25, 2013 at 1:10 AM, Shawn Guo <shawn.guo@linaro.org> wrote:

> Hmm, I'm seeing this breakage on v3.13-rc1 now with the following line
> in the kernel log.
>
>   pwm-backlight backlight.18: dummy supplies not allowed
>
> What's missing here?

Yes, this is weird.

linux-next 20131120: backlight fails
linux-next 20131122: backlight works
linux-next 20131125: backlight fails

Looks like we need to apply this one to make sure backlight works:
http://permalink.gmane.org/gmane.linux.ports.arm.kernel/281826

Regards,

Fabio Estevam
